import 'package:flutter/material.dart';
import 'package:todo_app_appwrite/auth.dart';
import 'package:todo_app_appwrite/shared.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          TextFormField(
            controller: emailcontroller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: passwordcontroller,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      //login the user

                      loginUser(emailcontroller.text, passwordcontroller.text)
                          .then((value) {
                        if (value) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Invalid email password")));
                        }
                      });

                      //navigate to the homepage
                    },
                    child: Text("Login")),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text("Sign Up")),
              )
            ],
          )
        ]),
      ),
    );
  }
}
