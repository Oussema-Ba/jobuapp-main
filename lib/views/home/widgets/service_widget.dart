import 'package:flutter/material.dart';
import 'package:jobuapp/models/service.dart';
import 'package:jobuapp/providers/app_provider.dart';
import 'package:jobuapp/providers/data_provider.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/services/user_service.dart';
import 'package:jobuapp/views/profile/public_profile.dart';
import 'package:provider/provider.dart';

class ServiceWidget extends StatelessWidget {
  final ServiceModel service;

  const ServiceWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();
    bool isOwner =
        context.read<UserProvider>().currentUser!.id == service.ownerId;
    Widget title(IconData icon, String text) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        width: size.width,
        child: Row(
          children: [
            Icon(
              icon,
              color: style.invertedColor,
              size: 25,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: style.text18.copyWith(),
            )
          ],
        ),
      );
    }

    return SizedBox(
        // padding: const EdgeInsets.only(top: 50),
        width: size.width,
        child: Stack(
          children: [
            Container(
                width: size.width,
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10)
                    .copyWith(top: 60),
                decoration: BoxDecoration(
                  color: style.darkMode
                      ? const Color.fromARGB(255, 36, 36, 36)
                      : Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 5,
                      color: const Color.fromARGB(255, 161, 159, 159)
                          .withOpacity(0.3),
                    ),
                  ],
                  border: Border.all(
                    color: isOwner
                        ? style.invertedColor.withOpacity(.7)
                        : Colors.white,
                    width: 1.5,
                  ),
                ),
                // height: 700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: isOwner
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () => context
                                              .read<DataProvider>()
                                              .deleteService(
                                                  service.id,
                                                  context
                                                      .read<UserProvider>()
                                                      .currentUser!
                                                      .id!),
                                          child: const SizedBox(
                                              child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        const InkWell(
                                          child: SizedBox(
                                              child: Icon(
                                            Icons.star_border,
                                            color: Colors.orange,
                                          )),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                            ),
                            SizedBox(
                              width: size.width * .7,
                              child: Text(
                                service.metier,
                                style: style.text18
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              width: size.width * .7,
                              child: Text(
                                service.description,
                                style: style.text18.copyWith(
                                    color: style.invertedColor.withOpacity(.8)),
                              ),
                            ),
                            title(Icons.location_on_outlined, service.location),
                            title(Icons.phone, service.phoneNumber),
                            title(Icons.local_taxi_outlined,
                                service.deplacement ? 'Oui' : 'Non'),
                            title(Icons.attach_money_rounded,
                                "${service.cost} Dt"),
                          ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                      color: style.bgColor, shape: BoxShape.circle),
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        UserService.getUserById(service.ownerId).then((value) {
                          if (value != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (constex) => PublicProfileScreen(
                                          user: value,
                                        )));
                          }
                        });
                      },
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 94, 83, 83),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(service.ownerImage),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
