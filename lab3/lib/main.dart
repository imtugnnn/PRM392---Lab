import 'dart:async';
import 'dart:convert';

void main() async{
  //Ex 1
  print('Ex 1---------------');
  ProductRepository productRepository = ProductRepository();

  productRepository.liveAddedStream.listen((product){
    print('Added: ${product.name}');
  });

  //Thêm sản phẩm
  productRepository.addProduct(Product(id: 'P01', name: 'Laptop', price: 1200.0));
  productRepository.addProduct(Product(id: 'P02', name: 'Chuột', price: 80.0));

  List<Product> products = await productRepository.getProducts();
  print('Danh sách kho---');
  for(var p in products){
    print('- ${p.name} (${p.price})');
  }

  //Ex 2
  print('Ex 2---------------');
  UserRepository userRepository = UserRepository();

  List<User> users = await userRepository.fetchUsers();
  print('Parsed ${users.length} users');

  for(var user in users){
    print('Name: ${user.name}');
    print('Email: ${user.email}');
  }

  //Ex 3
  print('Ex 3------------');
  runExercise3();

  //Ex 4
  print('Ex 4------------');
  runExercise4();
}

class Product{
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }
}

class ProductRepository{
  //Giả lập một danh sách dữ liệu local trong Repo
  final List<Product> _products = [];

  //Khai báo StreamController để quản lý việc phát dữ liệu thời gian thực
  final StreamController<Product> _liveAddedController = StreamController<Product>.broadcast();

  //Lấy danh sách sản phẩm, deplay 1s
  Future<List<Product>> getProducts() async{
      await Future.delayed(const Duration(seconds: 1));
      return _products;
  }

  Stream<Product> get liveAddedStream => _liveAddedController.stream;

  //Thêm sản phẩm
  void addProduct(Product product){
    _products.add(product);
    _liveAddedController.add(product);
  }  
}

class User{
  final String name;
  final String email;

  User (
    {required this.name, required this.email}
    );

  //Factory constructor
  factory User.fromJson(Map<String, dynamic> json){
    return User(name: json['name'] as String, email: json['email'] as String
    );
  }
}

class UserRepository{
  //Tạo chuỗi JSON
  final String _mockJsonResponse = '''
  [
    {"name": "imtun", "email": "imtun@gmail.com"},
    {"name": "Nguyen Van A", "email": "vana@gmail.com"}
  ]
  ''';

  Future<List<User>> fetchUsers() async {
    // Giả lập đợi mạng mất 1 giây
    await Future.delayed(const Duration(seconds: 1));

    //Chuyển đổi chuỗi String JSON thành một dữ liệu List/Map thô trong Dart
    final List<dynamic> rawData = jsonDecode(_mockJsonResponse);

    // dùng hàm User.fromJson để biến đổi thành đối tượng User thật sự 
    List<User> userList = rawData.map((item) {
      return User.fromJson(item as Map<String, dynamic>);
    }).toList();

    return userList;
  }
}

//Câu lệnh Microtask sẽ chạy ngay sau khi chạy hết các câu lệnh thường (print)
//Câu lệnh Future sẽ chạy cuối cùng sau khi hết Microtask
void runExercise3(){
  // 1. Câu lệnh đồng bộ thông thường (Chạy đầu tiên)
  print('A: Main line - Start');

  // 2. Tạo một Event bằng một Future thông thường
  Future(() {
    print('B: Event Queue - Future callback 1');
  });

  // 3. Tạo một Microtask bằng scheduleMicrotask()
  scheduleMicrotask(() {
    print('C: Microtask Queue - Microtask callback 1');
  });

  // 4. Thêm một Event khác vào Event Queue
  Future(() {
    print('D: Event Queue - Future callback 2');
  });

  // 5. Thêm một Microtask khác vào Microtask Queue
  scheduleMicrotask(() {
    print('E: Microtask Queue - Microtask callback 2');
  });

  // 6. Câu lệnh đồng bộ thông thường (Chạy ngay sau câu lệnh số 1)
  print('F: Main line - End');
}

void runExercise4() async{
  Stream<int> originalStream = Stream.fromIterable([1, 2, 3, 4, 5]);

  Stream<int> transformedStream = originalStream
      // Sử dụng map() để bình phương các giá trị nhận được (ví dụ: 2 -> 2*2 = 4)
      .map((number) => number * number)
      // Sử dụng where() để lọc, chỉ giữ lại các số chẵn (chia hết cho 2)
      .where((square) => square % 2 == 0);

  await for (int val in transformedStream) {
    print('Even square value: $val');
  }
}
//dart run lib/main.dart