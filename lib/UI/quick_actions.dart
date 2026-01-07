import 'package:flutter/material.dart';
import 'package:zaqapp/main/calculator.dart';
import 'package:zaqapp/main/dashboard.dart';
import 'package:zaqapp/ui/payment.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
Expanded(
  child: _QuickActionButton(
    icon: Icons.calculate,
    label: 'Zakat\nCalculator',
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const CalculatorPage(
  
                ),)
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _QuickActionButton(
            icon: Icons.volunteer_activism,
            label: 'Pay\nZakat',
            onTap: () {
               showZakatPaymentSheet(context);
},
          ),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Icon(icon, size: 32),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
