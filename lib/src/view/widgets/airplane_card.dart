import 'dart:math';
import 'package:animation_airplane/src/view/models/travel.dart';
import 'package:animation_airplane/utils/theme.dart';
import 'package:flutter/material.dart';


typedef  onPressTapCardTraveler = Function ();
typedef  onPressVerticalCardTraveler = Function(DragEndDetails detail);

class AirplaneCard extends  StatelessWidget {

  bool isVisible;
  onPressTapCardTraveler onpressTap;
  final Travell  travell;
  onPressVerticalCardTraveler  onpressVertical;

  AirplaneCard({
    this.isVisible = false,
    required this.onpressTap ,
    required this.onpressVertical,
    required this.travell
  });

  @override
  Widget build(BuildContext context) {
    Size media =MediaQuery.of(context).size;
    return Container(
      width: media.width,
      height: 220,
      padding: const EdgeInsets.all(10),

      child: GestureDetector(
         onTap: onpressTap,
         onVerticalDragEnd: onpressVertical,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             _cardTop(media: media),
             _cardDown(media:media)
           ],
         ),
      ),
    );
  }

  Widget _cardTop ({required Size media}){
    return Container(
       width: media.width,
       padding: const EdgeInsets.all(10),
       height:90,
       decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft:  Radius.circular(10)
          ) ,
         // color:Color(0xFFf5f5f5),
         color:   isVisible  ? const  Color(0xFFf5f5f5) :const Color(0xFFf5f5f5).withOpacity(0.9)
      ),
       child: isVisible ?  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _labelInformation(
              title: travell.fromTitle,
              time:   travell.fromTime
          ),
          Center(
             child:  _airplaneTraveler(),
          ),
          _labelInformation(
              title: travell.toTitle,
              time:   travell.toTime
          ),
        ],
      ) : const SizedBox.shrink(),
    );
  }

  Widget _airplaneTraveler(){
     return  Container(
       width: 190,
       height: 80,
       alignment: Alignment.center,
       padding: const EdgeInsets.only(
         top:20
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Stack(
             children: [
               Container(
                 height: 2,
                 width: 190,
                 decoration:BoxDecoration(
                     color: Colors.grey.withOpacity(0.08),
                     borderRadius: BorderRadius.circular(90)
                 )
               ) ,
               Transform.translate(
                 offset: const Offset(75, -14.8),
                 child: Transform.rotate(
                   angle: (pi * 10 ) / 4 ,
                   child:  const Icon(Icons.airplanemode_on_outlined ,  color:kText, size:32),
                 ),
               ),

             ],
           ) ,
           Text(travell.delay,style: const TextStyle(
             color: kText,
             fontWeight: FontWeight.w500 ,
           ),)
         ],
       ),
     );
  }

  Widget _cardDown({required Size media}) {
    return Container(
      width: media.width,
      height: 80,
      alignment: Alignment.center, 
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(10),
            bottomLeft:  Radius.circular(10)
        ) ,
        color: isVisible  ? Colors.white:const Color(0xFFf5f5f5).withOpacity(0.9),
      ),
      child: isVisible ? Row(
        crossAxisAlignment:  CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _labelDescription(time: travell.airCompany ,title: "Flight") ,
          _labelDescription(time: travell.bundleType ,title: "Bundle") ,
          _passagerDescrition(title: "Travelers")
        ],
      ) : const SizedBox.shrink(),
    );
  }


  Widget _labelInformation({required String title ,required String time}){
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Text(title , style: const TextStyle(
            color: kText,
            fontSize: 32,
            fontWeight: FontWeight.bold
          )),
          Text(time ,style:const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300
          ),)
        ],
      ),
    );
  }

  Widget _labelDescription({required String title ,required String time}){
    return Container(
      padding: const EdgeInsets.all(5),
      height: 55,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Text(title , style:const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold
          )),
          const SizedBox(height:3,),
          Text(time ,style: const TextStyle(
              color: kText,
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),)
        ],
      ),
    );
  }

  Widget _passagerDescrition({required String title}) {
    return Container(
      height: 80,
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.start ,
         children: [
            Text(title ,style: const TextStyle(
              color:  Colors.grey
            ),),
            const SizedBox(height:2,),
            Container(
              height:30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _circuleProfileTravelers(),
                   const  SizedBox(width: 3,),
                  _circuleProfileTravelers()
                ],
              ),
            )
         ],
      ),
    );
  }
  
  Widget _circuleProfileTravelers(){
     return    Container(
       height:25,
       width: 25,
       alignment: Alignment.centerLeft,
       decoration:  BoxDecoration(
         image: const DecorationImage(image: AssetImage("assets/mario.jpeg")),
         borderRadius: BorderRadius.circular(30)
       ),
     ); 
  }
}