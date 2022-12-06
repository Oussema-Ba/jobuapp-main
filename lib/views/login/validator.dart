// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/services/shared_data.dart';
import 'package:jobuapp/services/user_service.dart';
import 'package:jobuapp/widgets/popup.dart';

String? Function(dynamic) phoneNumberValidator = (value) {
  return value.toString().length == 8
      ? null
      : value.toString().isEmpty
          ? "Phone number is required"
          : "Phone number invalid";
};

String? Function(dynamic) nameValidator = (value) {
  bool nameValid = RegExp(r"^[a-zA-Z]").hasMatch(value ?? " ") ||
      !RegExp("^[\u0000-\u007F]+\$").hasMatch(value ?? " ");

  return value.toString().isEmpty
      ? "Please enter your name"
      : value.toString().length < 3
          ? 'Too short'
          : !nameValid
              ? "Wrong name format"
              : null;
};

String? Function(dynamic) emailValidator = (value) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value ?? " ");
  return !emailValid ? '' : null;
};

String? Function(dynamic) passwordValidator = (value) {
  String msg = "Password must include:\n";

  msg += !RegExp(r'^(?=.*?[A-Z])').hasMatch(value ?? "")
      ? "An uppercase character\n"
      : "";
  msg += !RegExp(r'^(?=.*?[a-z])').hasMatch(value ?? "")
      ? "A lowercase character\n"
      : "";
  msg += !RegExp(r'^(?=.*?[0-9])').hasMatch(value ?? "")
      ? "A numeric character\n"
      : "";
  msg += !RegExp(r'^(?=.*?[!@#\$&*~])').hasMatch(value ?? "")
      ? r"A special character (!@#\$&*~)" "\n"
      : "";
  msg += value.toString().length < 8 ? "A minimum of 8 character" : "";

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  var result = RegExp(pattern).hasMatch(value ?? "");

  return !result ? msg : null;
};

Future<void> changePasswordvalidator(BuildContext context, oldPassword,
    newPassword, newPasswordConfirmed) async {
  if (newPasswordConfirmed.text.isEmpty || newPassword.text.isEmpty) {
    await popup(context, "Ok",
        title: "Notification", description: "All fields are required.");
  } else if (newPasswordConfirmed.text != newPassword.text) {
    await popup(context, "Ok",
        title: "Notification", description: "New passwords doesn't match.");
  } else if (oldPassword.text != DataPrefrences.getPassword()) {
    await popup(context, "Ok",
        title: "Notification", description: "Old password incorrect.");
  } else {
    bool result = await context
        .read<UserProvider>()
        .changePassword(context, newPassword.text);

    if (result) {
      await popup(context, "Ok",
          title: "Notification", description: "Password changed seccesfully.");
    } else {
      await popup(context, "Ok",
          title: "Notification",
          description: "Connection error, please try again later.");
    }

    Navigator.pop(context);
  }
}

Future<void> validatorPhone(
    BuildContext context, String oldPhoneNumber, String phone) async {
  if (phone.isEmpty) {
    await popup(context, "Ok",
        title: "Notification", description: "Phone number empty!");
    return;
  }
  if (phone.length != 8) {
    await popup(context, "Ok",
        title: "Notification", description: "Phone number invalid!");
    return;
  }
  if (phone ==
      context.read<UserProvider>().currentUser?.phoneNumber.toString()) {
    await popup(context, "Ok",
        title: "Notification",
        description: "You can't update the same phone number!");
    return;
  }
  if (await UserService.checkExistingPhone(phone)) {
    await popup(context, "Ok",
        title: "Notification", description: "Phone number already existe!");
    return;
  }
  bool result =
      await context.read<UserProvider>().changePhoneNumber(context, phone);

  if (result) {
    await popup(context, "Ok",
        title: "Notification",
        description: "Phone number changed seccesfully.");
  } else {
    await popup(context, "Ok",
        title: "Notification",
        description: "Connection error, please try again later.");
  }

  Navigator.pop(context);
}

Future<void> changeFullName(BuildContext context, String name) async {
  if (name.isEmpty) {
    await popup(context, "Ok",
        title: "Notification", description: "Name empty!");
    return;
  }
  if (nameValidator(name) != null) {
    await popup(context, "Ok",
        title: "Notification", description: nameValidator.toString());
    return;
  }

  bool result =
      await context.read<UserProvider>().changeFullName(context, name);

  if (result) {
    await popup(context, "Ok",
        confirmFunction: () => Navigator.pop(context),
        title: "Notification",
        description: "Name changed seccesfully.");
  } else {
    await popup(context, "Ok",
        title: "Notification",
        description: "Connection error, please try again later.");
  }
}

Future<void> changeEmail(BuildContext context, String email) async {
  if (email.isEmpty) {
    await popup(context, "Ok",
        title: "Notification", description: "Email empty!");
    return;
  }
  if (emailValidator(email) == '') {
    await popup(context, "Ok",
        title: "Notification", description: "Email invalid!");
    return;
  }

  if (await UserService.checkExistingUser(email)) {
    await popup(context, "Ok",
        title: "Notification", description: "Email already existe!");
    return;
  }
  bool result = await context.read<UserProvider>().changeEmail(context, email);

  if (result) {
    await popup(context, "Ok",
        title: "Notification", description: "Email changed seccesfully.");
  } else {
    await popup(context, "Ok",
        title: "Notification",
        description: "Connection error, please try again later.");
  }

  Navigator.pop(context);
}
