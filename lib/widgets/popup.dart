import 'package:flutter/material.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/widgets/primary_btn.dart';

Future<dynamic> popup(BuildContext context, String confirmText,
    {String? title, String? description, Function? confirmFunction}) {
  var size = MediaQuery.of(context).size;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: SizedBox(
            height: size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title != null)
                  SizedBox(
                    child: Text(
                      title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: text18black.copyWith(fontSize: 22),
                    ),
                  ),
                if (description != null)
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    width: double.infinity,
                    // height: 1.5 * 10,
                    child: Text(
                      description,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: text18black.copyWith(fontSize: 19),
                    ),
                  ),
                SizedBox(
                  height: 50,
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      primaryButton(
                          context: context,
                          height: 40,
                          width: 100,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 2),
                          color: Colors.white,
                          function: () => Navigator.pop(context),
                          widget: FittedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                "Cancel",
                                style: text18black.copyWith(fontSize: 20),
                              ),
                            ),
                          )),
                      primaryButton(
                          context: context,
                          height: 40,
                          width: 100,
                          borderRadius: BorderRadius.circular(10),
                          widget: FittedBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                confirmText,
                                style: text18white.copyWith(fontSize: 20),
                              ),
                            ),
                          ),
                          function: () {
                            if (confirmFunction != null) {
                              confirmFunction();
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
