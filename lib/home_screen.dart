import 'package:flutter/material.dart';
import 'app_drawer.dart'; // Ensure this file exists

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showAbout = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.jpg', height: 40), // App Logo
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Maqsood E24",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Baba Guru Nanak University Nankana Sahib",
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
      drawer: AppDrawer(
        onAboutTap: () {
          setState(() {
            showAbout = true;
          });
          Navigator.pop(context); // Close drawer after tapping
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: showAbout ? AboutContent() : HomeContent(),
          ),
          Footer(),
        ],
      ),
    );
  }
}

// Home Page Content
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/bgnu.jpg', // Ensure the image exists in the assets folder
            width: 250,
            height: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            'Welcome to Baba Guru Nanak University Nankana Sahib',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


// About Page Content
class AboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          //Image.asset('assets/bgnu.png', height: 200), // About Image
          SizedBox(height: 20),
          Text(
            "This is an amazing Flutter app. Here, you will find great features.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

// Footer Widget
class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.grey[300],
      child: Center(
        child: Text("© Baba Nanak University Nankana Sahib | All Rights Reserved"),
      ),
    );
  }
}
