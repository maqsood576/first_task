import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserStatusScreen extends StatefulWidget {
  @override
  _UserStatusScreenState createState() => _UserStatusScreenState();
}

class _UserStatusScreenState extends State<UserStatusScreen> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userList = prefs.getStringList('users') ?? [];

    setState(() {
      users = userList.map((user) => jsonDecode(user)).cast<Map<String, dynamic>>().toList();
    });
  }

  Future<void> deleteUser(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> userList = prefs.getStringList('users') ?? [];

    userList.removeAt(index);
    await prefs.setStringList('users', userList);
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Status")),
      body: users.isEmpty
          ? Center(child: Text("No users found."))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Dismissible(
            key: Key(user['email']),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              deleteUser(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("User Deleted")),
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            child: Card(
              elevation: 3,
              child: ListTile(
                title: Text("Email: ${user['email']}"),
                subtitle: Text("Phone: ${user['phone']}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      user['isActive'] ? Icons.check_circle : Icons.cancel,
                      color: user['isActive'] ? Colors.green : Colors.red,
                    ),
                    SizedBox(width: 10),
                    Text(
                      user['isActive'] ? "Active" : "Inactive",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: user['isActive'] ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
