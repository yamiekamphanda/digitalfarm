import 'package:flutter/material.dart';

class EnterpriseDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enterprise Dashboard'),
      ),
      body: Center(
        child: Text(
          'Welcome, Enterprise!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
