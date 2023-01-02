import 'package:animation_airplane/utils/theme.dart';
import 'package:flutter/material.dart';


class UserCirculeTopPerfil extends StatelessWidget {
  const UserCirculeTopPerfil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       width: 140,
       height: 40, 
       padding: const EdgeInsets.all(2),
       decoration: BoxDecoration(
         color: Colors.white.withOpacity(0.2),
         borderRadius: BorderRadius.circular(30)
       ),
       alignment: Alignment.centerLeft,
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           Container(
             width: 35,
             height: 35,
             decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(50),
                 color: Colors.blue , 
                 image: const DecorationImage(
                   image: AssetImage("assets/mario.jpeg")
                 )
             ), 
              
           ),
           Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text("1 386" ,style: TextStyle(
                color: kText,
                fontWeight:FontWeight.bold
            ),) ,
           ),
           Padding(
             padding: const EdgeInsets.only(left: 5),
             child: Text("Points" ,style: TextStyle(
                 color: Colors.white.withOpacity(0.8),
                 fontWeight:FontWeight.bold,
                 fontSize: 12
             ),) ,
           )
         ],
       ),
    );
  }
}
