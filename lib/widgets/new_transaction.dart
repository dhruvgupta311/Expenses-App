import 'dart:io';
import '../widgets/Adaptive.dart';
import 'package:expenses_app/widgets/Adaptive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransation extends StatefulWidget {
  final Function addTx;

  NewTransation(this.addTx);

  @override
  State<NewTransation> createState() => _NewTransationState();
}

class _NewTransationState extends State<NewTransation> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void submitdata() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      titleController.text,
      double.parse(amountController.text),
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle:
                      TextStyle(color: Colors.grey), // Color of the label
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(
                            255, 0, 6, 16)), // Border color for enabled state
                    borderRadius: BorderRadius.circular(10.0), // Border radius
                  ),
                ),
                controller: titleController,
                onSubmitted: (_) => submitdata,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle:
                      TextStyle(color: Colors.grey), // Color of the label
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(
                            255, 1, 7, 17)), // Border color for enabled state
                    borderRadius: BorderRadius.circular(10.0), // Border radius
                  ),
                ),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitdata,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen'
                            : 'Picked Date :  ${DateFormat.yMd().format(_selectedDate)}',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                    AdaptiveFlatButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  submitdata();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.purple),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 0, 87, 138)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  overlayColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 0, 87, 138).withOpacity(0.2)),
                ),
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
