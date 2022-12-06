import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/views/notification/notifications.dart';
import 'package:jobuapp/views/settings/settings.dart';

import '../../../providers/app_provider.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().currentUser;
    var style = context.watch<ThemeNotifier>();
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.3,
      width: size.width,
      // color: Colors.amber,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.2,
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
            bottom: 0,
            left: 20,
            child: Hero(
              tag: "1",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 10,
                        color: Colors.black38)
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: 95,
                  child: user!.image.toString().isEmpty
                      ? CircleAvatar(
                          backgroundColor: style.bgColor,
                          backgroundImage:
                              const AssetImage("assets/profile.jpg"),
                          radius: 90,
                        )
                      : CircleAvatar(
                          backgroundColor: style.bgColor,
                          backgroundImage: NetworkImage(user.image),
                          radius: 90,
                        ),
                ),
              ),
            ),
          ),
          Positioned(
              right: 10,
              top: size.height * 0.2 - 30,
              child: SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        log("settings");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SettingsScreen()));
                      },
                      child: Hero(
                        tag: "settings",
                        child: Container(
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(15),
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
                              Icons.settings,
                              color: style.invertedColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        log("notifications");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const NotificationScreen()));
                      },
                      child: Hero(
                        tag: "notification",
                        child: Container(
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(15),
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
                          child: Icon(
                            Icons.notifications,
                            color: style.invertedColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
