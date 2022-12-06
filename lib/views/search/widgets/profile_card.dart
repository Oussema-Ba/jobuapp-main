import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/models/user.dart';
import 'package:jobuapp/providers/state_provider.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/views/profile/public_profile.dart';
import 'package:jobuapp/widgets/text_widget.dart';

import '../../../providers/app_provider.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = context.watch<ThemeNotifier>();
    return Card(
      color: style.bgColor,
      elevation: 2,
      child: ListTile(
        onTap: () => user.id == context.read<UserProvider>().currentUser!.id
            ? context.read<StateProvider>().changeScreen(3)
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PublicProfileScreen(user: user))),
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        subtitle:
            Txt(text: "See info", style: style.text18.copyWith(fontSize: 12)),
        leading: Hero(
          tag: user.id!,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                border: Border.all(color: style.invertedColor),
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(user.image), fit: BoxFit.cover)),
          ),
        ),
        title: Txt(text: user.fullName, style: style.text18),
      ),
    );
  }
}
