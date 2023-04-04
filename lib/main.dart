import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_appwrite/controllers/todo_provider.dart';

import 'package:todo_app_appwrite/homepage.dart';
import 'package:todo_app_appwrite/shared.dart';
import 'package:todo_app_appwrite/views/add_new_todo.dart';
import 'package:todo_app_appwrite/views/checkUserAuthenticated.dart';
import 'package:todo_app_appwrite/views/edit_todo.dart';
import 'package:todo_app_appwrite/views/login.dart';
import 'package:todo_app_appwrite/views/signup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  UserSavedData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => TodoProvider()),
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.green,
        ),
        routes: {
          '/': (context) => CheckUserAuth(),
          '/home': (context) => Homepage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/new': (context) => NewTodo(),
          '/edit': (context) => EditTodo()
        },
      ),
    );
    // home: const Homepage());
  }
}
