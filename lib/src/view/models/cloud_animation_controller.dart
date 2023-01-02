


import 'package:animation_airplane/src/view/models/cloud.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class CloudAnimationController{
  AnimationController controller;
  Animation<Offset>   value;
  String imageUrl;


  CloudAnimationController({
    required this.controller ,
    required this.value,
    required this.imageUrl,
  });


  void onStart(){
     controller.forward();
  }

  void dispose(){
    controller.dispose();
  }

  void  restart(){
    controller.addStatusListener((status) {
       if (status ==AnimationStatus.completed || status == AnimationStatus.dismissed){
           controller.reset();
       }
    });
  }


}