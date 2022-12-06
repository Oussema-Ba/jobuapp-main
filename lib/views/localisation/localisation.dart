// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:jobuapp/models/user.dart';
import 'package:jobuapp/widgets/circle_profile_image_widget.dart';
import '../../providers/app_provider.dart';
import '../../providers/user_provider.dart';
import 'dart:ui' as ui;

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({Key? key}) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  void _onMapCreated(GoogleMapController controller) async {
    await context.read<UserProvider>().setMapController(controller);
    if (context.read<UserProvider>().currentUser == null) return;
    if (context.read<UserProvider>().currentUser?.location == null) return;
    context.read<UserProvider>().setMarker();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = context.watch<ThemeNotifier>();

    return Stack(
      children: [
        SizedBox(
          child: SizedBox(
            height: size.height,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              markers: context.watch<UserProvider>().markers,
              zoomControlsEnabled: false,
              compassEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: context.watch<UserProvider>().currentUser!.location!,
                zoom: 6,
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 100,
            right: 20,
            child: InkWell(
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: style.btnColor,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white, width: 1),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(3, 3),
                            color: Colors.black54,
                            blurRadius: 12)
                      ]),
                  child: const Center(
                    child: Icon(
                      Icons.location_searching,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                onTap: () => context
                    .read<UserProvider>()
                    .locateUser(context.read<UserProvider>().currentUser!)))
      ],
    );
  }

  Widget mapUserIcon({required UserModel user, required BuildContext context}) {
    return InkWell(
      onTap: () => context.read<UserProvider>().locateUser(user),
      child: CircleProfileImage(
        size: 70,
        isAsset: false,
        img: user.image.isNotEmpty ? user.image : "",
      ),
    );
  }
}

Widget bluryContainer({required double width, required color, required child}) {
  return SizedBox(
    height: 90,
    child: Container(
        width: width,
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: color),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          child: child,
        )),
  );
}
