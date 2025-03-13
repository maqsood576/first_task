import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'user_status_screen.dart';

class UserInputScreen extends StatefulWidget {
  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool isActive = true; // Default status is active

  Future<void> saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userList = prefs.getStringList('users') ?? [];

    Map<String, dynamic> userData = {
      'email': emailController.text,
      'phone': phoneController.text,
      'isActive': isActive,
    };

    userList.add(jsonEncode(userData));
    await prefs.setStringList('users', userList);

    // Navigate to User Status Screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserStatusScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Input")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Phone Number"),
            ),
            SizedBox(height: 20),
            Text("Active User:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = value as bool;
                    });
                  },
                ),
                Text("Active"),
                Radio(
                  value: false,
                  groupValue: isActive,
                  onChanged: (value) {
                    setState(() {
                      isActive = value as bool;
                    });
                  },
                ),
                Text("Inactive"),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: saveUserData,
                child: Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
