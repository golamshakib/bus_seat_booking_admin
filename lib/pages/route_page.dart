import 'package:bus_seat_booking_admin/customwidgets/route_item_view.dart';
import 'package:bus_seat_booking_admin/pages/new_route_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/route_provider.dart';

class RoutePage extends StatelessWidget {
  static const String routeName = '/route';

  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewRoutePage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<RouteProvider>(
          builder: (context, provider, child) => provider.routeList.isEmpty
              ? const Center(
                  child: Text(
                  'Route not found',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ))
              : ListView.builder(
                  itemCount: provider.routeList.length,
                  itemBuilder: (context, index) {
                    final route = provider.routeList[index];
                    return RouteItemView(route: route, index: index);
                  },
                )),
    );
  }
}
