import 'package:bus_seat_booking_admin/models/dashboard_item_model.dart';
import 'package:flutter/material.dart';

class DashboardItemView extends StatelessWidget {
  const DashboardItemView({
    super.key,
    required this.item,
  });

 final DashboardItemModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, item.routeName);
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.iconData, size: 35.0),
              const SizedBox(height: 10.0),
              Text(item.title, style: const TextStyle(fontSize: 16.0),),
            ],
          ),
        ),
      ),
    );
  }
}
