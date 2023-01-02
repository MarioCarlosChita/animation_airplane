import 'package:animation_airplane/src/view/models/travel.dart';
import 'package:flutter/material.dart';
import 'airplane_card.dart';


class CardTravelers extends StatelessWidget {
  bool isSelected;
  double positionCard;
  final Travell  travell;
  int index ;
  AnimationController scaleAllTapTravell ;
  AnimationController positionAirplane;


  AnimationController selectedTravel ;
  Animation<double> selectedTravelValue ;

  CardTravelers({
    this.isSelected = false,
    required this.positionCard,
    required this.index ,
    required this.scaleAllTapTravell ,
    required this.positionAirplane ,
    required this.travell ,
    required this.selectedTravel,
    required this.selectedTravelValue
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Transform.translate(
            offset: Offset(0, isSelected ? positionCard-70 :index != 0? positionCard+25:positionCard),
            child: AnimatedBuilder(
                animation: selectedTravel,
                builder:  (context ,child){
                   return Transform.translate(
                     offset: Offset(0,isSelected ? selectedTravelValue.value :0),
                     child: Container(
                       height: 350,
                       margin: const EdgeInsets.only(left: 15, right: 15),
                       child: Stack(
                         children: [
                           Transform(
                             transform:Matrix4.identity()
                               ..setEntry(3, 2, 0.001)
                               ..rotateX(isSelected ? 0.0 :-1.2)
                               ..rotateZ(isSelected ? 0.0 :-0.01),
                             alignment: FractionalOffset.topCenter,
                             child: AnimatedScale(
                               scale:isSelected ? 1 :  index == 0 ?   (index+1)* 0.7 : (index+1)* 0.38,
                               duration:const Duration(milliseconds: 500) ,
                               child: AirplaneCard(
                                 isVisible: isSelected ,
                                 travell: travell,
                                 onpressTap: (){
                                   scaleAllTapTravell.forward();
                                   positionAirplane.forward();
                                 },
                                 onpressVertical:(detail){
                                   bool onTapDown  =  detail.primaryVelocity! >  0.0 ;
                                   if (onTapDown){
                                     selectedTravel.forward();
                                   }
                                 } ,
                               ),
                             )  ,
                           )
                         ],
                       ),
                     ),
                   );
                }
            )
        )
    );
  }




}
