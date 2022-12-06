import 'package:flutter/material.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/views/login/validator.dart';
import 'package:jobuapp/widgets/primary_btn.dart';
import 'package:jobuapp/widgets/settings_text_field.dart';
import 'package:jobuapp/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_provider.dart';
import '../../../providers/user_provider.dart';

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({super.key});

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  late TextEditingController oldEmail;
  late TextEditingController newEmail;
  FocusNode phoneFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    oldEmail = TextEditingController(
        text: context.read<UserProvider>().currentUser!.email.toString());
    newEmail = TextEditingController();
  }

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
              text: "Change Email".toUpperCase(),
              style: style.title.copyWith(
                  color: style.invertedColor.withOpacity(0.7), fontSize: 25),
            ),
            const SizedBox(
              height: 30,
            ),
            SettingTextField(
              hint: "",
              label: "Current email",
              controller: oldEmail,
              isEnabled: false,
              validator: (value) {
                return null;
              },
              focus: FocusNode(),
            ),
            SettingTextField(
              hint: "exemple@exemple.com",
              controller: newEmail,
              isFinal: true,
              validator: nameValidator,
              focus: phoneFocus,
              label: "New Email",
            ),
            const SizedBox(
              height: 20,
            ),
            primaryButton(
                context: context,
                height: 60,
                width: size.width - 30,
                widget: Txt(
                    text: "Save",
                    style: text18black.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: style.bgColor.withOpacity(0.9))),
                borderRadius: BorderRadius.circular(10),
                function: () => changeEmail(
                      context,
                      newEmail.text,
                    )),
          ],
        )),
      ),
    );
  }
}
