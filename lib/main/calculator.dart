import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Fitrah
  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _ricePriceController =
      TextEditingController(text: '15000');

  double _fitrahTotal = 0;

  // Maal
  final TextEditingController _wealthController = TextEditingController();
  double _maalTotal = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _peopleController.dispose();
    _ricePriceController.dispose();
    _wealthController.dispose();
    super.dispose();
  }

  void _calculateFitrah() {
    final int people = int.tryParse(_peopleController.text) ?? 0;
    final double ricePrice =
        double.tryParse(_ricePriceController.text) ?? 0;

    setState(() {
      _fitrahTotal = people * 2.5 * ricePrice;
    });
  }

  void _calculateMaal() {
    final double wealth = double.tryParse(_wealthController.text) ?? 0;

    setState(() {
      _maalTotal = wealth * 0.025;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zakat Calculator'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Fitrah'),
            Tab(text: 'Maal'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _fitrahTab(),
          _maalTab(),
        ],
      ),
    );
  }

  // ---------------- FITRAH TAB ----------------

  Widget _fitrahTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Number of People'),
          const SizedBox(height: 8),
          TextField(
            controller: _peopleController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          const Text('Rice Price per Kg (Rp)'),
          const SizedBox(height: 8),
          TextField(
            controller: _ricePriceController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _calculateFitrah,
            child: const Text('Calculate Zakat Fitrah'),
          ),
          const SizedBox(height: 24),
          Text(
            'Total: Rp ${_fitrahTotal.toStringAsFixed(0)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ---------------- MAAL TAB ----------------

  Widget _maalTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Wealth (Rp)'),
          const SizedBox(height: 8),
          TextField(
            controller: _wealthController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _calculateMaal,
            child: const Text('Calculate Zakat Maal'),
          ),
          const SizedBox(height: 24),
          Text(
            'Total: Rp ${_maalTotal.toStringAsFixed(0)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
