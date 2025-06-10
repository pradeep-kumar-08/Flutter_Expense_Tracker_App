import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_demo/screens/home/views/home_screen.dart';
import 'package:uuid/uuid.dart';

import '../add_expense/blogs/create_user_bloc/create_app_user_bloc.dart';
import '../home/blocs/bloc/get_expenses_bloc.dart';
import 'package:expense_repository/expense_repository.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    TextEditingController emailControl = TextEditingController();
    TextEditingController passwordControl = TextEditingController();

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Text(
                'Create Account 🚀',
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
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailControl.text.trim(),
                          password: passwordControl.text.trim()
                      );

                      AppUser user = AppUser(
                        email: emailControl.text.trim(),
                        password: passwordControl.text.trim(),
                        uid: FirebaseAuth.instance.currentUser?.uid ?? Random().nextInt(10).toString(),
                        signUpDate: DateTime.now(),
                        lastLogInDate: DateTime.now(),
                      );

                      context.read<CreateAppUserBloc>()
                          .add(CreateAppUser(user));

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => BlocProvider(
                          create: (_) => GetExpensesBloc(FirebaseExpenseRepo())..add(GetExpenses(FirebaseAuth.instance.currentUser?.uid ?? "")),
                          child: const HomeScreen(),
                        )),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(color: colorScheme.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
