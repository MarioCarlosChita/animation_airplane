
import 'package:animation_airplane/core/helper/helpers.dart';
import 'package:animation_airplane/src/view/models/cloud_animation_controller.dart';
import 'package:animation_airplane/src/view/pages/home_page.dart';
import 'package:animation_airplane/utils/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class FlightDetail extends StatefulWidget {
  const FlightDetail({Key? key}) : super(key: key);

  @override
  State<FlightDetail> createState() => _FlightDetailState();
}

class _FlightDetailState extends State<FlightDetail> with TickerProviderStateMixin{

  late AnimationController airplaneController;
  late Animation<double>   airplaneScale;
  late Animation<double>   airplanePosition ;

  List<CloudAnimationController> cloudsController =[];

  late AnimationController  skyController ;
  late Animation<Offset>    skyPosition ;

  late AnimationController  curveAirplaneController;
  late Animation<double>    curveAirplaneValue;


  late AnimationController fadeSucessController;
  late Animation<double>   fadeSucessValue;


  final List<String> _cloudImages = const [
    "assets/cloud5.png",
    "assets/cloud5.png",
  ];

  @override
  void initState() {
    super.initState();
    curveAirplaneController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds:200),
    );
    curveAirplaneValue  =  Tween<double>(
      begin:  0 ,
      end: 5,
    ).animate(curveAirplaneController);
    airplaneController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1)
    );
    airplaneScale = Tween<double>(
      begin: 0.5,
      end:   1,
    ).animate(airplaneController);
    airplanePosition =  Tween<double>(
      begin: 0,
      end: 500,
    ).animate(airplaneController);
    skyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    skyPosition = Tween<Offset>(
        begin: const Offset(0 , 0) ,
        end: const  Offset(0, 300)
    ).animate(skyController);

    _cloudStartedAnimation();
    _onStarAirplane();
    _onAirplaneAnimationListen();

    fadeSucessController = AnimationController(
        vsync:this ,
        duration: const Duration(milliseconds: 400)
    );

    fadeSucessValue =   Tween<double>(
      begin: 0,
      end:   1,
    ).animate(fadeSucessController);

    _onListenCloudAnimation();

  }

  void dispose(){
    airplaneController.dispose();
    super.dispose();
  }

  void _onStarAirplane(){
    Future.delayed(const Duration(milliseconds:500),(){
      airplaneController.forward();
    });
  }

  _onAirplaneAnimationListen(){
    airplaneController.addStatusListener((status) {
      if (status == AnimationStatus.forward){
        _onStartedCloud();
      }
      if(status ==AnimationStatus.completed){
        curveAirplaneController.forward();
      }
    });
  }

  _onStartedCloud(){
    for (int index = 0 ; index <cloudsController.length; ++index){
          cloudsController[index].controller.forward();
    }
  }
  void _cloudStartedAnimation(){
    for (int index  = 0 ; index < _cloudImages.length; ++index){

      AnimationController  _cloudController =    AnimationController(
          vsync: this,
          duration: const Duration(seconds:2)
      );
      CloudAnimationController cloud  = CloudAnimationController(
        controller:_cloudController,
        value:  Tween<Offset>(
            begin:Offset(index % 2 == 0 ? 0 : 120 +0.5*index+120, index % 2 ==0? 0:10*index + 120),
            end:Offset(index % 2 == 0 ? 0 : 120 +0.5*index+120, 750)
        ).animate(_cloudController),
        imageUrl: _cloudImages[index],
      );
      cloudsController.add(cloud);
    }
  }


  void _onListenCloudAnimation(){
    cloudsController[0].controller.addStatusListener((status) {
        if (status == AnimationStatus.completed){
            fadeSucessController.forward();
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return  Scaffold(
      body: Container(
        width: media.width,
        height: media.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/cloud.jpeg"),
                fit: BoxFit.cover
            )
        ),
        child: Stack(
          children: [
            Container(
              width: media.width,
              alignment: Alignment.center,
              child:  AnimatedBuilder(
                animation: fadeSucessController,
                builder: (context ,child){
                  return  FadeTransition(
                    opacity: fadeSucessValue ,
                    child: child,
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Text("TRIP ID: 112358" ,style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold ,
                        fontSize: 28
                    ),),
                    const SizedBox(height:10,),
                    const Icon(
                        Icons.check_circle_outline_outlined,
                        size:80,
                        color:Colors.white
                    ),
                    const  SizedBox(height: 80,),
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.asset("assets/complete.png"),
                    ) ,
                    const SizedBox(height:120,) ,
                    MaterialButton(
                        onPressed: (){
                           NavigationFade(widget: HomePage(), context: context);
                        },
                        minWidth: 320,
                        height:60,
                        color: Colors.white,
                        child: const Text("Continue",style: TextStyle(
                          color: kText ,
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),),
                    )
                  ],
                ),
              ),
            ) ,
            for (var cloud  in cloudsController)
              AnimatedBuilder(
                animation: cloud.controller,
                builder: (context , child){
                  return  Transform.translate(
                    offset: cloud.value.value,
                    child: child,
                  );
                },
                child: Container(
                  width: 400,
                  height: 400,
                  child: Image.asset(cloud.imageUrl),
                ),
              ),
              AnimatedBuilder(
              animation: curveAirplaneController,
              builder: (context,child){
                return  Transform (
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..rotateX(curveAirplaneValue.value  * pi /  4),
                  // ..setRotationZ(curveAirplaneValue.value  * pi /  4),
                  child: child,
                );
              } ,
              child: AnimatedBuilder(
                animation: airplanePosition,
                builder: (context,child){
                  return Transform.translate(
                    offset: Offset(media.width / 4 , (media.height-200) - airplanePosition.value),
                    child: child,
                  );
                } ,
                child: AnimatedBuilder(
                  animation: airplaneScale,
                  builder: (context , child){
                    return  Transform.scale(
                      scale: airplaneScale.value,
                      child: child,
                    );
                  },
                  child:Container(
                    width: 200,
                    height: 200,
                    child: Image.asset("assets/airplane.png"),
                  ),
                ),
              ) ,
            )
          ],
        ),
      ),
    );
  }
}
