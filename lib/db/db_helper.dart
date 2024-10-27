import 'package:bus_seat_booking_admin/models/bus_model.dart';
import 'package:bus_seat_booking_admin/models/route_model.dart';
import 'package:bus_seat_booking_admin/models/schedule_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper {
  DbHelper._();
  static final _db = FirebaseFirestore.instance;
  static const String _collectionAdmin = 'Admins';
  static const String _collectionBus = 'Buses';
  static const String _collectionRoute = 'Routes';
  static const String _collectionSchedule = 'Schedules';

  static Future<bool> isAdmin(String uid) async {
    final snapshot = await _db.collection(_collectionAdmin).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addBus(BusModel bus) {
    final doc = _db.collection(_collectionBus).doc();
    bus.id = doc.id;
    return doc.set(bus.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllBuses(){
    return _db.collection(_collectionBus).snapshots();
  }

  static Future<void> addRoute(RouteModel route){
    final doc = _db.collection(_collectionRoute).doc();
    route.id = doc.id;
    return doc.set(route.toMap());
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllRoutes(){
    return _db.collection(_collectionRoute).snapshots();
  }

  static Future<void> addSchedule(ScheduleModel schedule){
    final doc = _db.collection(_collectionSchedule).doc();
    schedule.scheduleId = doc.id;
    return doc.set(schedule.toMap());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllSchedules(){
   return _db.collection(_collectionSchedule).snapshots();
  }

}
