import 'package:flutter/material.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/views/login/validator.dart';
import 'package:jobuapp/widgets/primary_btn.dart';
import 'package:jobuapp/widgets/settings_text_field.dart';
import 'package:jobuapp/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../../../providers/app_provider.dart';
import '../../../providers/user_provider.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({super.key});

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  late TextEditingController oldName;
  late TextEditingController newName;
  FocusNode phoneFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    oldName = TextEditingController(
        text: context.read<UserProvider>().currentUser!.fullName.toString());
    newName = TextEditingController();
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
              text: "Change name".toUpperCase(),
              style: style.title.copyWith(
                  color: style.invertedColor.withOpacity(0.7), fontSize: 25),
            ),
            const SizedBox(
              height: 30,
            ),
            SettingTextField(
              hint: "",
              label: "Current name",
              controller: oldName,
              isEnabled: false,
              validator: (value) {
                return null;
              },
              focus: FocusNode(),
            ),
            SettingTextField(
              hint: "",
              controller: newName,
              isFinal: true,
              validator: nameValidator,
              focus: phoneFocus,
              label: "New name",
            ),
            const SizedBox(
              height: 20,
            ),
            primaryButton(
                context: context,
                height: 60,
                width: size.width - 30,
                widget: Txt(
                    text: "Change your name",
                    style: text18black.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: style.bgColor.withOpacity(0.9))),
                borderRadius: BorderRadius.circular(10),
                function: () => changeFullName(
                      context,
                      newName.text,
                    )),
          ],
        )),
      ),
    );
  }
}
