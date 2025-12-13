import 'package:flutter/material.dart';
import 'package:zaqapp/UI/home_header.dart';
import 'package:zaqapp/UI/spotlight_carousel.dart';
import 'package:zaqapp/UI/quick_actions.dart';
import 'package:zaqapp/UI/main_pocket_card.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(
                name: "Muhammad Fahry",
                notificationCount: 5,
              ),
              const SizedBox(height: 16),
              const MainPocketCard(),
              const SizedBox(height: 20),
              const QuickActions(),
              const SizedBox(height: 24),
              const SpotlightCarousel(),
            ],
          ),
        ),
      ),
    );
  }
}



/* ---------------- NAVBAR PAGES ---------------- */



class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Calculator Page')),
    );
  }
}

class DonatePage extends StatelessWidget {
  const DonatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Donate Page')),
    );
  }
}

