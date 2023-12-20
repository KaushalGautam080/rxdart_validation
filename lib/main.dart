import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rs_dart_form_validator/cubit/auth_cubit.dart';
import 'package:rs_dart_form_validator/features/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => AuthCubit(),
      child: const MaterialApp(
        title: 'Flutter Demo',
       
        home:  LoginPage(),
      ),
    );
  }
}
