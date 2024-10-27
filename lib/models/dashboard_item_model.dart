import 'package:bus_seat_booking_admin/pages/bus_page.dart';
import 'package:bus_seat_booking_admin/pages/reservation_page.dart';
import 'package:bus_seat_booking_admin/pages/route_page.dart';
import 'package:bus_seat_booking_admin/pages/schedule_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardItemModel {
  final String title;
  final IconData iconData;
  final String routeName;

  const DashboardItemModel({
    required this.title,
    required this.iconData,
    required this.routeName,
  });
}
const dashboardItemList = [
  DashboardItemModel(title: 'Bus', iconData: CupertinoIcons.bus, routeName: BusPage.routeName),
  DashboardItemModel(title: 'Routes', iconData: Icons.route, routeName: RoutePage.routeName),
  DashboardItemModel(title: 'Schedules', iconData: Icons.schedule, routeName: SchedulePage.routeName),
  DashboardItemModel(title: 'Reservations', iconData: Icons.book_online, routeName: ReservationPage.routeName),
];
