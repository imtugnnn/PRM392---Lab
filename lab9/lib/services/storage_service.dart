import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import '../models/product.dart';

class StorageService {
  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File('${directory.path}/products.json');
  }

  Future<List<Product>> readProducts() async {
    try {
      final file = await _getFile();

      if (!await file.exists()) {
        return [];
      }

      final contents = await file.readAsString();

      final List<dynamic> jsonData = jsonDecode(contents);

      return jsonData
          .map((e) => Product.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveProducts(
      List<Product> products) async {
    final file = await _getFile();

    await file.writeAsString(
      jsonEncode(
        products.map((e) => e.toJson()).toList(),
      ),
    );
  }
}