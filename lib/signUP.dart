// ignore_for_file: non_constant_identifier_names, unused_element, dead_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second_project/main.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static Future<User?> SignUpUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } catch (e) {
      print(e);
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Sign Up Page',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
              alignment: Alignment.topLeft,
              // padding: const EdgeInsets.fromLTRB(380, 10, 0, 10),
              child: GestureDetector(
                child: Icon(Icons.arrow_back),
                onTap: (() {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: ((context) => const MyApp())));
                }),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            // ignore: prefer_const_constructors
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Your Name';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your Name',
                  prefixIcon: Icon(
                    Icons.tips_and_updates_rounded,
                    color: Colors.white,
                  )),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Your Email';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  )),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value != null && value.length < 6) {
                  return 'Enter min. 6character';
                }
                return null;
              },
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  )),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your birthday';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'dd/mm/yy',
                  prefixIcon: Icon(
                    Icons.date_range_outlined,
                    color: Colors.white,
                  )),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter youre Phone Number';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.white,
                  )),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Your Location';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Location',
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  )),
            ),
          ),
          Container(
              //  height: 150,
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                child: const Text('Sign Up'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    null;
                  }
                  User? user = await SignUpUsingEmailPassword(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      context: context);

                  if (user != null) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => const MyApp())));
                    //lets make a new screen
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text(
                            'Please Enter a correct information',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                    );
                  }
                },
              )),
        ],
      ),
    ));
  }
}
