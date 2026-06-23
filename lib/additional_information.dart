import 'package:flutter/material.dart';

class AdditionalCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const AdditionalCard({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Column(
        children: [
          SizedBox(height: 10),
          Icon(icon, size: 45),
          SizedBox(height: 10),
          Text(label, style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}