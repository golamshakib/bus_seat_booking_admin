import 'package:bus_seat_booking_admin/models/bus_model.dart';
import 'package:bus_seat_booking_admin/pages/bus_page.dart';
import 'package:bus_seat_booking_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../providers/bus_and_schedule_provider.dart';

class NewBusPage extends StatefulWidget {
  static const String routeName = '/newbus';

  const NewBusPage({super.key});

  @override
  State<NewBusPage> createState() => _NewBusPageState();
}

class _NewBusPageState extends State<NewBusPage> {
  final _busNameController = TextEditingController();
  final _busNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  num? _totalSeat;
  String? _busType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bus'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 4.0),
              child: TextFormField(
                controller: _busNameController,
                decoration: InputDecoration(
                  label: const Text('Bus name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Provide bus name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 4.0),
              child: TextFormField(
                controller: _busNumberController,
                decoration: InputDecoration(
                  label: const Text('Bus number'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Provide bus number';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 4.0),
              child: DropdownButtonFormField<String>(
                value: _busType,
                hint: const Text('Select bus type'),
                items: busTypeList
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _busType = value;
                  });
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Provide bus type';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 36.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select total seat number',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Radio<num>(
                        value: BusTotalSeat.acBusinessSeat,
                        groupValue: _totalSeat,
                        onChanged: (value) {
                          setState(() {
                            _totalSeat = value;
                          });
                        },
                      ),
                      const Text(
                        '${BusTotalSeat.acBusinessSeat}',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 4.0),
                      Radio<num>(
                        value: BusTotalSeat.doubleDeckerSeat,
                        groupValue: _totalSeat,
                        onChanged: (value) {
                          setState(() {
                            _totalSeat = value;
                          });
                        },
                      ),
                      const Text(
                        '${BusTotalSeat.doubleDeckerSeat}',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(width: 4.0),
                      Radio<num>(
                        value: BusTotalSeat.nonAcSeat,
                        groupValue: _totalSeat,
                        onChanged: (value) {
                          setState(() {
                            _totalSeat = value;
                          });
                        },
                      ),
                      const Text(
                        '${BusTotalSeat.nonAcSeat}',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveBus,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                      child: const Text(
                        'SAVE',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveBus() {
    if (_totalSeat == null) {
      showMsg(context, 'Provide total seat number', false);
      return;
    }

    if (_formKey.currentState!.validate()) {
      final bus = BusModel(
        busName: _busNameController.text,
        busNumber: _busNumberController.text,
        busType: _busType!,
        totalSeat: _totalSeat!,
      );

      EasyLoading.show(status: 'Please wait');
      context.read<BusAndScheduleProvider>().addBus(bus).then((value) {
        if (!mounted) return;
        EasyLoading.dismiss();
        showMsg(context, 'Bus Added', true);
        Navigator.pushReplacementNamed(context, BusPage.routeName);
      }).catchError((error) {
        if (!mounted) return;
        EasyLoading.dismiss();
        showMsg(context, error.toString(), false);
      });
    }
  }

  @override
  void dispose() {
    _busNameController.dispose();
    _busNumberController.dispose();
    super.dispose();
  }
}
