//app bar
//chart
//list of expenses

import 'package:flutter/material.dart';
import 'package:flutter_udemy/expenses_list.dart';
import 'package:flutter_udemy/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99, 
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69, 
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

//keep build functions 최소화
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('The chart'),
          //column 안에 list있으면 오류나므로 Expanded
          Expanded(child: 
            ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
