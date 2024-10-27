import 'package:bus_seat_booking_admin/models/route_model.dart';
import 'package:flutter/material.dart';

class RouteItemView extends StatelessWidget {
  const RouteItemView({
    super.key,
    required this.route,
    required this.index,
  });

  final RouteModel route;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        '${index + 1}.',
        style: const TextStyle(fontSize: 16.0),
      ),
      title: Text(
        route.routeName,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '${route.distance.toStringAsFixed(2)} KM',
        style: const TextStyle(fontSize: 15.0),
      ),
      trailing: Text('${route.duration?.toStringAsFixed(2)} hrs',
          style: const TextStyle(fontSize: 16.0)),
    );
  }
}
