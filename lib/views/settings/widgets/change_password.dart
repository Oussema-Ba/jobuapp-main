import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/views/login/validator.dart';
import 'package:jobuapp/widgets/primary_btn.dart';
import 'package:jobuapp/widgets/settings_text_field.dart';
import 'package:jobuapp/widgets/text_widget.dart';
import '../../../providers/app_provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPassword = TextEditingController(text: "");
  TextEditingController newPassword = TextEditingController(text: "");
  TextEditingController newPasswordConfirmed = TextEditingController(text: "");
  bool isObscureOld = true;
  bool isObscure = true;
  bool isObscureConfirmed = true;
  FocusNode oldPasswordFocus = FocusNode();
  FocusNode newPasswordFocus = FocusNode();
  FocusNode newPasswordConfirmedFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return DraggableScrollableSheet(
      initialChildSize: MediaQuery.of(context).viewInsets.bottom > 0 ? 1 : 0.6,
      expand: false,
      builder: (_, controller) => Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          color: style.bgColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Txt(
              text: "Change password".toUpperCase(),
              style: style.title.copyWith(
                  color: style.invertedColor.withOpacity(0.7), fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            SettingTextField(
                hint: "Old password",
                controller: oldPassword,
                isObscure: isObscureOld,
                isFinal: false,
                validator: (value) {
                  return null;
                },
                sufixIcon: IconButton(
                    onPressed: () => setState(() {
                          isObscureOld = !isObscureOld;
                        }),
                    icon: Icon(
                      !isObscureOld ? Icons.visibility : Icons.visibility_off,
                      color: primaryColor,
                    )),
                focus: oldPasswordFocus),
            SettingTextField(
                hint: "New passwoed",
                controller: newPassword,
                isObscure: isObscure,
                isFinal: false,
                validator: passwordValidator,
                sufixIcon: IconButton(
                    onPressed: () => setState(() {
                          isObscure = !isObscure;
                        }),
                    icon: Icon(
                      !isObscure ? Icons.visibility : Icons.visibility_off,
                      color: primaryColor,
                    )),
                focus: newPasswordFocus),
            SettingTextField(
                hint: "Confirm new password",
                controller: newPasswordConfirmed,
                isObscure: isObscureConfirmed,
                isFinal: true,
                validator: (value) {
                  return value == newPassword.text
                      ? null
                      : "New password doesn't match";
                },
                sufixIcon: IconButton(
                    onPressed: () => setState(() {
                          isObscureConfirmed = !isObscureConfirmed;
                        }),
                    icon: Icon(
                      !isObscureConfirmed
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: primaryColor,
                    )),
                focus: newPasswordConfirmedFocus),
            primaryButton(
                context: context,
                height: 60,
                width: size.width - 30,
                widget: Txt(
                    text: "Change password",
                    style: text18black.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: style.bgColor.withOpacity(0.9))),
                borderRadius: BorderRadius.circular(10),
                function: () => changePasswordvalidator(
                    context, oldPassword, newPassword, newPasswordConfirmed)),
          ],
        )),
      ),
    );
  }
}
