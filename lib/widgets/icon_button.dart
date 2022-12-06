import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:jobuapp/providers/state_provider.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final int index;
  const CustomIconButton({Key? key, required this.icon, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.watch<StateProvider>().currentIndex == index;
    var style = context.watch<ThemeNotifier>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => context.read<StateProvider>().changeScreen(index),
        child: Icon(
          icon,
          color: isSelected
              ? style.btnColor
              : context.watch<ThemeNotifier>().invertedColor,
        ),
      ),
    );
  }
}
