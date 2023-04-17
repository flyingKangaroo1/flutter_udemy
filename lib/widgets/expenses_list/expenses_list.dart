import 'package:flutter/material.dart';
import 'package:flutter_udemy/models/expense.dart';
import 'package:flutter_udemy/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    //list of unknown length를 display할때는
    //scroll 해서야만 보이는 안 보이는 element까지 만듦
    //낭비
    //Column() 보다는 ListView.builder
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => ExpenseItem(expenses[index]),
    );
  }
}
