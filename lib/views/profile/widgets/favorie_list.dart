import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/models/user.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/services/user_service.dart';
import 'package:jobuapp/widgets/box_profile_image_widget.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return DraggableScrollableSheet(
      initialChildSize: 1,
      // initialChildSize: MediaQuery.of(context).viewInsets.bottom > 0 ? 1 : 0.6,
      expand: false,
      builder: (context, controller) => Container(
        margin:
            EdgeInsets.symmetric(horizontal: 20, vertical: size.height * 0.15),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
            color: style.bgColor, borderRadius: BorderRadius.circular(35)),
        child: FutureBuilder<List<UserModel>>(
          future: UserService.getUsersByIds(
              context.read<UserProvider>().currentUser!.followed),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              log(snapshot.data.toString());
              return ListView(
                children: snapshot.data != null
                    ? snapshot.data!
                        .map((user) => Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 50,
                                  child: Row(
                                    children: [
                                      BoxProfileImage(
                                        size: 40,
                                        img: user.image,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(user.fullName, style: style.text18),
                                      const Spacer(),
                                      !context
                                              .watch<UserProvider>()
                                              .currentUser!
                                              .sharedLocation
                                              .contains(user.id!)
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 4,
                                                  backgroundColor:
                                                      Colors.green),
                                              onPressed: () => context
                                                  .read<UserProvider>()
                                                  .addFavorite(context, user),
                                              child: Text(
                                                "Add Favorite",
                                                style: style.text18.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ))
                                          : ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 4,
                                                  backgroundColor: Colors.red),
                                              onPressed: () => context
                                                  .read<UserProvider>()
                                                  .removeFavorite(
                                                      context, user),
                                              child: Text(
                                                "Remove Favorite",
                                                style: style.text18.copyWith(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ))
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: style.invertedColor.withOpacity(0.3),
                                  thickness: 0.5,
                                )
                              ],
                            ))
                        .toList()
                    : [],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
