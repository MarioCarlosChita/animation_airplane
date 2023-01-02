
import 'package:animation_airplane/utils/theme.dart';
import 'package:flutter/material.dart';
class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: const EdgeInsets.only(
         right: 32 ,
         top:05
       ),
       child:    Text("SAS"  ,style: TextStyle(
           color: Colors.white.withOpacity(0.8),
           fontWeight: FontWeight.bold,
           fontSize: 32 ,
           letterSpacing: 0.5 ,
          fontStyle: FontStyle.italic
       ), )
    );
  }
}
