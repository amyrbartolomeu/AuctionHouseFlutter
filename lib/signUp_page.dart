import 'package:flutter/material.dart';
import 'package:auction_house/auth_service.dart';
import 'package:auction_house/member_check.dart';
import 'package:auction_house/signin_page.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool _validate = false;

  String error = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
              labelText: "Email",
            ),
          ),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              errorText: validatePassword(passwordController.text),
              labelText: "Password",
            ),
          ),
          FlatButton(
            onPressed: () {
              setState(() {
                emailController.text.isEmpty
                    ? _validate = true
                    : _validate = false;
              });

              context.read<AuthService>().signUp(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
            },
            child: Text(
              "Sign up",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Membercheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignInPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

String validatePassword(String value) {
  if (!(value.length > 5) && value.isNotEmpty) {
    return "Password should contain more than 5 characters";
  }
  return null;
}
