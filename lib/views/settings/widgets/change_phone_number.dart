import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/views/login/validator.dart';
import 'package:jobuapp/widgets/primary_btn.dart';
import 'package:jobuapp/widgets/settings_text_field.dart';
import 'package:jobuapp/widgets/text_widget.dart';

import '../../../providers/app_provider.dart';

class ChangePhoneNumber extends StatefulWidget {
  const ChangePhoneNumber({Key? key}) : super(key: key);

  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  late TextEditingController phone;
  late TextEditingController newPhone;
  FocusNode phoneFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    phone = TextEditingController(
        text: context.read<UserProvider>().currentUser!.phoneNumber.toString());
    newPhone = TextEditingController();
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
              text: "Change Phone Number".toUpperCase(),
              style: style.title.copyWith(
                  color: style.invertedColor.withOpacity(0.7), fontSize: 25),
            ),
            const SizedBox(
              height: 30,
            ),
            SettingTextField(
              hint: "",
              label: "Old phone number",
              controller: phone,
              isEnabled: false,
              keybordType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) {
                return null;
              },
              focus: FocusNode(),
            ),
            SettingTextField(
              hint: "55 555 555",
              controller: newPhone,
              isFinal: true,
              validator: phoneNumberValidator,
              focus: phoneFocus,
              label: "New phone number",
              keybordType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(
              height: 20,
            ),
            primaryButton(
                context: context,
                height: 60,
                width: size.width - 30,
                widget: Txt(
                    text: "Change phone number",
                    style: text18black.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: style.bgColor.withOpacity(0.9))),
                borderRadius: BorderRadius.circular(10),
                function: () =>
                    validatorPhone(context, phone.text, newPhone.text)),
          ],
        )),
      ),
    );
  }
}
