import 'package:flutter/material.dart';

import 'database_helper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    // Check if user exists in the database
                    Map<String, dynamic>? user = await DatabaseHelper().getUser(username);
                    if (user != null && user['password'] == password) {
                      // Login successful
                      print('Login successful');
                    } else {
                      // Login failed
                      print('Login failed');
                    }
                  },
                  child: Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    // Check if user already exists
                    Map<String, dynamic>? existingUser = await DatabaseHelper().getUser(username);
                    if (existingUser != null) {
                      // User already exists
                      print('User already exists');
                    } else {
                      // Register user
                      Map<String, dynamic> newUser = {
                        'username': username,
                        'password': password,
                      };
                      await DatabaseHelper().saveUser(newUser);
                      print('User registered');
                    }
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}