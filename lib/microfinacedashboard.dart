import 'package:flutter/material.dart';

class MicrofinanceDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Microfinance Dashboard'),
      ),
      body: Center(
        child: Text(
          'Welcome, Microfinance!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
