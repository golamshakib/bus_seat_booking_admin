import 'package:flutter/material.dart';

class ReservationPage extends StatelessWidget {
  static const String routeName = '/reservation';
  const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservations'),
      ),
    );
  }
}
