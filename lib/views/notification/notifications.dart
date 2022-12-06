import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:jobuapp/views/notification/widgets/notification_app_bar.dart';
import 'package:jobuapp/views/notification/widgets/notification_body.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ThemeNotifier>().bgColor,
      body: SizedBox(
        child: Column(
          children: const [NotificationAppBar(), NotificationBody()],
        ),
      ),
    );
  }
}
