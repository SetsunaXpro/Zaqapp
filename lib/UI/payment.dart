import 'package:flutter/material.dart';
import 'package:zaqapp/UI/state.dart';

void showZakatPaymentSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _ZakatPaymentSheet(),
  );
}

class _ZakatPaymentSheet extends StatefulWidget {
  const _ZakatPaymentSheet();

  @override
  State<_ZakatPaymentSheet> createState() => _ZakatPaymentSheetState();
}

class _ZakatPaymentSheetState extends State<_ZakatPaymentSheet> {
  double _amount = 0;
  String _step = 'choice'; // choice | keypad
  String _type = '';

  void _selectSaved(double value, String type) {
    setState(() {
      _amount = value;
      _type = type;
      _step = 'keypad';
    });
  }

  void _addDigit(String digit) {
    setState(() {
      _amount = double.parse('$_amount$digit');
    });
  }

  void _deleteDigit() {
    setState(() {
      _amount = (_amount ~/ 10).toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: _step == 'choice' ? _choiceStep() : _keypadStep(),
    );
  }

  // ---------------- STEP 1: CHOICE ----------------

  Widget _choiceStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dragHandle(),
        const SizedBox(height: 16),
        const Text(
          'Pay Zakat / Donate',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),

        if (ZakatState.fitrahAmount > 0)
          _optionTile(
            title: 'Zakat Fitrah',
            subtitle:
                'Rp ${ZakatState.fitrahAmount.toStringAsFixed(0)}',
            onTap: () =>
                _selectSaved(ZakatState.fitrahAmount, 'Fitrah'),
          ),

        if (ZakatState.maalAmount > 0)
          _optionTile(
            title: 'Zakat Maal',
            subtitle: 'Rp ${ZakatState.maalAmount.toStringAsFixed(0)}',
            onTap: () =>
                _selectSaved(ZakatState.maalAmount, 'Maal'),
          ),

        _optionTile(
          title: 'Donate Freely',
          subtitle: 'Enter custom amount',
          onTap: () {
            setState(() {
              _amount = 0;
              _type = 'Donation';
              _step = 'keypad';
            });
          },
        ),
      ],
    );
  }

  // ---------------- STEP 2: KEYPAD ----------------

  Widget _keypadStep() {
    return Column(
      children: [
        _dragHandle(),
        const SizedBox(height: 16),
        Text(
          _type,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          'Rp ${_amount.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        Expanded(child: _keypad()),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
          ),
          onPressed: () {
            // TODO: connect payment gateway
            Navigator.pop(context);
          },
          child: const Text('Proceed to Payment'),
        ),
      ],
    );
  }

  // ---------------- UI PARTS ----------------

  Widget _keypad() {
    final keys = [
      '1','2','3',
      '4','5','6',
      '7','8','9',
      '','0','⌫'
    ];

    return GridView.builder(
      itemCount: keys.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (_, i) {
        final key = keys[i];
        if (key.isEmpty) return const SizedBox();
        return GestureDetector(
          onTap: () {
            if (key == '⌫') {
              _deleteDigit();
            } else {
              _addDigit(key);
            }
          },
          child: Center(
            child: Text(
              key,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        );
      },
    );
  }

  Widget _optionTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _dragHandle() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
