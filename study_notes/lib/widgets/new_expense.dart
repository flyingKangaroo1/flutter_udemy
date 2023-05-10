import 'package:flutter/material.dart';
import 'package:flutter_udemy/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
//  var _enteredTitle = '';
//  void _saveTitleInput(String inputValue) {
//    _enteredTitle = inputValue;
//  }

  //flutter가 알아서 text input 처리하게
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    ); /*).then((value) {
      //once value is available, 뒤에 함수 실행된다 (Future)
      //then method 말고도 async method
      },)*/
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    //tryParse('hello')=>null, tryParse('1.12')=>1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    //category는 초기 leisure이므로 null 확인 안 해도 된다
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      //if문 안에 들어가면 뒤에 코드 run 안하게
      return;
    }

    //'widget' state class can get access to connected widget class
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  //TextEditingController다 사용하면 닫게
  @override
  void dispose() {
    //only 'state' classes can implement this 'dispose' method (StatelessWidget can't)
    //that's also why you must use a Statefulwidget here.
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //give info about overlapping ui
    //ex) can get space taken up by keyboard
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    //modal 열려도 뒤에 스크린 scroll 가능하게 하기 위해
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              //text input element
              TextField(
                //            onChanged: _saveTitleInput, // 직접 입력되는 키마다
                controller: _titleController,
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  //Row하고 TextField안에 같이 있으면 가로로 공간 다 차지하려고 해서 오류
                  //=>Expanded
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  //Row 안에 Row => Expanded
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_selectedDate == null
                            ? 'No date selected'
                            //!은 절대로 null이 아닐 것이다
                            : formatter.format(_selectedDate!)),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    //Category.values는 enum value의 list
                    //map으로 category로 바꿔준다
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            //DropdownMenuItem을 정했을때 저장되는 value
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    //type dynamic, flutter가 어느 아이템이 디스플레이 될지 모르므로
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      //removes modal overlay
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Expense'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
