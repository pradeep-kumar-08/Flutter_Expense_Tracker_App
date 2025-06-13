import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_demo/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();




  runApp(MyApp());
} 
