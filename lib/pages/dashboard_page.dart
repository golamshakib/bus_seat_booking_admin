import 'package:bus_seat_booking_admin/customwidgets/dashboard_item_view.dart';
import 'package:bus_seat_booking_admin/models/dashboard_item_model.dart';
import 'package:bus_seat_booking_admin/providers/bus_and_schedule_provider.dart';
import 'package:bus_seat_booking_admin/providers/route_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dashboard';

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BusAndScheduleProvider>().getAllBuses();
    context.read<RouteProvider>().getAllRoutes();
    context.read<BusAndScheduleProvider>().getAllSchedules();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0 ,vertical: 20.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
            itemCount: dashboardItemList.length,
            itemBuilder: (context, index) {
              final item = dashboardItemList[index];
              return DashboardItemView(item: item);
            },
          ),
        ));
  }
}
