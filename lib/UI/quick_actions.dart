import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: _ActionButton(title: 'Transfer & Pay')),
        SizedBox(width: 12),
        Expanded(child: _ActionButton(title: 'Scan QRIS')),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  const _ActionButton({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(title),
    );
  }
}
