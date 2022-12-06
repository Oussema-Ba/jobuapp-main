import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/models/user.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/widgets/primary_btn.dart';
import 'package:jobuapp/widgets/text_widget.dart';

import '../../providers/app_provider.dart';

class PublicProfileScreen extends StatelessWidget {
  final UserModel user;
  const PublicProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return Scaffold(
      backgroundColor: style.bgColor,
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.3,
                width: size.width,
                // color: Colors.amber,
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.2,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/pattern.png"),
                            fit: BoxFit.cover,
                            opacity: 0.1),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 3),
                              blurRadius: 10,
                              color: Colors.black38)
                        ],
                        color: primaryColor,
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: size.height * 0.2 - 30,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(right: 5),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: style.bgColor,
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 10,
                                  color: Colors.black38)
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: style.invertedColor,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: size.width / 2 - 100,
                      child: Hero(
                        tag: user.id!,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(0, 3),
                                  blurRadius: 10,
                                  color: Colors.black38)
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor: primaryColor,
                            radius: 95,
                            child: user.image.toString().isEmpty
                                ? CircleAvatar(
                                    backgroundColor: style.bgColor,
                                    backgroundImage:
                                        const AssetImage("assets/profile.jpg"),
                                    radius: 90,
                                  )
                                : CircleAvatar(
                                    backgroundColor: style.bgColor,
                                    backgroundImage: NetworkImage(user.image),
                                    radius: 90,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Txt(text: user.fullName, style: style.title),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  context
                          .watch<UserProvider>()
                          .currentUser!
                          .baned
                          .contains(user.id!)
                      ? primaryButton(
                          context: context,
                          height: 50,
                          width: 150,
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                          widget: context.watch<UserProvider>().isLoading
                              ? const Center(
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                )
                              : Txt(
                                  text: !context
                                          .watch<UserProvider>()
                                          .currentUser!
                                          .followed
                                          .contains(user.id!)
                                      ? "Follow"
                                      : "Unfollow",
                                  style: text18white),
                        )
                      : !context
                              .watch<UserProvider>()
                              .currentUser!
                              .sentRequest
                              .contains(user.id!)
                          ? primaryButton(
                              context: context,
                              height: 50,
                              width: 150,
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              widget: context.watch<UserProvider>().isLoading
                                  ? const Center(
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    )
                                  : Txt(text: "Follow", style: text18white),
                              function: () => context
                                  .read<UserProvider>()
                                  .addRequest(context, user.id!))
                          : primaryButton(
                              context: context,
                              height: 50,
                              width: 150,
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(12),
                              widget: context.watch<UserProvider>().isLoading
                                  ? const Center(
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    )
                                  : Txt(text: "Requested", style: text18white),
                              function: () => context
                                  .read<UserProvider>()
                                  .removeRequest(context,
                                      sender: context
                                          .read<UserProvider>()
                                          .currentUser!,
                                      user: user.id!)),
                  !context
                          .watch<UserProvider>()
                          .currentUser!
                          .baned
                          .contains(user.id!)
                      ? primaryButton(
                          context: context,
                          height: 50,
                          width: 150,
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                          widget: context.watch<UserProvider>().isLoadingSecond
                              ? const Center(
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                )
                              : Txt(text: "Block", style: text18white),
                          function: () => context
                              .read<UserProvider>()
                              .addBlock(context, user.id!))
                      : primaryButton(
                          context: context,
                          height: 50,
                          width: 150,
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                          widget: context.watch<UserProvider>().isLoadingSecond
                              ? const Center(
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                )
                              : Txt(text: "Unblock", style: text18white),
                          function: () => context
                              .read<UserProvider>()
                              .removeBlock(context, user.id!)),
                ],
              )
            ],
          )),
    );
  }
}
