import 'dart:collection';

import 'package:animation_airplane/core/helper/helpers.dart';
import 'package:animation_airplane/src/view/models/travel.dart';
import 'package:animation_airplane/src/view/pages/flight_detail.dart';
import 'package:animation_airplane/src/view/pages/travel_detail_page.dart';
import 'package:animation_airplane/src/view/widgets/card_traveler.dart';
import 'package:animation_airplane/src/view/widgets/opacity_home_item.dart';
import 'package:animation_airplane/src/view/widgets/user_profile.dart';
import 'package:animation_airplane/utils/constants.dart';
import 'package:animation_airplane/utils/theme.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController letterWelcomeAnimation;
  late Animation<double> letterWelcomeValue;

  late AnimationController travelersController;
  late Animation<double> travelersValue;

  late AnimationController scaleAllTapTravell;
  late Animation<double> scaleAllTravellValue;
  bool bottomMenu = false;

  late AnimationController positionStart;
  late Animation<double> positionValue;

  late AnimationController rotateController;
  late Animation<double> rotateValue;

  late AnimationController scaleAirplane;
  late Animation<double> scaleAirplaneValue;

  late AnimationController startDownPositionController;
  late Animation<double> startDownPositionValue;

  late AnimationController selectedTravel ;
  late Animation<double> selectedTravelValue ;

  @override
  void initState() {
    super.initState();

    travelersController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    travelersValue = Tween<double>(begin: 0, end: 1).animate(travelersController);

    letterWelcomeAnimation = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          travelersController.forward();
        }
    });

    scaleAllTapTravell = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          bottomMenu = true;
          setState(() {});
        }
      });

    scaleAllTravellValue =
        Tween<double>(begin: 1, end: 0).animate(scaleAllTapTravell);

    letterWelcomeValue = Tween<double>(begin: 0, end: 1).animate(letterWelcomeAnimation);

    rotateController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    rotateValue = Tween<double>(begin: 0.51, end: -1.45).animate(rotateController);

    scaleAirplane = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    scaleAirplaneValue = Tween<double>(begin: 1, end: 0.5).animate(scaleAirplane);

    positionStart = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(const Duration(milliseconds: 400), () {
            scaleAirplane.forward();
            startDownPositionController.forward();
          });
        }
      });
    positionValue = Tween<double>(begin: 0, end: 125).animate(positionStart);

    _onListenAirplanePosition();

    startDownPositionController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))
    ..addStatusListener((status) {
       if (status == AnimationStatus.completed){
          Future.delayed(const Duration(milliseconds: 600) ,(){
            NavigationFade(context: context , widget: TravelDetailPage(travell: LIST_TRAVELL[2],));
          });
       }

    });
    startDownPositionValue = Tween<double>(begin: 0, end: 850).animate(startDownPositionController);

    selectedTravel  =  AnimationController(
        vsync: this,
        duration:const Duration(milliseconds:250)
    )..addStatusListener((status) {
       // change the head of the Array
       if (status == AnimationStatus.completed) {
         Travell  head =  LIST_TRAVELL[0];
         for (int index =0 ;  index <  LIST_TRAVELL.length ;  ++index){
           if (index +1  != LIST_TRAVELL.length) {
             LIST_TRAVELL [index] = LIST_TRAVELL[index +1];
           }
         }
         LIST_TRAVELL[LIST_TRAVELL.length -1] =  head;
         setState(() {});
         selectedTravel.reset();
       }

    });
    selectedTravelValue  =Tween<double>(
      begin: 0,
      end:250
    ).animate(selectedTravel);
  }




  void dispose() {
    letterWelcomeAnimation.dispose();
    scaleAllTapTravell.dispose();
    positionStart.dispose();
    rotateController.dispose();
    super.dispose();
  }

  void _onListenAirplanePosition() {
    positionStart.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotateController.forward();
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    letterWelcomeAnimation.forward();

    return Scaffold(
      body: Container(
        width: media.width,
        height: media.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/cloud.jpeg"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              OpacityHomeItem(
                  controller: scaleAllTapTravell,
                  animation: scaleAllTravellValue,
                  widget: const UserProfile()),
              OpacityHomeItem(
                  controller: scaleAllTapTravell,
                  animation: scaleAllTravellValue,
                  widget: AnimatedBuilder(
                    animation: letterWelcomeAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(10 * letterWelcomeValue.value, 0),
                        child: FadeTransition(
                          opacity: letterWelcomeValue,
                          child: child,
                        ),
                      );
                    },
                    child: _descritionAirplane(),
                  )),
              AnimatedBuilder(
                animation: scaleAirplane,
                builder: (context, child) {
                  return Transform.scale(
                      scale: scaleAirplaneValue.value, child: child);
                },
                child: AnimatedBuilder(
                  animation: startDownPositionController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, startDownPositionValue.value),
                      child: child,
                    );
                  },
                  child: AnimatedBuilder(
                    animation: positionStart,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(positionValue.value, 0),
                        child: child,
                      );
                    },
                    child: AnimatedBuilder(
                      animation: letterWelcomeAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(-120 * letterWelcomeValue.value, -30),
                          // offset: Offset(5.5*letterWelcomeValue.value, -30),
                          child: FadeTransition(
                            opacity: letterWelcomeValue,
                            child: child,
                          ),
                        );
                      },
                      child: AnimatedBuilder(
                        animation: rotateController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: (rotateValue.value * pi) / 4,
                            child: child,
                          );
                        },
                        child: Image.asset("assets/home_airplane.png"),
                      ),
                    ),
                  ),
                ),
              ),
              OpacityHomeItem(
                  controller: scaleAllTapTravell,
                  animation: scaleAllTravellValue,
                  widget: AnimatedBuilder(
                    animation: travelersController,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: travelersValue,
                        child: child,
                      );
                    },
                    child: Transform.translate(
                      offset: const Offset(0, -55),
                      child: _newletterAirplane(),
                    ),
                  )),
              OpacityHomeItem(
                  controller: scaleAllTapTravell,
                  animation: scaleAllTravellValue,
                  widget: Transform.translate(
                    offset: const Offset(0, 70),
                    child: AnimatedBuilder(
                      animation: travelersController,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: travelersValue,
                          child: child,
                        );
                      },
                      child: Transform.translate(
                        offset: const Offset(0, -100),
                        child: Container(
                          width: media.width,
                          height: 250,
                          child: Stack(
                            children:List.generate(3, (index) {
                              double position = ((3 - index)) * 45;
                              bool selectedCard = index + 1 == 3;

                              return CardTravelers(
                                positionCard: position,
                                isSelected: selectedCard,
                                index: index,
                                scaleAllTapTravell: scaleAllTapTravell,
                                positionAirplane: positionStart,
                                travell: LIST_TRAVELL[index],
                                selectedTravel: selectedTravel,
                                selectedTravelValue: selectedTravelValue,
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
      bottomSheet: bottomMenu ? const SizedBox.shrink()
          : OpacityHomeItem(
              controller: scaleAllTapTravell,
              animation: scaleAllTravellValue,
              widget: Container(
                height: 90,
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _menuIcon(
                        title: "Home",
                        icon: Icons.home_outlined,
                        isSelected: true),
                    _menuIcon(title: "Flights", icon: Icons.airplanemode_on),
                    _menuIcon(title: "Book", icon: Icons.search),
                    _menuIcon(title: "More", icon: Icons.more_horiz),
                  ],
                ),
              )
      ),
      extendBody: false,
    );
  }

  Widget _menuIcon(
      {required IconData icon,
      required String title,
      bool isSelected = false}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? kText : Colors.grey.withOpacity(0.8),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
                color:
                    isSelected ? Colors.black : Colors.grey.withOpacity(0.8)),
          )
        ],
      ),
    );
  }

  Widget _descritionAirplane() {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            "Jeniffer",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          SizedBox(height: 10),
          Text(
            "YOUR FLIGHT",
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            "IS IN 2 DAYS",
            style: TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _newletterAirplane() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Upcoming Flights",
            style:
                TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18),
          ),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(50)),
            child: Icon(
              Icons.add,
              color: kText,
            ),
          )
        ],
      ),
    );
  }
}
