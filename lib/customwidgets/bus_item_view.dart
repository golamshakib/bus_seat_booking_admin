import 'package:flutter/material.dart';

import '../models/bus_model.dart';

class BusItemView extends StatelessWidget {
  const BusItemView({
    super.key,
    required this.bus,
    required this.index,
  });

  final BusModel bus;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${index + 1}.', style: const TextStyle(fontSize: 16.0),),
      title: Text(bus.busName, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),),
      subtitle: Text(bus.busNumber,  style: const TextStyle(fontSize: 15.0),),
      trailing: Column(
        children: [
          Text(bus.busType,  style: const TextStyle(fontSize: 16.0),),
          Text('Seat: ${bus.totalSeat}',  style: const TextStyle(fontSize: 16.0),),
        ],
      ),
    );
  }
}
