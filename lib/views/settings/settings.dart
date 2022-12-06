import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jobuapp/views/settings/widgets/change_email.dart';
import 'package:jobuapp/views/settings/widgets/change_name.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/providers/auth_provider.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/views/settings/widgets/change_password.dart';
import 'package:jobuapp/views/settings/widgets/change_phone_number.dart';
import 'package:jobuapp/widgets/text_widget.dart';

import '../../providers/app_provider.dart';
import '../../widgets/popup.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().currentUser;
    var style = context.watch<ThemeNotifier>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: style.bgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.2,
              width: size.width,
              // color: Colors.amber,
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
                            offset: Offset(0, 3),
                            blurRadius: 10,
                            color: Colors.black38)
                      ],
                      color: primaryColor,
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.1 - 50,
                    left: 90,
                    child: Hero(
                      tag: "1",
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          // color: Colors.amber,
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 3),
                                blurRadius: 10,
                                color: Colors.black38)
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 45,
                          child: user!.image.toString().isEmpty
                              ? CircleAvatar(
                                  backgroundColor: style.bgColor,
                                  backgroundImage:
                                      const AssetImage("assets/profile.jpg"),
                                  radius: 45,
                                )
                              : CircleAvatar(
                                  backgroundColor: style.bgColor,
                                  backgroundImage: NetworkImage(user.image),
                                  radius: 45,
                                ),
                        ),
                      ),
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
                        tag: "settings",
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
                  Positioned(
                      right: 10,
                      top: size.height * 0.1 - 25,
                      child: SizedBox(
                        // width: 150,
                        child: InkWell(
                          onTap: () async => await popup(context, "Ok",
                              title: "Notification",
                              confirmFunction: () =>
                                  context.read<AuthProvider>().logOut(context),
                              description:
                                  "Are you sure you want to log out ?"),
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: style.bgColor,
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 3),
                                    blurRadius: 10,
                                    color: Colors.black38)
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  color: style.invertedColor,
                                  size: 30,
                                ),
                                const SizedBox(width: 10),
                                Txt(text: "Logout", style: style.text18),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => const ChangeName());
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: style.invertedColor,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Txt(text: user.fullName, style: style.text18),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: style.invertedColor,
              height: 0,
            ),
            InkWell(
              onTap: () async {
                await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => const ChangeEmail());
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: style.invertedColor,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Txt(text: user.email, style: style.text18),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: style.invertedColor,
              height: 0,
            ),
            InkWell(
              onTap: () async {
                await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => const ChangePhoneNumber());
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: style.invertedColor,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Txt(text: user.phoneNumber, style: style.text18),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: style.invertedColor,
              height: 0,
            ),
            InkWell(
              onTap: () async {
                await showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => const ChangePassword());
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      color: style.invertedColor,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Txt(text: "Change Password", style: style.text18),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: style.invertedColor,
              height: 0,
            ),
            Card(
              color: style.bgColor,
              elevation: 0,
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dark mode :",
                      style: style.text18,
                    ),
                    CupertinoSwitch(
                        activeColor: primaryColor,
                        value: style.darkMode,
                        onChanged: (value) => context
                            .read<ThemeNotifier>()
                            .changeDarkMode(value)),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: style.invertedColor,
              height: 0,
            ),
            Card(
              color: style.bgColor,
              elevation: 0,
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notification :",
                      style: style.text18,
                    ),
                    CupertinoSwitch(
                        activeColor: primaryColor,
                        value: context.watch<UserProvider>().isNotificationOn,
                        onChanged: (value) => log("activate notification")),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: style.invertedColor,
              height: 0,
            ),
            Card(
              color: style.bgColor,
              elevation: 0,
              child: Container(
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Location :",
                      style: style.text18,
                    ),
                    CupertinoSwitch(
                        activeColor: primaryColor,
                        value: user.locationActivated,
                        onChanged: (value) => log("activate location")),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: style.invertedColor,
              height: 0,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
