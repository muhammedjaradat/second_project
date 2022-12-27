import 'package:flutter/material.dart';
import 'main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Welcome to your Profile page"),
            ElevatedButton(
                onPressed: () async {
                  //lets test the app

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: ((context) => const MyApp())));
                  //lets make a new screen
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
