import 'package:flutter/material.dart';
import 'package:auction_house/auth_service.dart';
import 'package:auction_house/home_page.dart';
import 'package:auction_house/member_check.dart';
import 'package:auction_house/signUp_page.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: "Email",
            errorText: _validate ? 'Value Can\'t Be Empty' : null,
          ),
        ),
        TextFormField(
          obscureText: true,
          controller: passwordController,
          decoration: InputDecoration(
            labelText: "Password",
            errorText: validatePassword(passwordController.text),
          ),
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              emailController.text.isEmpty
                  ? _validate = true
                  : _validate = false;
            });
            context.read<AuthService>().signIn(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomePage();
                },
              ),
            );
          },
          child: Text(
            "Sign in",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Membercheck(
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpPage();
                },
              ),
            );
          },
        ),
      ]),
    );
  }
}

String validatePassword(String value) {
  if (!(value.length > 5) && value.isNotEmpty) {
    return "Password should contain more than 5 characters";
  }
  return null;
}
