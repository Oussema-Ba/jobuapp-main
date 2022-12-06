import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/providers/app_provider.dart';

GestureDetector primaryButton(
    {required BuildContext context,
    required double height,
    required double width,
    required Widget widget,
    Function? function,
    BorderRadius? borderRadius,
    Color? color,
    Border? border,
    LinearGradient? gradient}) {
  return GestureDetector(
    onTap: () async {
      if (function != null) {
        function();
      }
    },
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: gradient,
        boxShadow: [
          BoxShadow(
              blurRadius: 8,
              color: color != null
                  ? color.withOpacity(0.2)
                  : const Color.fromARGB(255, 153, 235, 255).withOpacity(0.2),
              spreadRadius: 2,
              offset: const Offset(0, 10)),
        ],
        border: border,
        color: color ?? context.read<ThemeNotifier>().btnColor,
        borderRadius: borderRadius,
      ),
      child: Center(child: widget),
    ),
  );
}
