import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/models/user.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/services/user_service.dart';
import 'package:jobuapp/views/notification/widgets/friend_request_card.dart';

import '../../../providers/app_provider.dart';

class NotificationBody extends StatefulWidget {
  const NotificationBody({Key? key}) : super(key: key);

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody>
    with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var style = context.watch<ThemeNotifier>();
    var size = MediaQuery.of(context).size;
    Widget tabItem(
        {required String lable,
        required IconData icon,
        bool selected = false}) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: style.invertedColor,
            ),
            Text(
              lable,
              style: style.text18
                  .copyWith(fontWeight: selected ? FontWeight.bold : null),
            )
          ],
        ),
      );
    }

    return SizedBox(
      height: size.height * 0.85,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
            child: DefaultTabController(
              length: 2,
              child: TabBar(
                padding: const EdgeInsets.all(0),
                labelPadding: const EdgeInsets.all(0),
                controller: controller,
                labelStyle: style.text18.copyWith(color: Colors.black),
                onTap: (int i) => setState(() {}),
                tabs: [
                  tabItem(lable: 'Friends requests', icon: Icons.people),
                  tabItem(lable: 'Notifications', icon: Icons.notifications),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.75,
            child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                children: [
                  SizedBox(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .where("id",
                                isEqualTo: context
                                    .read<UserProvider>()
                                    .currentUser!
                                    .id!)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            UserModel user = UserModel.fromMap(
                                snapshot.data!.docs.first.data());
                            return user.requested.isNotEmpty
                                ? StreamBuilder<
                                        QuerySnapshot<Map<String, dynamic>>>(
                                    stream: UserService.getAllTrackedUser(
                                        user.requested),
                                    builder: (context, requestedData) {
                                      if (requestedData.connectionState ==
                                          ConnectionState.active) {
                                        List<dynamic> requestedUsers =
                                            requestedData
                                                .data!.docs
                                                .map((e) =>
                                                    UserModel.fromMap(e.data()))
                                                .toList();
                                        return ListView(
                                          children: requestedUsers
                                              .map((user) => FrindRequestCard(
                                                    user: user,
                                                  ))
                                              .toList(),
                                        );
                                      }
                                      return Center(
                                        child: Text(
                                          "No data found",
                                          style: style.text18,
                                        ),
                                      );
                                    })
                                : Center(
                                    child: Text(
                                      "No data found",
                                      style: style.text18,
                                    ),
                                  );
                          }
                          return Center(
                            child: Text(
                              "No data found",
                              style: style.text18,
                            ),
                          );
                        }),
                  ),
                  Center(
                    child: Text(
                      "notifications",
                      style: style.text18,
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }
}
