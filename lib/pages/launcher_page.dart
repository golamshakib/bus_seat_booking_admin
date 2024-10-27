import 'package:bus_seat_booking_admin/pages/dashboard_page.dart';
import 'package:bus_seat_booking_admin/pages/login_page.dart';
import 'package:bus_seat_booking_admin/providers/firebase_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName = '/';
  const LauncherPage({super.key});

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 0), (){
      if (!mounted) return;
      if (context.read<FirebaseAuthProvider>().currentUser != null){
        Navigator.pushReplacementNamed(context, DashboardPage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
