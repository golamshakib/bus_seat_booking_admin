import 'package:bus_seat_booking_admin/pages/bus_page.dart';
import 'package:bus_seat_booking_admin/pages/dashboard_page.dart';
import 'package:bus_seat_booking_admin/pages/launcher_page.dart';
import 'package:bus_seat_booking_admin/pages/login_page.dart';
import 'package:bus_seat_booking_admin/pages/new_bus_page.dart';
import 'package:bus_seat_booking_admin/pages/new_route_page.dart';
import 'package:bus_seat_booking_admin/pages/new_schedule_page.dart';
import 'package:bus_seat_booking_admin/pages/reservation_page.dart';
import 'package:bus_seat_booking_admin/pages/route_page.dart';
import 'package:bus_seat_booking_admin/pages/schedule_page.dart';
import 'package:bus_seat_booking_admin/providers/bus_and_schedule_provider.dart';
import 'package:bus_seat_booking_admin/providers/firebase_auth_provider.dart';
import 'package:bus_seat_booking_admin/providers/route_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FirebaseAuthProvider()),
        ChangeNotifierProvider(create: (context) => BusAndScheduleProvider()),
        ChangeNotifierProvider(create: (context) => RouteProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (context) => const LauncherPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        DashboardPage.routeName: (context) => const DashboardPage(),
        BusPage.routeName: (context) => const BusPage(),
        NewBusPage.routeName: (context) => const NewBusPage(),
        RoutePage.routeName: (context) => const RoutePage(),
        NewRoutePage.routeName: (context) => const NewRoutePage(),
        SchedulePage.routeName: (context) => const SchedulePage(),
        NewSchedulePage.routeName: (context) => const NewSchedulePage(),
        ReservationPage.routeName: (context) => const ReservationPage(),

      },
    );
  }
}

