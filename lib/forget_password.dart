//import 'dart:html';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:email_validator/email_validator.dart';
// 'package:basic_utils/basic_utils.dart';

class forPass extends StatefulWidget {
  const forPass({super.key});

  @override
  State<forPass> createState() => _forPassState();
}

class _forPassState extends State<forPass> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void disope() {
    emailController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        key: formKey,
        home: Scaffold(
            body: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Receive an email to reset your password',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: ((email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null),
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    // border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      // color: Colors.white,
                    )),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50)),
                  icon: Icon(Icons.email_outlined),
                  label: const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: verifyEmail,
                  //() async {
                  //  if (_formKey.currentState!.validate()) {
                  // verifyEmail();
                  //}
                  // },
                )),
          ],
        )));
  }

  Future verifyEmail() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Password Reset Email Send')));
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);

      // ScaffoldMessenger.of(context)
      //    .showSnackBar(SnackBar(content: Text('sdsdsdsdsds')));
      Navigator.of(context).pop();
    }
  }
}
