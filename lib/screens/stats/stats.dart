import 'package:test_demo/screens/stats/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            const Text(
              "Trankection",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(12, 20, 12, 12),
                child: MyChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
