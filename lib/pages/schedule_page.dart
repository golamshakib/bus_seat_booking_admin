import 'package:bus_seat_booking_admin/customwidgets/schedule_item_view.dart';
import 'package:bus_seat_booking_admin/providers/bus_and_schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_schedule_page.dart';

class SchedulePage extends StatelessWidget {
  static const String routeName = '/schedule';

  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Schedule List'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, NewSchedulePage.routeName);
          },
          child: const Icon(Icons.add),
        ),
        body: Consumer<BusAndScheduleProvider>(
            builder: (context, provider, child) => provider.scheduleList.isEmpty
                ? const Center(
                    child: Text(
                    'Schedule not found',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ))
                : ListView.builder(
                    itemCount: provider.scheduleList.length,
                    itemBuilder: (context, index) {
                      final schedule = provider.scheduleList[index];
                      return ScheduleItemView(schedule: schedule, index: index);
                    },
                  )));
  }
}
