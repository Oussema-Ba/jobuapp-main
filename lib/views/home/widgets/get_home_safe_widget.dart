import 'package:flutter/material.dart';
import 'package:jobuapp/constants/style.dart';

class GetHomeWidget extends StatelessWidget {
  const GetHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // TextEditingController _codeController = TextEditingController();
        // TextEditingController id = TextEditingController();
        // showDialog(
        //     context: context,
        //     barrierDismissible: false,
        //     builder: (context) => AlertDialog(
        //           title: const Text("Enter SMS Code"),
        //           content: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: <Widget>[
        //               TextField(
        //                 controller: _codeController,
        //               ),
        //               TextField(
        //                 controller: id,
        //               ),
        //             ],
        //           ),
        //           actions: <Widget>[
        //             FlatButton(
        //               child: const Text("Done"),
        //               textColor: Colors.white,
        //               color: Colors.redAccent,
        //               onPressed: () {
        //                 FirebaseAuth auth = FirebaseAuth.instance;

        //                 String smsCode = _codeController.text.trim();

        //                 var _credential = PhoneAuthProvider.credential(
        //                     verificationId: id.text.trim(), smsCode: smsCode);
        //                 auth.signInWithCredential(_credential).then((result) {
        //                   log(result.toString());
        //                   log("phone verifiyed");
        //                 }).catchError((e) {
        //                   print(e);
        //                 });
        //               },
        //             )
        //           ],
        //         ));
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(offset: Offset(0, 3), blurRadius: 10, color: Colors.black38)
        ], borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get Home Safe",
                  style: text18black.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  "Share Location Periodically",
                  style: text18black.copyWith(fontWeight: FontWeight.w200),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 70,
              width: 70,
              child: Image.asset(
                "assets/images/safe.png",
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
