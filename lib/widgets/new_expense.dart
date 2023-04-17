import 'package:flutter/material.dart';
import 'package:flutter_udemy/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

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
    return Padding(
      padding: const EdgeInsets.all(16),
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
                onPressed: () {
                  print(_titleController.text);
                },
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
