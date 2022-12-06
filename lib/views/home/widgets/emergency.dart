import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EmergencyWidget extends StatefulWidget {
  const EmergencyWidget({Key? key}) : super(key: key);

  @override
  State<EmergencyWidget> createState() => _EmergencyWidgetState();
}

class _EmergencyWidgetState extends State<EmergencyWidget> {
  CarouselController controller = CarouselController();

  List<Pub> pubs = [
    Pub(
        color: const Color.fromARGB(255, 8, 80, 214),
        title: "Active Emergency",
        call: "197",
        text: "Call 197 for emergency"),
    Pub(
        color: const Color.fromARGB(255, 233, 141, 3),
        title: "Ambulance",
        call: "190",
        text: "Call 190 in case of any medical emergencies"),
    Pub(
        color: const Color.fromARGB(255, 255, 0, 0),
        title: "Fire Brigate",
        call: "198",
        text: "Call 198 in case of any fire emergencies")
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, bottom: 10),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       "Emergency",
          //       style: style.title.copyWith(fontSize: 27),
          //     ),
          //   ),
          // ),
          CarouselSlider(
            items: pubs
                .map((pub) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(3, 3),
                                blurRadius: 10,
                                color: Colors.black38)
                          ],
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        // width: size.width * 0.7,
                        height: 200,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  pub.color,
                                  pub.color.withOpacity(0.5),
                                  // Colors.white24,
                                ]),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    pub.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            fontSize: 30, color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                SizedBox(
                                  width: size.width * 0.6,
                                  child: Text(
                                    pub.text,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            fontSize:
                                                size.width < 350 ? 12 : 15,
                                            color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 40,
                                  // width: 100,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blueGrey),
                                        shape:
                                            MaterialStateProperty.resolveWith(
                                                (states) =>
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ))),
                                    child: Text("Call now".toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800)),
                                    onPressed: () {
                                      log("calling ${pub.call}");
                                    },
                                    // onPressed: () => Navigator.push(context,
                                    //     MaterialPageRoute(builder: (_) => const LoginEmail())),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList(),
            carouselController: controller,
            options: CarouselOptions(
                enlargeCenterPage: true,
                aspectRatio: 18 / 9.5,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                }),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class Pub {
  final Color color;
  final String title;
  final String text;
  final String call;
  Pub(
      {required this.color,
      required this.title,
      required this.text,
      required this.call});
}
