import 'package:animation_airplane/src/view/enum/travel_box_enum.dart';
import 'package:flutter/material.dart';

class BoxTravel extends StatelessWidget {
  final Color colorBox;
  final TravelBoxEnum  travelBoxEnum;
  const BoxTravel({ 
    required this.colorBox ,
    required this.travelBoxEnum ,
  });

  @override
  Widget build(BuildContext context) {
    return Container( 
      width:60,
      height:60,
      decoration: BoxDecoration(
        color:colorBox ,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }


}
