import 'package:animation_airplane/src/view/widgets/logo.dart';
import 'package:animation_airplane/src/view/widgets/user_circule_top_perfil.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size kmedia = MediaQuery.of(context).size;
    double kdeviceScaleSize  =  (kmedia.height  / kmedia.width) *  0.5;

    EdgeInsets paddingDevice =MediaQuery.of(context).padding;
    return Container(
      padding: EdgeInsets.only(
        top :paddingDevice.top + kdeviceScaleSize *5,
        left:paddingDevice.left +   kdeviceScaleSize * 10,
      ),
      child:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
            UserCirculeTopPerfil() ,
            Logo()
        ],
      ),
    ) ;
  }
}
