import 'dart:ffi';
import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_demo/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_demo/screens/login/login_screen.dart';

import '../../add_expense/blogs/update_user_bloc/update_app_user_bloc.dart';
import '../blocs/bloc/get_expenses_bloc.dart';

class MainScreen extends StatefulWidget {
  final List<Expense> expenses;
  const MainScreen(this.expenses, {super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow[700],
                          ),
                        ),
                        Icon(Icons.person, color: Colors.yellow[900]),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser?.email ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BlocProvider(
                        create: (_) => UpdateAppUserBloc(FirebaseExpenseRepo()),
                        child: const LoginPage(),
                      )),
                    );
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            const SizedBox(height: 20),
          BlocBuilder<GetExpensesBloc, GetExpensesState>(
              builder: (context, state) {
                if (state is GetExpensesSuccess) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.tertiary,
                        ],
                        transform: const GradientRotation(pi / 4),
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey.shade300,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Total Expense",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "₹${state.getTotalExpense.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //     vertical: 12,
                        //     horizontal: 20,
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Row(
                        //         children: [
                        //           Container(
                        //             height: 25,
                        //             width: 25,
                        //             decoration: const BoxDecoration(
                        //               color: Colors.white30,
                        //               shape: BoxShape.circle,
                        //             ),
                        //             child: const Center(
                        //               child: Icon(
                        //                 Icons.arrow_downward,
                        //                 size: 21,
                        //                 color: Colors.greenAccent,
                        //               ),
                        //             ),
                        //           ),
                        //           const SizedBox(width: 8),
                        //           const Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 "Income",
                        //                 style: TextStyle(
                        //                   fontSize: 14,
                        //                   color: Colors.white,
                        //                   fontWeight: FontWeight.w400,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "\₹ 2000.0",
                        //                 style: TextStyle(
                        //                   fontSize: 14,
                        //                   color: Colors.white,
                        //                   fontWeight: FontWeight.w600,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //       Row(
                        //         children: [
                        //           Container(
                        //             height: 25,
                        //             width: 25,
                        //             decoration: const BoxDecoration(
                        //               color: Colors.white30,
                        //               shape: BoxShape.circle,
                        //             ),
                        //             child: const Center(
                        //               child: Icon(
                        //                 Icons.arrow_upward,
                        //                 size: 21,
                        //                 color: Colors.redAccent,
                        //               ),
                        //             ),
                        //           ),
                        //           const SizedBox(width: 8),
                        //           const Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Text(
                        //                 "Expense",
                        //                 style: TextStyle(
                        //                   fontSize: 14,
                        //                   color: Colors.white,
                        //                   fontWeight: FontWeight.w400,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "\₹ 2000.0",
                        //                 style: TextStyle(
                        //                   fontSize: 14,
                        //                   color: Colors.white,
                        //                   fontWeight: FontWeight.w600,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox();
                }
              }),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transactions",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                widget.expenses.isNotEmpty ? GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ) : SizedBox(),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: widget.expenses.isNotEmpty ? ListView.builder(
                itemCount: widget.expenses.length,
                itemBuilder: (context, int i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color:
                                    Color(widget.expenses[i].category.color),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                'assets/${widget.expenses[i].category.icon}.png',
                                // scale: 2,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width:  12),
                            Expanded(
                              child: Text(
                                widget.expenses[i].category.icon.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(

                              children: [
                                Text(
                                  "\₹${widget.expenses[i].amount.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(widget.expenses[i].date),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ) : Center(child: Text("No Expenses added")),
            ),
          ],
        ),
      ),
    );
  }
}
