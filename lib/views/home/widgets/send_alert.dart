import 'package:flutter/material.dart';
import 'package:jobuapp/constants/style.dart';

class SendAlertWidget extends StatelessWidget {
  const SendAlertWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // try {
        //   await FirebaseAuth.instance.verifyPhoneNumber(
        //       phoneNumber: "+21654230376",
        //       timeout: const Duration(seconds: 120),
        //       verificationCompleted: (AuthCredential authCredential) {
        //         log(authCredential.toString());
        //       },
        //       verificationFailed:
        //           (FirebaseAuthException firebaseAuthException) {
        //         log(firebaseAuthException.toString());
        //       },
        //       codeSent: (String verificationId, int? code) {
        //         log(verificationId);
        //         log(code.toString());
        //         TextEditingController _codeController = TextEditingController();
        //         showDialog(
        //             context: context,
        //             barrierDismissible: false,
        //             builder: (context) => AlertDialog(
        //                   title: const Text("Enter SMS Code"),
        //                   content: Column(
        //                     mainAxisSize: MainAxisSize.min,
        //                     children: <Widget>[
        //                       TextField(
        //                         controller: _codeController,
        //                       ),
        //                     ],
        //                   ),
        //                   actions: <Widget>[
        //                     FlatButton(
        //                       child: const Text("Done"),
        //                       textColor: Colors.white,
        //                       color: Colors.redAccent,
        //                       onPressed: () {
        //                         FirebaseAuth auth = FirebaseAuth.instance;

        //                         String smsCode = _codeController.text.trim();

        //                         var _credential =
        //                             PhoneAuthProvider.credential(
        //                                 verificationId: verificationId,
        //                                 smsCode: smsCode);
        //                         auth
        //                             .signInWithCredential(_credential)
        //                             .then((result) {
        //                               log(result.toString());
        //                           log("phone verifiyed");
        //                         }).catchError((e) {
        //                           print(e);
        //                         });
        //                       },
        //                     )
        //                   ],
        //                 ));
        //       },
        //       codeAutoRetrievalTimeout: (String time) {
        //         log(time.toString());
        //       });
        //   log(FirebaseAuth.instance.currentUser.toString());
        // } on Exception catch (e) {
        //   log(e.toString());
        // }
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 3), blurRadius: 10, color: Colors.black38)
            ],
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(255, 131, 0, 0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Send Alert to your Close one",
                  style: text18white.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  "Share your Location ",
                  style: text18white.copyWith(fontWeight: FontWeight.w200),
                ),
              ],
            ),
            const Spacer(),
            Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: const Icon(
                  Icons.health_and_safety_sharp,
                  color: Colors.red,
                  size: 50,
                )),
          ],
        ),
      ),
    );
  }
}
