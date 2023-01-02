
import 'package:animation_airplane/utils/theme.dart';
import 'package:flutter/material.dart';

class TravelInfo extends StatelessWidget {
  final String title;
  TravelInfo({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:100,
      height:60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,style: const TextStyle(
            color: kText ,
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),) ,
          const SizedBox(height:10,),
          Container(
            width: 70,
            height:4,
            decoration:  BoxDecoration(
              color: kAvaliable , 
              borderRadius: BorderRadius.circular(50)
            ),
          ) ,

        ],
      ),
    );
  }
}
