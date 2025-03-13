import 'package:flutter/material.dart';

class GradeBookScreen extends StatelessWidget {
  final List<Map<String, dynamic>> students = [
    {"name": "Ali", "marks": 95, "grade": "A+"},
    {"name": "kashif", "marks": 88, "grade": "A"},
    {"name": "Ahmed", "marks": 76, "grade": "B"},
    {"name": "Fatima", "marks": 65, "grade": "C"},
    {"name": "Hassan", "marks": 50, "grade": "Fail"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grade Book')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Student Grades",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Table(
              border: TableBorder.all(),
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.blue[200]),
                  children: [
                    tableCell("Name", true),
                    tableCell("Marks", true),
                    tableCell("Grade", true),
                  ],
                ),
                ...students.map((student) {
                  return TableRow(
                    children: [
                      tableCell(student["name"], false),
                      tableCell(student["marks"].toString(), false),
                      tableCell(student["grade"], false),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget tableCell(String text, bool isHeader) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: isHeader ? 18 : 16,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
