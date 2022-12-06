import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:jobuapp/widgets/text_widget.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      // height: 60,
      width: double.infinity,
      child: Center(
        child: Txt(
            text: " Jobu ",
            style: GoogleFonts.pacifico(
                fontSize: 45,
                fontWeight: FontWeight.w100,
                color: context.watch<ThemeNotifier>().invertedColor)),
      ),
    );
  }
}
