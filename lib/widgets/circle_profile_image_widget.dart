import 'package:flutter/material.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/constants/style.dart';

class CircleProfileImage extends StatelessWidget {
  final double size;
  final String img;
  final bool isAsset;
  const CircleProfileImage(
      {Key? key,
      required this.size,
      this.img = "assets/profile.jpg",
      this.isAsset = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var style = context.watch<ThemeNotifier>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: size,
        width: size,
        margin: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.red,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 1), blurRadius: 3, color: Colors.black12)
            ],
            border: Border.all(color: primaryColor, width: 3),
            image: img.isEmpty
                ? const DecorationImage(
                    image: AssetImage("assets/profile.jpg"), fit: BoxFit.cover)
                : DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
        // child: CircleAvatar(
        //   backgroundColor: primaryColor,
        //   radius: size,
        //   child: img.isEmpty
        //       ? CircleAvatar(
        //           backgroundColor: style.bgColor,
        //           backgroundImage: const AssetImage("assets/profile.jpg"),
        //           radius: size * 0.9,
        //         )
        //       : CircleAvatar(
        //           backgroundColor: style.bgColor,
        //           backgroundImage: NetworkImage(img),
        //           radius: size * 0.9,
        //         ),
        // ),
      ),
    );
  }
}
