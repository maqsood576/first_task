import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Maqsood E24',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              'BABA GURU NANAK UNIVERSITY',
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.jpg', height: 40),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/bgnu.jpg', height: 200, fit: BoxFit.cover),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Education is the foundation of a progressive society, and when it is blended with history and spiritual wisdom, it creates an institution that inspires generations. Baba Guru Nanak University (BGNU) is one such prestigious institution, named after Guru Nanak Dev Ji, the founder of Sikhism and a great advocate of education, peace, and humanity. Located in Nankana Sahib, Pakistan—the birthplace of Guru Nanak—this university serves as a center of academic excellence and cultural heritage.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildFooter(),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.blue,
      child: Text(
        '© 2025 Baba Guru Nanak University, Nankana Sahib.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

// Sidebar Drawer


class AppDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.person,
      'title': 'My Name',
      'page': (context) => GenericPage(title: 'My Name', label: 'Maqsood Ahmed'),
    },
    {
      'icon': Icons.input,
      'title': 'Input Screen',
      'page': (context) => GenericPage(
          title: 'Input Screen', label: 'Enter something', hasInput: true, hasButton: true),
    },
    {
      'icon': Icons.print,
      'title': 'Print Screen',
      'page': (context) => GenericPage(
          title: 'Print Screen', label: 'Type something to print', hasInput: true, hasButton: true),
    },
    {
      'icon': Icons.calculate,
      'title': 'Calculator',
      'page': (context) => CalculatorPage(), // ✅ Added Calculator Page
    },
    {
      'icon': Icons.grade,
      'title': 'Grade Book',
      'page': (context) => GradeBookPage(), // ✅ Added Grade Book Page
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school, size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text('BGNU Menu', style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
          ),
          ...menuItems.map((item) => ListTile(
            leading: Icon(item['icon'], color: Colors.blue),
            title: Text(item['title']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item['page'](context)), // ✅ Navigation Fixed
              );
            },
          )).toList(),
        ],
      ),
    );
  }
}


// Calculator Page
class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  String? selectedOperator;
  String result = "";
  bool showBlink = false;

  void calculateResult() {
    double num1 = double.tryParse(firstController.text) ?? 0;
    double num2 = double.tryParse(secondController.text) ?? 0;
    double res = 0;

    if (selectedOperator == "+") {
      res = num1 + num2;
    } else if (selectedOperator == "-") {
      res = num1 - num2;
    } else if (selectedOperator == "*") {
      res = num1 * num2;
    } else if (selectedOperator == "/") {
      res = num2 != 0 ? num1 / num2 : 0;
    } else {
      result = "Please select an operator!";
      return;
    }

    setState(() {
      result = "Result: $res";
      showBlink = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        showBlink = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: firstController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter first number",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: secondController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter second number",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedOperator,
              hint: const Text("Select Operator"),
              decoration: InputDecoration(border: OutlineInputBorder()),
              items: ["+", "-", "*", "/"].map((String operator) {
                return DropdownMenuItem<String>(
                  value: operator,
                  child: Text(operator),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedOperator = newValue;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateResult,
              child: const Text("Calculate"),
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

// Grade Book Page
class GradeBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grade Book')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/A.jpg', width: 150, height: 100, fit: BoxFit.cover),
                SizedBox(width: 20),
                Image.asset('assets/f.jpg', width: 150, height: 100, fit: BoxFit.cover),
              ],
            ),
            SizedBox(height: 20),
            _buildGradeRow('Subject','Grade','performance'),
            _buildGradeRow('Mathematics', 'A', 'Excellent'),
            _buildGradeRow('Science', 'B+', 'Very Good'),
            _buildGradeRow('English', 'A-', 'Good'),
            _buildGradeRow('History', 'B', 'Satisfactory'),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeRow(String subject, String grade, String remarks) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(subject, textAlign: TextAlign.center)),
          Expanded(child: Text(grade, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(remarks, textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic))),
        ],
      ),
    );
  }
}


class GenericPage extends StatefulWidget {
  final String title;
  final String? label;
  final bool hasInput;
  final bool hasButton;

  const GenericPage({
    required this.title,
    this.label,
    this.hasInput = false,
    this.hasButton = false,
    Key? key,
  }) : super(key: key);

  @override
  _GenericPageState createState() => _GenericPageState();
}

class _GenericPageState extends State<GenericPage> {
  TextEditingController controller = TextEditingController();
  String output = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.label != null) Text(widget.label!, style: TextStyle(fontSize: 18)),
            if (widget.hasInput) ...[
              TextField(controller: controller, decoration: InputDecoration(border: OutlineInputBorder())),
              SizedBox(height: 10),
            ],
            if (widget.hasButton)
              ElevatedButton(
                onPressed: () {
                  setState(() => output = controller.text);
                },
                child: Text(widget.title == "Print Screen" ? "Print" : "Submit"),
              ),
            if (output.isNotEmpty) Text(output, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
