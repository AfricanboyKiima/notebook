import 'package:flutter/material.dart';
import 'package:notebook/views/login_view.dart';
import 'package:notebook/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

void main() {
  /*Responsible for initializing a WidgetsBinding to manage the flutter 
app's lifecycle and provide widget rendering and user data handling services*/
  WidgetsFlutterBinding.ensureInitialized(); //Produces a WidgetsBinding

  runApp(
    //runApp method used to initialize and run a flutter application
    MaterialApp(
      //MaterialApp is the widget that represents my entire app and contains other widgets within it
      title: 'Flutter Demo',

      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final user = FirebaseAuth.instance
                    .currentUser; //Retrieve current user who is authenticated in my firebase project

                final emailVerified = user?.emailVerified ?? false;

                if (emailVerified) {
                  print("You are a verified user");
                } else {
                  print("Your need to verify your email first");
                }
                return const Text('Done');
              default:
                return const Text('Accessing Servers');
            }
          }),
    );
  }
}
