import 'package:flutter/material.dart';
import 'package:jobuapp/services/data_service.dart';
import 'package:jobuapp/views/home/widgets/service_widget.dart';
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
              FutureBuilder(
                  future: DataService.getUserServices(user.id!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                      
                      return Column(
                        children: snapshot.data!.map((e) => ServiceWidget(service: e)).toList(),
                      );
                    } else {
                      return SizedBox(
                        child: Center(
                          child: Text(
                            "This user doesn't have services",
                            style: style.text18,
                          ),
                        ),
                      );
                    }
                  })
            ],
          )),
    );
  }
}
