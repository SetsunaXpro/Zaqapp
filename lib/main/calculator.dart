import 'package:flutter/material.dart';
import 'package:zaqapp/UI/state.dart';
import 'package:zaqapp/UI/payment.dart';

enum ActiveField { people, ricePrice, wealth }

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController _peopleController = TextEditingController();
  final TextEditingController _ricePriceController =
      TextEditingController(text: '15000');
  final TextEditingController _wealthController = TextEditingController();

  ActiveField? _activeField;

  double _fitrahTotal = 0;
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

  // -------- KEYPAD LOGIC --------

  void _onKeyTap(String key) {
    final controller = _getActiveController();
    if (controller == null) return;

    setState(() {
      if (key == '⌫') {
        if (controller.text.isNotEmpty) {
          controller.text =
              controller.text.substring(0, controller.text.length - 1);
        }
      } else {
        if (controller.text == '0') {
          controller.text = key;
        } else {
          controller.text += key;
        }
      }
    });
  }

  TextEditingController? _getActiveController() {
    switch (_activeField) {
      case ActiveField.people:
        return _peopleController;
      case ActiveField.ricePrice:
        return _ricePriceController;
      case ActiveField.wealth:
        return _wealthController;
      default:
        return null;
    }
  }

  // -------- CALCULATIONS --------

  void _calculateFitrah() {
    final people = int.tryParse(_peopleController.text) ?? 0;
    final ricePrice = int.tryParse(_ricePriceController.text) ?? 0;
    final result = people * 25 * ricePrice / 10;

    setState(() => _fitrahTotal = result);
    ZakatState.fitrahAmount = result;
  }

  void _calculateMaal() {
    final wealth = int.tryParse(_wealthController.text) ?? 0;
    final result = wealth * 0.025;

    setState(() => _maalTotal = result);
    ZakatState.maalAmount = result;
  }

  // -------- UI --------

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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(child: _fitrahTab()),
                  SingleChildScrollView(child: _maalTab()),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: _keypad(),
            ),
          ],
        ),
      ),
    );
  }

  // -------- FITRAH TAB --------

  Widget _fitrahTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _inputField(
            label: 'Number of People',
            controller: _peopleController,
            field: ActiveField.people,
          ),
          const SizedBox(height: 16),
          _inputField(
            label: 'Rice Price per Kg (Rp)',
            controller: _ricePriceController,
            field: ActiveField.ricePrice,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _calculateFitrah,
            child: const Text('Calculate Zakat Fitrah'),
          ),
          const SizedBox(height: 24),
          Text(
            'Total: Rp ${_fitrahTotal.toStringAsFixed(0)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          if (_fitrahTotal > 0)
            ElevatedButton(
              onPressed: () => showZakatPaymentSheet(context),
              child: const Text('Pay Now'),
            ),
        ],
      ),
    );
  }

  // -------- MAAL TAB --------

  Widget _maalTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _inputField(
            label: 'Total Wealth (Rp)',
            controller: _wealthController,
            field: ActiveField.wealth,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _calculateMaal,
            child: const Text('Calculate Zakat Maal'),
          ),
          const SizedBox(height: 24),
          Text(
            'Total: Rp ${_maalTotal.toStringAsFixed(0)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          if (_maalTotal > 0)
            ElevatedButton(
              onPressed: () => showZakatPaymentSheet(context),
              child: const Text('Pay Now'),
            ),
        ],
      ),
    );
  }

  // -------- INPUT FIELD --------

  Widget _inputField({
    required String label,
    required TextEditingController controller,
    required ActiveField field,
  }) {
    final isActive = _activeField == field;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => setState(() => _activeField = field),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(
                color: isActive ? Colors.blue : Colors.grey.shade300,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              controller.text.isEmpty ? '0' : controller.text,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  // -------- KEYPAD --------

  Widget _keypad() {
    final keys = [
      '1','2','3',
      '4','5','6',
      '7','8','9',
      '','0','⌫',
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: keys.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (_, i) {
          final key = keys[i];
          if (key.isEmpty) return const SizedBox();

          return GestureDetector(
            onTap: () => _onKeyTap(key),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.08),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  key,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
