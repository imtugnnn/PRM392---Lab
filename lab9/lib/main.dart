import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/product.dart';
import 'services/storage_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 9 JSON Storage',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const ProductScreen(),
    );
  }
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() =>
      _ProductScreenState();
}

class _ProductScreenState
    extends State<ProductScreen> {
  final StorageService storageService =
      StorageService();

  List<Product> products = [];
  List<Product> filteredProducts = [];

  bool isLoading = true;
  String searchText = "";

  final searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<List<Product>>
      loadProductsFromAssets() async {
    final jsonString =
        await rootBundle.loadString(
      'assets/data/products.json',
    );

    final List<dynamic> jsonData =
        jsonDecode(jsonString);

    return jsonData
        .map((e) => Product.fromJson(e))
        .toList();
  }

  Future<void> loadData() async {
    List<Product> localProducts =
        await storageService.readProducts();

    if (localProducts.isEmpty) {
      localProducts =
          await loadProductsFromAssets();

      await storageService.saveProducts(
        localProducts,
      );
    }

    setState(() {
      products = localProducts;
      filteredProducts = localProducts;
      isLoading = false;
    });
  }

  void searchProducts(String keyword) {
    setState(() {
      searchText = keyword;

      filteredProducts =
          products.where((product) {
        return product.name
            .toLowerCase()
            .contains(
              keyword.toLowerCase(),
            );
      }).toList();
    });
  }

  Future<void> addProduct() async {
    final nameController =
        TextEditingController();

    final priceController =
        TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              const Text("Add Product"),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              TextField(
                controller:
                    nameController,
                decoration:
                    const InputDecoration(
                  labelText: "Name",
                ),
              ),
              TextField(
                controller:
                    priceController,
                keyboardType:
                    TextInputType.number,
                decoration:
                    const InputDecoration(
                  labelText: "Price",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(
                      context),
              child:
                  const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                final product =
                    Product(
                  id: DateTime.now()
                      .millisecondsSinceEpoch,
                  name:
                      nameController.text,
                  price: double.tryParse(
                          priceController
                              .text) ??
                      0,
                );

                products.add(product);

                await storageService
                    .saveProducts(
                        products);

                searchProducts(
                    searchText);

                if (mounted) {
                  Navigator.pop(
                      context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  Future<void> editProduct(
      Product product) async {
    final nameController =
        TextEditingController(
      text: product.name,
    );

    final priceController =
        TextEditingController(
      text:
          product.price.toString(),
    );

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              const Text("Edit Product"),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              TextField(
                controller:
                    nameController,
              ),
              TextField(
                controller:
                    priceController,
                keyboardType:
                    TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(
                      context),
              child:
                  const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  product.name =
                      nameController.text;

                  product.price =
                      double.tryParse(
                            priceController
                                .text,
                          ) ??
                          0;
                });

                await storageService
                    .saveProducts(
                        products);

                searchProducts(
                    searchText);

                if (mounted) {
                  Navigator.pop(
                      context);
                }
              },
              child:
                  const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteProduct(
      Product product) async {
    final confirm =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              const Text("Delete"),
          content: Text(
            "Delete ${product.name} ?",
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(
                context,
                false,
              ),
              child:
                  const Text("No"),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pop(
                context,
                true,
              ),
              child:
                  const Text("Yes"),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      setState(() {
        products.remove(product);
      });

      await storageService
          .saveProducts(products);

      searchProducts(searchText);
    }
  }

  Widget buildBody() {
    if (isLoading) {
      return const Center(
        child:
            CircularProgressIndicator(),
      );
    }

    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.all(12),
          child: TextField(
            controller:
                searchController,
            decoration:
                const InputDecoration(
              labelText:
                  "Search Product",
              prefixIcon:
                  Icon(Icons.search),
              border:
                  OutlineInputBorder(),
            ),
            onChanged:
                searchProducts,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount:
                filteredProducts.length,
            itemBuilder:
                (context, index) {
              final product =
                  filteredProducts[
                      index];

              return Card(
                margin:
                    const EdgeInsets
                        .all(8),
                child: ListTile(
                  title:
                      Text(product.name),
                  subtitle: Text(
                    "\$${product.price}",
                  ),
                  trailing: Row(
                    mainAxisSize:
                        MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                        ),
                        onPressed: () =>
                            editProduct(
                                product),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                        ),
                        onPressed: () =>
                            deleteProduct(
                                product),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lab 9 JSON CRUD",
        ),
      ),
      body: buildBody(),
      floatingActionButton:
          FloatingActionButton(
        onPressed: addProduct,
        child:
            const Icon(Icons.add),
      ),
    );
  }
}

