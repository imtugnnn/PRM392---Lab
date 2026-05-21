import 'dart:async';

void main() async{
  //Exc 1
  print('Exc 1--------------------');
  int age = 21;
  double gpa = 2.4;
  String name = "Tung";
  bool gender = true;

  print('Name: $name');
  print('Age: $age');
  print('GPA: $gpa');
  print('Gender - male: $gender');
  
  //Exc 2
  print('Exc 2------------------------');
  //List
  List<int> nums = [5, 12, 8, 3];
  int sum = nums[0] + nums[1]; // arithmetic operators
  bool isEqual = (nums[2] == 8); // comparision operators
  print('nums[0] + nums[1] = $sum');
  print('nums[2] == 8: $isEqual');

  //Set
  Set<String> set = {'hi', 'hello', 'hi', 'bye'};
  print('$set');
  set.add('Android');
  set.remove('hello');
  print('$set');

  //Map
  Map<String, dynamic> courseInfo = {
    'code': 'PRM392',
    'name': 'Mobile Programming',
    'credits': 3
  };
  // Truy cập dữ liệu trong Map thông qua indexing/key access [cite: 28]
  print('Course Code: ${courseInfo['code']} - Name: ${courseInfo['name']}\n');

  //Exc 3
  print('Exc 3---------------');
  print('if/else');
  double score = 6;
  if(score >= 5) print('pass');
  else print('fail');

  print('switch/case');
  switch(score){
    case 6:
    print('6');
    default:
    print('!= 6');
  }

  print('1. For loop');
  for(int i = 0; i < nums.length; i++){
    print(' Index $i: ${nums[i]}');
  }

  print('2. For-in loop');
  for(int part in nums){
    print(' Part: $part');
  }

  print('3. forEach loop: ');
  nums.forEach((part) => print('  forEach item: $part'));

  //Exc 4
  print('Exc 4----------');
  Car normalCar = Car('VinFast VF8');
  normalCar.drive();

  Car customCar = Car.withModel('Toyota Camry');
  customCar.drive();

  ElectricCar myEV = ElectricCar('Tesla Model 3', 82);
  myEV.drive();

  //Exc 5
  print('Exc 5--------------');
  String? nullableString;
  print('Length string: ${nullableString?.length ?? 0}');

  nullableString = 'hello';
  print('Length string: ${nullableString!.length}');

  print('Use Future.delayed() to simulate loading.');
  String apiResult = await fetchNetworkData();
  print('Data received: $apiResult');

  print('Create a simple Stream of integers and listen to values.');
  Stream<int> numberStream = countStream(3);

  //Chờ giá trị truyền về
  await for(int val in numberStream){
    print('Stream value received: $val');
  }
}

class Car{
  //Property
  String name;

  //Constructor
  Car(this.name);
  
  //Named Contructor
  Car.withModel(this.name){
    print('--> Named constructor called for: $name');
  }

  //Method
  void drive(){
    print('Car name: $name');
  }
}

//Extend class
class ElectricCar extends Car{
  int battery;

  ElectricCar(String name, this.battery) : super(name);

  @override
  void drive(){
    print('ECar: $name');
    print('Battery: $battery');
  }
}

//Async funtion
Future<String> fetchNetworkData() async{
  //Giả lập tải mất 2s
  await Future.delayed(const Duration(seconds: 2));
  return "OK";
}

Stream<int> countStream(int max) async*{
  for(int i = 1; i < max; i++){
    await Future.delayed(const Duration(seconds: 1));
    yield i; //Đưa giá trị vào stream
  }
}