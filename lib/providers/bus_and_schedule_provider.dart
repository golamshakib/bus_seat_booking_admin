import 'package:bus_seat_booking_admin/db/db_helper.dart';
import 'package:bus_seat_booking_admin/models/bus_model.dart';
import 'package:flutter/material.dart';
import '../models/schedule_model.dart';

class BusAndScheduleProvider with ChangeNotifier{

  List<BusModel> _busList = [];
  List<BusModel> get busList => _busList;

  List<ScheduleModel> _scheduleList = [];
  List<ScheduleModel> get scheduleList => _scheduleList;

  Future<void> addBus (BusModel bus) {
    return DbHelper.addBus(bus);
  }

  getAllBuses() {
    DbHelper.getAllBuses().listen((snapshot){
      _busList = List.generate(snapshot.docs.length, (index) =>
          BusModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  Future<void> addSchedule(ScheduleModel schedule) {
    return DbHelper.addSchedule(schedule);
  }

  getAllSchedules(){
    DbHelper.getAllSchedules().listen((snapshot){
      _scheduleList = List.generate(snapshot.docs.length, (index) =>
          ScheduleModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  List<BusModel> getBusListByScheduleTime(String? time){
    if(time == null) return busList;
    final filteredScheduleList = scheduleList.where((schedule)=> schedule.departureTime == time).toList();
    if (filteredScheduleList.isEmpty) return busList;
    final filteredBusList = <BusModel>[];
    for (final schedule in filteredScheduleList){
      filteredBusList.add(schedule.bus);
    }
    final tempBusList = List.generate(busList.length, (index)=> busList[index]);
    for (final bus in filteredBusList){
      tempBusList.remove(bus);
    }
    return tempBusList;
  }
}