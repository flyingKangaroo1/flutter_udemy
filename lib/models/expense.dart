//expense의 data structure 설명
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

class Expense {
  //constructor to build Expense object
  //최대 4개 parameter이므로 named parameter 사용했음
  //in dart, initializer lists can be used to initialize class properties like id with values
  //that are NOT received as constructor function arguments
  Expense({
    required this.title, 
    required this.amount, 
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  //leisure라고 칠때 typo 나면 안 뜨는 오류날 수 있기 때문에 enum 사용
  // final String category;
  final Category category;
}