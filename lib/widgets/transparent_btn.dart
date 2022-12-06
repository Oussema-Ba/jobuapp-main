
import 'package:flutter/material.dart';

GestureDetector transparentButton({required BuildContext context,required double height, required double width,required Widget widget, Function? function,BorderRadius? borderRadius, Color? color,Border? border}) {
  return GestureDetector(
    onTap: ()async{
      if(function!=null){
        function();
      }
    },
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border:border,
        color:Colors.white.withOpacity(0.1),
        borderRadius: borderRadius,
      ),
      child: Center(child: widget),
    ),
  );
}
