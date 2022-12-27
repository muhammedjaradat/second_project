// ignore_for_file: use_build_context_synchronously

/* 
step 1: create the main layout of th app(only the UI)
step2: login to your firebase console 
step 3: create a new firbase project 
step 4: lets add the firebase dependeicies for flutter 
step 5: let init the firebase app
step 6: create the login function
step 7: now let's Create a new user inside our base and test the app
step 8: let's input our user data and test the app
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:second_project/forget_password.dart';
import 'package:second_project/profile_screen.dart';
import 'package:second_project/signUP.dart';

const String _title = 'Heart Attack';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(brightness: Brightness.dark),
      // themeMode: ThemeMode.dark,
      title: _title,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//initialize fierbase app
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//Login function
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User Found for that email");
      }
    }

    return user;
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  '',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Email';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                      .hasMatch(value)) {
                    return 'Enter a Valid email "example@gmail.com"';
                  }
                  return null;
                },
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      // color: Colors.white,
                    )),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Your Name';
                  }
                  return null;
                },
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      //color: Colors.white,
                    )),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: ((context) => const forPass())));
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      null;
                    }
                    //lets test the app
                    User? user = await loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context);

                    if (user != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => const ProfileScreen())));
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Does not have account?',
                ),
                TextButton(
                    child: const Text(
                      'Create',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => const SignUp())));
                    })
              ],
            ),
          ],
        ));
  }
}
