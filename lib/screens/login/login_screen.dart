import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_demo/screens/add_expense/blogs/update_user_bloc/update_app_user_bloc.dart';
import 'package:test_demo/screens/home/views/home_screen.dart';
import 'package:test_demo/screens/login/register_screen.dart';
import '../add_expense/blogs/create_user_bloc/create_app_user_bloc.dart';
import '../home/blocs/bloc/get_expenses_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkForCurrentUser();
  }

  checkForCurrentUser(){
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if(FirebaseAuth.instance.currentUser != null){
        context.read<UpdateAppUserBloc>()
            .add(UpdateAppUser(FirebaseAuth.instance.currentUser?.uid
            ?? Random().nextInt(10).toString(),
            DateTime.now()));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BlocProvider(
            create: (_) => GetExpensesBloc(FirebaseExpenseRepo())..add(GetExpenses(FirebaseAuth.instance.currentUser?.uid ?? "")),
            child: const HomeScreen(),
          )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocProvider(
        create: (context) => GetExpensesBloc(
            FirebaseExpenseRepo()
        )..add(GetExpenses(FirebaseAuth.instance.currentUser?.uid ?? "")),
        child: Scaffold(
          backgroundColor: colorScheme.surface,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    'Welcome Back 👋',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: emailControl,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: colorScheme.outline),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: colorScheme.outline),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordControl,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: colorScheme.outline),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: colorScheme.outline),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () async{
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailControl.text.trim(),
                              password: passwordControl.text.trim()
                          );
                          context.read<UpdateAppUserBloc>()
                              .add(UpdateAppUser(FirebaseAuth.instance.currentUser?.uid
                              ?? Random().nextInt(10).toString(),
                              DateTime.now()));

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => BlocProvider(
                              create: (_) => GetExpensesBloc(FirebaseExpenseRepo())..add(GetExpenses(FirebaseAuth.instance.currentUser?.uid ?? "")),
                              child: const HomeScreen(),
                            )),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BlocProvider(
                            create: (_) => CreateAppUserBloc(FirebaseExpenseRepo()),
                            child: const RegistrationPage(),
                          )),
                        );
                      },
                      child: Text(
                        "Don't have an account? Register",
                        style: TextStyle(color: colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
