import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/models/user.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/views/profile/public_profile.dart';

import '../../../providers/app_provider.dart';
import '../../../widgets/box_profile_image_widget.dart';

class FrindRequestCard extends StatelessWidget {
  final UserModel user;
  const FrindRequestCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = context.watch<ThemeNotifier>();
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => PublicProfileScreen(user: user))),
      child: Container(
        width: size.width,
        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: style.darkMode
                ? style.invertedColor.withOpacity(0.2)
                : Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoxProfileImage(
              size: 70,
              img: user.image,
            ),
            SizedBox(
              width: size.width * 0.4,
              child: Text(
                user.fullName,
                style: style.text18.copyWith(fontSize: 20),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () =>
                      context.read<UserProvider>().addFollow(context, user),
                  child: const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () => context.read<UserProvider>().removeRequest(
                      context,
                      sender: user,
                      user: context.read<UserProvider>().currentUser!.id!),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.red,
                    size: 50,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
