import 'package:flutter/cupertino.dart';

import '';



void NavigationFade({required Widget widget ,required BuildContext context}){
  Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context ,animation , animated){
        return FadeTransition(
          opacity: animation,
          child: widget,
        );
      }
  ));
}