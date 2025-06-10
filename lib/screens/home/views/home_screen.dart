import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_demo/screens/add_expense/blogs/create_categorybloc/create_category_bloc.dart';
import 'package:test_demo/screens/add_expense/blogs/get_categories_bloc/get_categories_bloc.dart';
import 'package:test_demo/screens/add_expense/views/add_expense.dart';
import 'package:test_demo/screens/home/blocs/bloc/get_expenses_bloc.dart';
import 'package:test_demo/screens/home/views/main_screen.dart';
import 'package:test_demo/screens/stats/stats.dart';

import '../../add_expense/blogs/create_expense_bloc/create_expense_bloc.dart';
import '../../add_expense/blogs/create_user_bloc/create_app_user_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
        builder: (context, state) {
      if (state is GetExpensesSuccess) {
        return Scaffold(
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            child: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  index = value;
                });
                print(value);
              },
              currentIndex: index,
              backgroundColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 3,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.graphic_eq_sharp),
                  label: "state",
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var newExpense = await Navigator.push(
                context,
                MaterialPageRoute<Expense>(
                    builder: (BuildContext context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) =>
                                  CreateCategoryBloc(FirebaseExpenseRepo()),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  GetCategoriesBloc(FirebaseExpenseRepo())
                                    ..add(GetCategories()),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  CreateExpenseBloc(FirebaseExpenseRepo()),
                            ),
                            BlocProvider(
                              create: (context) =>
                                  CreateAppUserBloc(FirebaseExpenseRepo()),
                            ),
                          ],
                          child: const AddExpense(),
                        )),
              );
              if (newExpense != null) {
                setState(() {
                  state.expenses.insert(0, newExpense);

                });
              }
            },
            shape: const CircleBorder(),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.tertiary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.primary,
                  ],
                  transform: const GradientRotation(pi / 4),
                ),
              ),
              child: const Icon(Icons.add),
            ),
          ),
          body: index == 0 ? MainScreen(state.expenses) : const StatScreen(),
        );
      } else {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
