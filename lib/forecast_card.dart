import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;

  const ForecastCard({super.key, required this.time, required this.icon, required this.temp});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 150,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white30,
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              time,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: 5),
            Icon(icon, size: 35),
            SizedBox(height: 8),
            Text(temp, style: TextStyle(fontSize: 21)),
          ],
        ),
      ),
    );
  }
}