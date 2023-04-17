//app bar
//chart
//list of expenses

import 'package:flutter/material.dart';
import 'package:flutter_udemy/widgets/expenses_list/expenses_list.dart';
import 'package:flutter_udemy/models/expense.dart';
import 'package:flutter_udemy/widgets/new_expense.dart';

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

  void _openAddExpenseOverlay() {
    //what is context
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewExpense(),
    );
  }

//keep build functions 최소화
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          //column 안에 list있으면 오류나므로 Expanded
          //column 안에 column 있는 느낌
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          ),
        ],
      ),
    );
  }
}
