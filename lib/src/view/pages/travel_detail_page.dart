
import 'package:animation_airplane/src/view/enum/travel_box_enum.dart';
import 'package:animation_airplane/src/view/models/travel.dart';
import 'package:animation_airplane/src/view/pages/flight_detail.dart';
import 'package:animation_airplane/src/view/pages/home_page.dart';
import 'package:animation_airplane/src/view/widgets/airplane_card.dart';
import 'package:animation_airplane/src/view/widgets/box_travel.dart';
import 'package:animation_airplane/src/view/widgets/travel_info.dart';
import 'package:animation_airplane/utils/theme.dart';
import 'package:flutter/material.dart';

import '../../../core/helper/helpers.dart';
import '../widgets/travel_label_state.dart';

class TravelDetailPage  extends StatefulWidget{
  final Travell travell;
  TravelDetailPage({required this.travell});
  State<TravelDetailPage> createState()  => _TravelDetailPage();
}

class _TravelDetailPage extends State<TravelDetailPage> with TickerProviderStateMixin {

  late AnimationController fadeController;
  late Animation<double> fadeValue;
  bool  selectedBox = false;
  bool selectedBox2 = false;


  late AnimationController airplaneController;
  late Animation<double>   airplaneValue;


  @override
  void initState() {
    super.initState();

    fadeController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds:300)
    )..addStatusListener((status) {
       if (status  == AnimationStatus.completed){
           NavigationFade(widget: const FlightDetail(), context: context);
       }
    });
    fadeValue = Tween<double>(
       begin: 1,
       end: 0
    ).animate(fadeController);

    airplaneController  = AnimationController(
      vsync: this,
      duration:const Duration(milliseconds:600)
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed){
          Future.delayed(const Duration(milliseconds: 400) ,(){
              fadeController.forward();
          });
        }
    });

    airplaneValue = Tween<double>(
       begin:120 ,
       end:10
    ).animate(airplaneController);

  }
  @override

  Widget build(BuildContext context) {
    Size  kmedia = MediaQuery.of(context).size;
    EdgeInsets kPadding  = MediaQuery.of(context).padding;


    return Scaffold(
      body: AnimatedBuilder(
        animation:  fadeController ,
        builder: (context,child){
           return FadeTransition(
               opacity: fadeValue,
               child: child,
           );
        },
        child:Container(
          width: kmedia.width,
          height: kmedia.height,
          padding: EdgeInsets.only(
              left: kPadding.left+10,
              top:  kPadding.top
          ),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/cloud.jpeg") ,
                  fit: BoxFit.cover
              )
          ),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(onPressed: (){
                NavigationFade(context: context , widget: HomePage());
              }, icon: const Icon(Icons.arrow_back ,color: Colors.white, size: 30,)),
              const Padding(
                padding: EdgeInsets.only(
                    left: 15,
                    top: 20
                ),
                child: Text("Round Trip",style: TextStyle(
                    color: kText ,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),),
              ) ,
              const SizedBox(height:5),
              AirplaneCard(
                onpressTap: (){},
                onpressVertical: (detail){},
                isVisible: true,
                 travell: widget.travell,
              ),
              Container(
                padding:const EdgeInsets.only(
                    left: 12 ,
                    right: 12
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TravelLabelState(
                      color:Colors.pink,
                      title:"Selected",
                    ) ,
                    TravelLabelState(
                      color:kBooked,
                      title:"Booked",
                      textColor: kBooked,
                    ),
                    TravelLabelState(
                      color:kAvaliable,
                      title:"Available",
                      textColor: kText,
                    )
                  ],
                ),
              ) ,
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _rowDetail(sector1: "A" ,sector2: "B"),
                    _rowDetail(sector1: "C" ,sector2: "D"),
                  ],
                ),
              ) ,
              const SizedBox(height:10,),
              Container(
                padding:const EdgeInsets.only(
                    left: 15 ,
                    right:24
                ),
                child: Row (
                  crossAxisAlignment:CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        _rowSpaceDetail(
                            box1: kBooked,
                            box2: kAvaliable ,
                            group: 1
                        ),
                        const SizedBox(height:15,),
                        _rowSpaceDetailSelected(
                          box2: kAvaliable,
                          box1: kBooked,
                        ),
                        const SizedBox(height:15,),
                        _rowSpaceDetail(
                            box1: kAvaliable,
                            box2: kBooked ,
                            group: 3
                        ),
                      ],
                    ) ,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        _rowSpaceDetail(
                            box1:  kAvaliable,
                            box2: kBooked ,
                            group: 4
                        ),
                        const SizedBox(height:15,),
                        _rowSpaceDetail(
                            box1:  kAvaliable,
                            box2: kBooked ,
                            group: 5
                        ),
                        const SizedBox(height:15,),
                        _rowSpaceDetailSelected2(
                          box1: kBooked ,
                          box2: kAvaliable
                        )

                      ],
                    )
                  ],
                ),
              ) ,
              const  SizedBox(height:40,) ,
              MaterialButton(
                  minWidth: 400,
                  height: 60,
                  color: kText,
                  disabledColor: Colors.grey,
                  onPressed: selectedBox || selectedBox2 ? (){
                    airplaneController.forward();
                  }:null,
                  child: const  Text("Continue",style: TextStyle(
                      color: Colors.white
                  ),)
              ) ,
              const SizedBox(height:5,),

              AnimatedBuilder(
                  animation: airplaneController,
                  builder: (context ,child){
                    return Transform.translate(
                         offset: Offset(0 ,airplaneValue.value) ,
                         child: child,
                     );
                  } ,
                 child: Center(
                   child: Image.asset("assets/airplane.png" ,width: 80,),
                 )),
            ],
          ),
        ) ,
      ),
    );
  }


  Widget _rowDetail({required String sector1 ,required String sector2}){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TravelInfo(
            title: sector1,
          ),
          TravelInfo(
            title: sector2,
          ),
        ],
      ),
    ) ;
  }


  Widget _rowSpaceDetail({required Color box1 ,required Color box2 ,required int group}){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          BoxTravel(colorBox: box1,travelBoxEnum: TravelBoxEnum.BOOKED),
          const SizedBox(width: 38,),
          BoxTravel(colorBox: box2 ,travelBoxEnum: TravelBoxEnum.AVAILABLE) ,
        ],
      ),
    ) ;
  }

  Widget _rowSpaceDetailSelected({required Color box1 ,required Color box2}){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          BoxTravel(colorBox: box1,travelBoxEnum: TravelBoxEnum.BOOKED),
          const SizedBox(width: 38,),
          InkWell(
             onTap: (){
               selectedBox = !selectedBox;
               selectedBox2 = false;
               setState(() {});
             } ,
             child:  BoxTravel(colorBox: selectedBox ? Colors.pink: box2 ,travelBoxEnum: TravelBoxEnum.AVAILABLE),
          ) ,
        ],
      ),
    );
  }


  Widget _rowSpaceDetailSelected2({required Color box1 ,required Color box2}){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          BoxTravel(colorBox: box1,travelBoxEnum: TravelBoxEnum.BOOKED),
          const SizedBox(width: 38,),
          InkWell(
            onTap: (){
              selectedBox2 = !selectedBox2;
              selectedBox  = false;
              setState(() {});
            } ,
            child:  BoxTravel(colorBox: selectedBox2 ? Colors.pink: box2 ,travelBoxEnum: TravelBoxEnum.AVAILABLE),
          ) ,
        ],
      ),
    );
  }
}
