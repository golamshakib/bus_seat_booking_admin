import 'package:bus_seat_booking_admin/models/bus_model.dart';
import 'package:bus_seat_booking_admin/models/route_model.dart';
import 'package:bus_seat_booking_admin/models/schedule_model.dart';
import 'package:bus_seat_booking_admin/pages/schedule_page.dart';
import 'package:bus_seat_booking_admin/providers/route_provider.dart';
import 'package:bus_seat_booking_admin/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../providers/bus_and_schedule_provider.dart';

class NewSchedulePage extends StatefulWidget {
  static const String routeName = '/newschedule';

  const NewSchedulePage({super.key});

  @override
  State<NewSchedulePage> createState() => _NewSchedulePageState();
}

class _NewSchedulePageState extends State<NewSchedulePage> {
  final _timePickerController = TextEditingController();
  final _ticketPriceController = TextEditingController();
  final _discountPriceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  BusModel? _busModel;
  RouteModel? _routeModel;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Schedule'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 4.0),
              child: TextFormField(
                controller: _timePickerController,
                onTap: _timePicker,
                readOnly: true,
                decoration: InputDecoration(
                  label: const Text('Pick departure time'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _timePicker,
                    icon: const Icon(CupertinoIcons.time),
                  ),
                ),
                validator: (value) {
                  if (_selectedTime == null) {
                    return 'Select departure Time';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
              child: Consumer<BusAndScheduleProvider>(
                builder: (context, provider, child) =>
                    DropdownButtonFormField<BusModel>(
                  value: _busModel,
                  hint: const Text('Select Bus'),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  items: provider.getBusListByScheduleTime(_selectedTime?.format(context))
                      .map((bus) => DropdownMenuItem<BusModel>(
                            value: bus,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${bus.busName} - ${bus.busType}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(bus.busNumber),
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: _selectedTime== null ? null : (value) {
                    setState(() {
                      _busModel = value;
                    });
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select bus';
                    }
                    return null;
                  },
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
              child: Consumer<RouteProvider>(
                builder: (context, provider, child) =>
                    DropdownButtonFormField<RouteModel>(
                      value: _routeModel,
                      hint: const Text('Select Route'),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )
                      ),
                      items: provider.routeList
                          .map((route) => DropdownMenuItem<RouteModel>(
                        value: route,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${route.routeName} - ${route.distance.toStringAsFixed(2)} KM',
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text('${route.duration} hrs'),
                              ],
                            ),
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _routeModel = value;
                        });
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select route';
                        }
                        return null;
                      },
                    ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
              child: TextFormField(
                controller: _ticketPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Ticket price'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Provide ticket price';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 8.0),
              child: TextFormField(
                controller: _discountPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Discount price (Optional)'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30.0),
            Center(
              child: ElevatedButton(
                onPressed: _saveSchedule,
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                child: const Text(
                  'SAVE',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveSchedule() {
    if (_formKey.currentState!.validate()) {
      final selectedDateTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          _selectedTime!.hour,
          _selectedTime!.minute);
      final schedule = ScheduleModel(
        bus: _busModel!,
        route: _routeModel!,
        departureTimestamp: Timestamp.fromDate(selectedDateTime),
        departureTime: _selectedTime!.format(context),
        ticketPrice: num.parse(_ticketPriceController.text),
        discountPrice: _discountPriceController.text.isEmpty
            ? 0
            : num.parse(_discountPriceController.text),
      );
      EasyLoading.show(status: 'Please wait');
      context.read<BusAndScheduleProvider>().addSchedule(schedule).then((value) {
        if (!mounted) return;
        EasyLoading.dismiss();
        showMsg(context, 'Schedule Added', true);
        Navigator.pushReplacementNamed(context, SchedulePage.routeName);
      }).catchError((error) {
        if (!mounted) return;
        EasyLoading.dismiss();
        showMsg(context, error.toString(), false);
      });
    }
  }

  @override
  void dispose() {
    _timePickerController.dispose();
    _ticketPriceController.dispose();
    _discountPriceController.dispose();
    super.dispose();
  }

  Future<void> _timePicker() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
        _timePickerController.text = _selectedTime!.format(context);
      });
    }
  }
}
