import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:jobuapp/views/login/login.dart';
import 'package:jobuapp/views/login/signup.dart';
import 'package:jobuapp/widgets/primary_btn.dart';
import 'package:jobuapp/widgets/text_widget.dart';

import '../../providers/auth_provider.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  late Future<bool> getdata;
  @override
  void initState() {
    super.initState();
    getdata = context.read<AuthProvider>().checkLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return Scaffold(
      backgroundColor: style.bgColor,
      body: FutureBuilder(
          future: getdata,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == false) {
              // if (true) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.45,
                      width: size.width,
                      decoration: const BoxDecoration(
                        // color: Colors.amber,
                        image: DecorationImage(
                            image: AssetImage("assets/images/cropped.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    Txt(text: "Feel safe with us", style: style.title),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.07),
                      child: primaryButton(
                          context: context,
                          height: 50,
                          width: 260,
                          widget: Txt(
                              text: "Get started",
                              style: style.text18.copyWith(
                                fontWeight: FontWeight.w800,
                                color: lightBgColor,
                                fontSize: 20,
                              )),
                          borderRadius: BorderRadius.circular(30),
                          function: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
                              )),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 20, bottom: size.height * 0.15),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Already have an account ?  ',
                                style: style.text18.copyWith(fontSize: 16)),
                            TextSpan(
                                text: 'Log in',
                                style: style.text18.copyWith(
                                  fontSize: 16,
                                  color: style.btnColor,
                                  fontWeight: FontWeight.w800,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginScreen()),
                                      )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return const SizedBox();
          }),
    );
  }
}
