import 'package:flutter/material.dart';
import 'package:jobuapp/providers/data_provider.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/views/home/widgets/service_widget.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:jobuapp/views/profile/widgets/profile_info_widget.dart';
import 'package:jobuapp/views/profile/widgets/profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50)).then((value) => context
        .read<DataProvider>()
        .getUserServices(context.read<UserProvider>().currentUser!.id!));
  }

  @override
  Widget build(BuildContext context) {
    var style = context.watch<ThemeNotifier>();
    return Scaffold(
      backgroundColor: style.bgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
            child: Column(
          children: [
            const ProfileWidget(),
            const ProfileInfoWidget(),
            // ConnectionListWidget(),
            // FavoriteListWidget(),

            ...context
                .watch<DataProvider>()
                .myServices
                .map((service) => ServiceWidget(service: service))
                .toList(),
            const SizedBox(height: 40),
          ],
        )),
      ),
    );
  }
}
