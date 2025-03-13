import 'package:flutter/material.dart';
import '../calculator.dart';
import '../gradebook.dart';
import '../user_input_screen.dart';
import '../user_status_screen.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback onAboutTap;

  AppDrawer({required this.onAboutTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Calculator'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalculatorScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.grade),
            title: Text('Grade Book'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GradeBookScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('User Input'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserInputScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.save),
            title: Text('Saved User Status'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserStatusScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
