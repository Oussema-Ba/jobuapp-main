import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jobuapp/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/providers/app_provider.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50))
        .then((value) => context.read<DataProvider>().clearSearch(context));
  }

  @override
  void dispose() {
    super.dispose();
    log("dispose");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return Container(
      margin: EdgeInsets.only(top: size.width * 0.09),
      width: size.width * 0.9,
      height: 70,
      child: Center(
        child: TextFormField(
          onFieldSubmitted: (val) {},
          controller: context.watch<DataProvider>().searchController,
          onChanged: (String value) =>
              context.read<DataProvider>().updateSearch(value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: style.text18,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            hintText: "Search...",
            hintStyle: style.text18,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: style.invertedColor.withOpacity(0.2), width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: style.invertedColor,
            ),
            suffixIcon: context.watch<DataProvider>().search.isNotEmpty
                ? InkWell(
                    onTap: () =>
                        context.read<DataProvider>().clearSearch(context),
                    child: Icon(
                      Icons.close,
                      color: style.invertedColor,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: style.invertedColor, width: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
