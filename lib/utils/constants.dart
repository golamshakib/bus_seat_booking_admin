import 'package:flutter/material.dart';

// C U R R E N C Y S Y M B O L
const String currency = '৳';

// B U S   T Y P E   L I S T
const busTypeList = ['AC-Business', 'AC-Economy', 'non-AC'];

// B U S   T O T A L   S E A T
abstract final class BusTotalSeat {
  static const num acBusinessSeat = 28;
  static const num doubleDeckerSeat = 30;
  static const num acEconomySeat = 36;
  static const num nonAcSeat = 36;
}

// R O U T E   T Y P E   L I S T
const routeTypeList = [
  'Dhaka', 'Chittagong', 'Khulna', 'Rajshahi', 'Sylhet', 'Barisal', 'Rangpur',
  'Comilla', 'Narayanganj', 'Gazipur','Mymensingh', 'Dinajpur', 'Bogra', 'Jessore',
  'Saidpur', 'Brahmanbaria', 'Pabna', 'Tangail', 'Kushtia', 'Faridpur', 'Cox\'s Bazar',
  'Narsingdi', 'Feni', 'Chandpur', 'Lakshmipur', 'Noakhali', 'Habiganj', 'Sunamganj',
  'Netrokona','Moulvibazar', 'Sherpur', 'Jamalpur', 'Thakurgaon', 'Panchagarh',
  'Nilphamari', 'Lalmonirhat', 'Gaibandha', 'Kurigram', 'Natore', 'Sirajganj',
  'Naogaon', 'Joypurhat', 'Chapainawabganj', 'Satkhira', 'Meherpur', 'Jhenaidah',
  'Magura', 'Narail', 'Bagerhat', 'Pirojpur', 'Jhalokati', 'Patuakhali', 'Barguna',
  'Bhola',
];

// E R R O R    M E S S A G E   M E T H O D
showMsg(BuildContext context, String msg, bool isSuccess){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.only(bottom: 0.0),
      backgroundColor: Colors.transparent, // No background color
      elevation: 0, // No shadow
      behavior: SnackBarBehavior.floating,
      content: Center(
        child: Text(
          msg,
          style: TextStyle(color: isSuccess? Colors.green : Colors.redAccent,
              fontWeight: FontWeight.w500), // Text color
        ),
      ),
    ),
  );
}

