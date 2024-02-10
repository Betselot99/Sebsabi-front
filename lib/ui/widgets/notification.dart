import 'package:flutter/material.dart';


Widget MyNotification(){
  return Stack(
    children: [
      IconButton(
        icon: const Icon(Icons.notifications, color: Color(0XFF909300),size: 30,),
        onPressed: (){},
      ),
      Positioned(
        right: 0,
        top: 0,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          constraints: const BoxConstraints(
            minWidth: 16,
            minHeight: 16,
          ),
          child: const Text(
            '2',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}