import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_demo/screens/add_expense/blogs/update_user_bloc/update_app_user_bloc.dart';
import 'package:test_demo/screens/home/blocs/bloc/get_expenses_bloc.dart';
import 'package:test_demo/screens/login/login_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Expense Tracker",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade100,
          onSurface: Colors.black,
          primary: const Color(0xFF00E2E7),
          secondary: const Color(0xFFE064F7),
          tertiary: const Color(0xFFFF8D6C),
          outline: Colors.grey.shade400,
        ),
      ),
      home: BlocProvider(
        create: (context) => UpdateAppUserBloc(FirebaseExpenseRepo()),
        child: const LoginPage(),
      ),
    );
  }
}
