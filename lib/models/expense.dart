//expense의 data structure 설명
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

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

  //'getters' are basically computed properties
  // => Properties that are dynamically derived, based on other class properties.
  String get formattedDate {
    return formatter.format(date);
  }
}
