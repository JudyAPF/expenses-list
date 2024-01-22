import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flores_assignment7/models/expenses_item.dart';

class ExpensesListScreen extends StatefulWidget {
  @override
  _ExpensesListScreenState createState() => _ExpensesListScreenState();
}

class _ExpensesListScreenState extends State<ExpensesListScreen> {
  List<Expense> expenses = [];
  final TextEditingController itemController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void _addExpense() {
    String item = itemController.text.trim();
    String description = descriptionController.text.trim();
    String amountString = amountController.text.trim();

    if (item.isEmpty || description.isEmpty || amountString.isEmpty) {
      _showSnackBar('Please fill in all fields.');
      return;
    }

    double amount;
    try {
      amount = double.parse(amountString);
    } catch (e) {
      _showSnackBar('Invalid amount format. Please enter a valid number.');
      return;
    }

    setState(() {
      expenses.insert(
        0,
        Expense(item: item, description: description, amount: amount),
      );
      itemController.clear();
      descriptionController.clear();
      amountController.clear();
    });
  }

  void _removeExpense(int index) {
    setState(() {
      expenses.removeAt(index);
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('My Expenses', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: itemController,
                      decoration: InputDecoration(labelText: 'Expenses Item'),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _addExpense();
                      },
                      child: Text('ADD ITEM'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(expenses[index].item),
                    background: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(expenses[index].item),
                        subtitle: Text(expenses[index].description),
                        trailing: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              NumberFormat.currency(
                                      locale: 'en_PHP', symbol: '\₱')
                                  .format(expenses[index].amount),
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Delete"),
                            content: Text(
                                "Are you sure you want to delete this item?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: Text("Delete"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    onDismissed: (direction) {
                      _removeExpense(index);
                    },
                    direction: DismissDirection.startToEnd,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
