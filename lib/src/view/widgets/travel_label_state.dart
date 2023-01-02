
import 'package:animation_airplane/utils/theme.dart';
import 'package:flutter/material.dart';
class TravelLabelState extends StatelessWidget {
  final String title;
  final Color  color;
  Color  textColor;

  TravelLabelState({
    required this.title,
    required this.color ,
    this.textColor = kText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      height: 60,
      child: Row (
        children: [
          Container(
            width: 25,
            height:25,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5)
            ),
          ),
          const SizedBox(width: 5,),
          Text(title,style:TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),)
        ],
      ),
    );
  }
}
