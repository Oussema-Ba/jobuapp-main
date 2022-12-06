import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/providers/auth_provider.dart';
import 'package:jobuapp/views/login/login.dart';
import 'package:jobuapp/views/login/validator.dart';
import 'package:jobuapp/widgets/custom_text_field.dart';
import 'package:jobuapp/widgets/primary_btn.dart';
import 'package:jobuapp/widgets/text_widget.dart';
import 'package:jobuapp/widgets/transparent_btn.dart';

import '../../providers/app_provider.dart';

class SignUpScreen extends StatefulWidget {
  final String email;
  final String name;
  final String photo;
  const SignUpScreen(
      {Key? key, this.email = "", this.name = "", this.photo = ""})
      : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formkey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  String photo = "";
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    Future.delayed(const Duration(milliseconds: 50)).then((value) {
      setState(() {
        nameController.text = widget.name;
        emailController.text = widget.email;
      });
    });

    photo = widget.photo;
    log("photo:$photo");
  }

  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return Scaffold(
      backgroundColor: style.bgColor,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 50, left: 20),
                    child: Txt(text: "Sign up", style: style.title)),
                SizedBox(
                  height: size.height * 0.05,
                ),
                CustomTextField(
                  hint: "Oliver Cydric",
                  controller: nameController,
                  validator: nameValidator,
                  focus: nameFocus,
                  label: "Name",
                  keybordType: TextInputType.name,
                ),
                CustomTextField(
                  hint: "exemple@email.com",
                  controller: emailController,
                  validator: emailValidator,
                  focus: emailFocus,
                  keybordType: TextInputType.emailAddress,
                  label: "Email",
                ),
                CustomTextField(
                  hint: "55 555 555",
                  controller: phoneController,
                  validator: phoneNumberValidator,
                  focus: phoneFocus,
                  label: "Phone",
                  keybordType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                CustomTextField(
                  hint: "Password",
                  controller: passwordController,
                  validator: passwordValidator,
                  focus: passwordFocus,
                  label: "Password",
                  isPassword: true,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: primaryButton(
                        context: context,
                        height: 50,
                        width: 200,
                        widget:  context.watch<AuthProvider>().isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white70,
                                ),
                              )
                            : Txt(
                                text: "SignUp",
                                style: text18black.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: lightBgColor.withOpacity(0.8))),
                        borderRadius: BorderRadius.circular(30),
                        function: () async {
                          if (formkey.currentState != null &&
                              formkey.currentState!.validate()) {
                            await context.read<AuthProvider>().signup(
                                context,
                                nameController.text,
                                emailController.text,
                                phoneController.text,
                                passwordController.text,
                                photo: photo);
                          }
                        }),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                Center(
                    child: Txt(
                        text: 'Or signup with one of the following options',
                        style: style.text18.copyWith(fontSize: 16))),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      transparentButton(
                          context: context,
                          height: 60,
                          width: 150,
                          widget: SvgPicture.asset("assets/images/google.svg",
                              height: 30,
                              width: 30,
                              color: style.invertedColor),
                          border: Border.all(
                              color: style.invertedColor.withOpacity(0.4),
                              width: 1),
                          borderRadius: BorderRadius.circular(18),
                          function: () async {
                            final user = await context
                                .read<AuthProvider>()
                                .googleLogIn(context, true);
                            if (user != null) {
                              nameController.text = user.displayName ?? "";
                              emailController.text = user.email;
                              photo = user.photoUrl ?? "";
                            }
                          }),
                      transparentButton(
                        context: context,
                        height: 60,
                        width: 150,
                        widget: SvgPicture.asset(
                          "assets/images/facebook.svg",
                          width: 30,
                          height: 30,
                          color: style.invertedColor,
                        ),
                        border: Border.all(
                            color: style.invertedColor.withOpacity(0.4),
                            width: 1),
                        borderRadius: BorderRadius.circular(18),
                        function: () => log("login with Facebook"),
                      )
                    ],
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: "Already have an account ?  ",
                            style: style.text18),
                        TextSpan(
                            text: 'Log in',
                            style: style.text18.copyWith(
                              color: style.btnColor,
                              fontWeight: FontWeight.w800,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                  )),
                      ],
                    ),
                  ),
                )),
                SizedBox(
                  height: size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
