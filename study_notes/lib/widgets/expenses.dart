//app bar
//chart
//list of expenses

import 'package:flutter/material.dart';
import 'package:flutter_udemy/widgets/expenses_list/expenses_list.dart';
import 'package:flutter_udemy/models/expense.dart';
import 'package:flutter_udemy/widgets/new_expense.dart';
import 'package:flutter_udemy/widgets/chart/chart.dart';

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
      //device카메라에 가린 부분은 피해라, 웬만하면 default is true
      useSafeArea: true,
      //Modal overlay takes full screen
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    //show info message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                //insert는 add와 달리 specific place에 넣는다
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

//keep build functions 최소화
  @override
  Widget build(BuildContext context) {
    //스크린 사이즈 알기 위해
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                //column 안에 list있으면 오류나므로 Expanded
                //column 안에 column 있는 느낌
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                //Expanded constraints the child(i.e Chart) to only take as much
                //width as available in the after sizing the other Row children.
                //Chart Container width가 infinity여서
                Expanded(child: Chart(expenses: _registeredExpenses)),
                //column 안에 list있으면 오류나므로 Expanded
                //column 안에 column 있는 느낌
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
