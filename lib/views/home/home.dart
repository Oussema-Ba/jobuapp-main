import 'package:flutter/material.dart';
import 'package:jobuapp/providers/data_provider.dart';
import 'package:jobuapp/views/home/widgets/service_widget.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:jobuapp/views/home/widgets/title_widget.dart';

import '../addservice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 50))
        .then((value) => context.read<DataProvider>().getAllServices());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: style.bgColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SearchWidget(),
                  const TitleWidget(),
                  // EmergencyWidget(),
                  // SendAlertWidget(),
                  // GetHomeWidget(),

                  ...context
                      .watch<DataProvider>()
                      .allServices
                      .map((service) => ServiceWidget(service: service))
                      .toList(),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              right: 20,
              bottom: 100,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Addservice()));
                },
                child: Hero(
                  tag: "add",
                  child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: style.btnColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(4, 4),
                            blurRadius: 8,
                            color: const Color.fromARGB(255, 45, 45, 45)
                                .withOpacity(0.5),
                          ),
                        ],
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.add,
                        size: 25,
                        color: Colors.white,
                      ))),
                ),
              ))
        ],
      ),
    );
  }
}
