import 'package:flutter/material.dart';
import 'package:jobuapp/constants/style.dart';

class BoxProfileImage extends StatelessWidget {
  final double size;
  final String img;
  final bool isAsset;
  const BoxProfileImage(
      {Key? key,
      required this.size,
      this.img = "assets/profile.jpg",
      this.isAsset = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: primaryColor, width: 2),
          image: img.isEmpty
              ? const DecorationImage(image: AssetImage("assets/profile.jpg"))
              : DecorationImage(image: NetworkImage(img)),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 1), blurRadius: 3, color: Colors.black12)
          ],
        ),
      ),
    );
  }
}
