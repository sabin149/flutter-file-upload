import 'package:flutter/material.dart';
import 'package:frontend/screen/addStudent.dart';
import 'package:frontend/screen/displayStudent.dart';
import 'package:frontend/screen/register.dart';

import '/screen/login.dart';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
    routes: {
        '/': (context) =>const  Login(),
        '/register': (context) =>const RegisterScreen(),
        '/addstudent': (context) =>const AddStudentScreen(),
        '/displaystudent': (context) =>const DisplayStudentScreen(),

      },
    );
  }
}

 