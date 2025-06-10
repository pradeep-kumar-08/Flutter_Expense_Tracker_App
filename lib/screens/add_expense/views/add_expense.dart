import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:test_demo/screens/add_expense/blogs/create_categorybloc/create_category_bloc.dart';
import 'package:test_demo/screens/add_expense/blogs/create_expense_bloc/create_expense_bloc.dart';
import 'package:test_demo/screens/add_expense/blogs/get_categories_bloc/get_categories_bloc.dart';
import 'package:test_demo/screens/add_expense/views/category_creation.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  // DateTime selectedDate = DateTime.now();
  late Expense expense;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    dateController.text = DateFormat("dd/mm/yyyy").format(DateTime.now());
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
    expense.uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.pop(context, expense);
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar:
              AppBar(backgroundColor: Theme.of(context).colorScheme.surface),
          body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
            builder: (context, state) {
              if (state is GetCategoriesSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Add Expenses",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                          controller: expenseController,
                          textAlignVertical: TextAlignVertical.center,
                          // inputFormatters: [
                          //   FilteringTextInputFormater.allow(RegEx("[0-9.]"))
                          // ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(left: 21, top: 10),
                              child: Text(
                                "\₹",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              // borderSide: BorderSide.none
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: categoryController,
                        textAlignVertical: TextAlignVertical.center,
                        onTap: () {},
                        readOnly: true,
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: expense.category == Category.empty
                              ? Colors.white
                              : Color(expense.category.color),
                          prefixIcon: expense.category == Category.empty
                              ? Icon(
                                  Icons.list,
                                  color: Theme.of(context).colorScheme.outline,
                                )
                              : Image.asset(
                                  'assets/${expense.category.icon}.png',
                                  scale: 2,
                                ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              var newCategory =
                                  await getCategoryCreation(context);

                              setState(() {
                                state.categories.insert(0, newCategory);
                              });
                            },
                            icon: const Icon(
                              FontAwesomeIcons.plus,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: "Categary",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              borderSide: BorderSide.none),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12)),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: ListView.builder(
                                itemCount: state.categories.length,
                                itemBuilder: (context, int i) {
                                  return Card(
                                    child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          expense.category =
                                              state.categories[i];
                                          categoryController.text =
                                              expense.category.icon;
                                        });
                                      },
                                      leading: Image.asset(
                                        'assets/${state.categories[i].icon}.png',
                                        scale: 2,
                                      ),
                                      title: Text(state.categories[i].icon),
                                      tileColor:
                                          Color(state.categories[i].color),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  );
                                })),
                      ),

                      const SizedBox(height: 16),
                      // -----------------------------------------------
                      TextFormField(
                        controller: dateController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: expense.date,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );

                          if (newDate != null) {
                            setState(() {
                              dateController.text = DateFormat(
                                "dd/MM/yyyy",
                              ).format(newDate);
                              // selectedDate = newDate;
                              expense.date = newDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.watch_later_outlined,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          hintText: "Date",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            // borderSide: BorderSide.none
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: kToolbarHeight,
                        child: isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : TextButton(
                                onPressed: () {
                                  setState(() {
                                    expense.amount =
                                        int.parse(expenseController.text);
                                  });
                                  context
                                      .read<CreateExpenseBloc>()
                                      .add(CreareExpense(expense));
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Save",
                                  style: TextStyle(
                                      fontSize: 22, color: Colors.white),
                                ),
                              ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
