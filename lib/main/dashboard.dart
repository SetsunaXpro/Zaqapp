import 'package:flutter/material.dart';
import 'package:zaqapp/main/placeholder.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZaqApp'), 
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildGridButton(
              context,
              title: 'Zakat Calculator',
              icon: Icons.calculate,
              color: Colors.teal,
              page: const PlaceholderPage(title: 'Zakat Calculator'),
            ),
            _buildGridButton(
              context,
              title: 'Pay Your Zakat',
              icon: Icons.wallet,
              color: Colors.indigo,
              page: const PlaceholderPage(title: 'Pay Your Zakat'),
            ),
            _buildGridButton(
              context,
              title: 'Donation History',
              icon: Icons.history,
              color: Colors.orange,
              page: const PlaceholderPage(title: 'Donation History'),
            ),
            _buildGridButton(
              context,
              title: 'Settings',
              icon: Icons.settings,
              color: Colors.grey,
              page: const PlaceholderPage(title: 'Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildGridButton(BuildContext context,
    {required String title,
    required IconData icon,
    required Color color,
    required Widget page}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page),
      );
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 48, color: Colors.white),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
