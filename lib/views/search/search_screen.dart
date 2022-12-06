import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/views/search/widgets/profile_card.dart';
import 'package:jobuapp/views/search/widgets/search_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: const [
            SearchWidget(),
            // false
            //     ? SizedBox(
            //         width: size.width * 0.91,
            //         child: Column(
            //           children: context
            //               .watch<DataProvider>()
            //               .searchUsers
            //               .map((user) => UserCard(
            //                     user: user,
            //                   ))
            //               .toList(),
            //         ),
            //       )
            //:
            SizedBox()
          ],
        ),
      ),
    );
  }
}
