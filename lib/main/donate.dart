import 'package:flutter/material.dart';

class DonatePage extends StatelessWidget {
  final double amount;
  final String zakatType;

  const DonatePage({
    super.key,
    required this.amount,
    required this.zakatType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Zakat Type: $zakatType',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            Text(
              'Amount to Pay:',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              'Rp ${amount.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                // TODO: connect payment gateway
              },
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
