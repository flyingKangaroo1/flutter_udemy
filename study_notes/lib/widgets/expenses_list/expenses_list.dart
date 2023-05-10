import 'package:flutter/material.dart';
import 'package:flutter_udemy/models/expense.dart';
import 'package:flutter_udemy/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    //list of unknown length를 display할때는
    //scroll 해서야만 보이는 안 보이는 element까지 만듦
    //낭비
    //Column() 보다는 ListView.builder
    return ListView.builder(
      itemCount: expenses.length,
      // Dismissible : can be swiped away, however this doesn't remove connected data*
      itemBuilder: (ctx, index) => Dismissible(
          //key makes widgets uniquely identifiable
          //need key to identify and remove unique widget
          //most widget don't need to set keys
          key: ValueKey(expenses[index]),
          //지울때 뒤에 뜨는 박스
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            //margin: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          //Dismiss Direction 때문에
          onDismissed: (direction) {
            onRemoveExpense(
                expenses[index]); //triggers function to remove data from list*
          },
          child: ExpenseItem(expenses[index])),
    );
  }
}
