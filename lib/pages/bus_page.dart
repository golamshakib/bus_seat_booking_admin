import 'package:bus_seat_booking_admin/pages/new_bus_page.dart';
import 'package:bus_seat_booking_admin/providers/bus_and_schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../customwidgets/bus_item_view.dart';

class BusPage extends StatefulWidget {
  static const String routeName = '/bus';

  const BusPage({super.key});

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewBusPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<BusAndScheduleProvider>(
          builder: (context, provider, child) => provider.busList.isEmpty
              ? const Center(
                  child: Text(
                  'Bus not found',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ))
              : ListView.builder(
                  itemCount: provider.busList.length,
                  itemBuilder: (context, index) {
                    final bus = provider.busList[index];
                    return BusItemView(bus: bus, index: index);
                  },
                )),
    );
  }
}
