import 'package:flutter/material.dart';
import 'package:todo_app_appwrite/auth.dart';

class CheckUserAuth extends StatefulWidget {
  const CheckUserAuth({super.key});

  @override
  State<CheckUserAuth> createState() => _CheckUserAuthState();
}

class _CheckUserAuthState extends State<CheckUserAuth> {
  @override
  void initState() {
    checkUserAuth().then((value) {
      if (value) {
        // if user is authenticated
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // if not authenticated
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
