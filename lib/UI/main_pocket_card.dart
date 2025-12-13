import 'package:flutter/material.dart';

class MainPocketCard extends StatelessWidget {
  const MainPocketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF9EE),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Main Pocket",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: const [
                  Text("Rp529"),
                  SizedBox(width: 6),
                  Icon(Icons.visibility_off, size: 18),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: const [
              Text("5065 6325 9029"),
              SizedBox(width: 8),
              Icon(Icons.copy, size: 16),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey),
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Recent Activity"),
                  SizedBox(width: 6),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
