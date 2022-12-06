import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/widgets/text_widget.dart';

import '../providers/app_provider.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final String? label;
  final FocusNode focus;
  final String? Function(String?) validator;
  final bool isPassword;
  final TextInputType? keybordType;
  final List<TextInputFormatter>? inputFormatters;
  const CustomTextField(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.validator,
      this.label,
      this.isPassword = false,
      this.keybordType,
      this.inputFormatters,
      required this.focus})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isCorrect = false;
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.validator(widget.controller.text) == null) {
        if (isCorrect == true) {
          return;
        } else {
          setState(() {
            isCorrect = true;
          });
        }
      } else {
        if (isCorrect == false) {
          return;
        } else {
          setState(() {
            isCorrect = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var style = context.watch<ThemeNotifier>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Txt(
                text: widget.label!,
                style: style.text18.copyWith(
                  fontWeight: FontWeight.w600,
                )),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            focusNode: widget.focus,
            onFieldSubmitted: (val) {
              if (widget.isPassword) {
                FocusScope.of(context).unfocus();
              } else {
                FocusScope.of(context).nextFocus();
              }
            },
            controller: widget.controller,
            onEditingComplete: () {},
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: widget.keybordType,
            inputFormatters: widget.inputFormatters,
            style: style.text18,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.1),
              hintText: widget.hint,
              hintStyle: style.text18
                  .copyWith(color: style.invertedColor.withOpacity(0.4)),
              contentPadding:
                  const EdgeInsets.only(left: 20, bottom: 16, top: 16),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: lightBlueColor, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: isCorrect
                  ? Icon(
                      Icons.check,
                      color: style.invertedColor,
                    )
                  : const SizedBox(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isCorrect
                        ? lightBlueColor
                        : style.invertedColor.withOpacity(0.3),
                    width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: lightBlueColor, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.redAccent, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              errorStyle: text18white.copyWith(fontSize: 14, color: Colors.redAccent),
            ),
            validator: (val) {
              var result = widget.validator(val);
              if (result == null) {
                isCorrect = true;
              } else {
                isCorrect = false;
              }
              return result;
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
