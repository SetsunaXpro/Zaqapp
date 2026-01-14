import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  final int notificationCount;

  const HomeHeader({
    super.key,
    required this.name,
    required this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Assalamu'alaikum,",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              name.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.person_outline, size: 28),
            const SizedBox(width: 12),
            Stack(
              children: [
                const Icon(Icons.notifications_none, size: 28),
                if (notificationCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        notificationCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
