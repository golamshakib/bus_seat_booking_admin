import 'package:bus_seat_booking_admin/db/db_helper.dart';
import 'package:bus_seat_booking_admin/models/route_model.dart';
import 'package:flutter/foundation.dart';

class RouteProvider with ChangeNotifier {
  List<RouteModel> _routeList = [];

  List<RouteModel> get routeList => _routeList;

  Future<void> addRoute(RouteModel route) {
    return DbHelper.addRoute(route);
  }

  getAllRoutes() {
    DbHelper.getAllRoutes().listen((snapshot) {
      _routeList = List.generate(snapshot.docs.length,(index) =>
          RouteModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }
}
