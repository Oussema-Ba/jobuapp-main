import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/providers/app_provider.dart';

class NotificationAppBar extends StatelessWidget {
  const NotificationAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return SizedBox(
      height: size.height * 0.15,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.1,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/pattern.png"),
                  fit: BoxFit.cover,
                  opacity: 0.1),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 3), blurRadius: 10, color: Colors.black38)
              ],
              color: primaryColor,
            ),
          ),
          Positioned(
            left: 10,
            top: size.height * 0.1 - 30,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Hero(
                tag: "notification",
                child: Container(
                  padding: const EdgeInsets.only(right: 5),
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: style.bgColor,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 10,
                          color: Colors.black38)
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: style.invertedColor,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
