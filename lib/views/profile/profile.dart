import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:jobuapp/views/profile/widgets/profile_info_widget.dart';
import 'package:jobuapp/views/profile/widgets/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = context.watch<ThemeNotifier>();
    return Scaffold(
      backgroundColor: style.bgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
            child: Column(
          children: const [
            ProfileWidget(),
            ProfileInfoWidget(),
            // ConnectionListWidget(),
            // FavoriteListWidget(),
            SizedBox(height: 40),
          ],
        )),
      ),
    );
  }
}
