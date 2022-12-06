// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobuapp/constants/const.dart';
import 'package:jobuapp/constants/style.dart';
import 'package:jobuapp/services/logic_service.dart';
import 'package:jobuapp/services/shared_data.dart';
import 'package:jobuapp/services/user_service.dart';
import 'package:jobuapp/widgets/popup.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;
  bool isNotificationOn = true;
  bool isLoading = false;
  bool isLoadingSecond = false;
  Set<Marker> markers = {};

  setMarker() async {
    // await updateUser();
    log('${currentUser!.location!.latitude}, ${currentUser!.location!.longitude}');
    markers = {};
    BitmapDescriptor icon = await MarkerIcon.downloadResizePictureCircle(
        currentUser!.image.isNotEmpty ? currentUser!.image : defautImage,
        size: 150,
        addBorder: true,
        borderColor: primaryColor,
        borderSize: 15);
    markers.add(Marker(
      icon: icon,
      markerId: MarkerId(currentUser!.id!),
      position: currentUser!.location!,
      onTap: () => mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: currentUser!.location!, zoom: 15, tilt: 45))),
      infoWindow: InfoWindow(
        title: currentUser!.fullName.toString(),
        snippet: getLastTimeUpdated(currentUser!.lastUpdateLocation),
      ),
    ));
    log(markers.toString());
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentUser!.location!, zoom: 15, tilt: 45)));
    notifyListeners();
  }

  late GoogleMapController mapController;
  setMapController(controller) {
    mapController = controller;
    notifyListeners();
  }

  setUser(UserModel user) async {
    currentUser = user;
    log("user set done! ${user.email}");
    notifyListeners();
    if (user.id != null) DataPrefrences.setId(user.id!);
    DataPrefrences.setLogin(user.email);
    DataPrefrences.setPassword(user.password);
  }

  locateUser(UserModel user) async {
    markers.removeWhere((element) => element.markerId == MarkerId(user.id!));
    BitmapDescriptor icon = await MarkerIcon.downloadResizePictureCircle(
        currentUser!.image.isNotEmpty ? currentUser!.image : defautImage,
        size: 150,
        addBorder: true,
        borderColor: primaryColor,
        borderSize: 15);
    markers.add(Marker(
      icon: icon,
      markerId: MarkerId(user.id!),
      position: user.location!,
      onTap: () => mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: user.location!, zoom: 15, tilt: 45))),
      infoWindow: InfoWindow(
        title: user.fullName.toString(),
        snippet: getLastTimeUpdated(user.lastUpdateLocation),
      ),
    ));

    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: user.location!, zoom: 15, tilt: 45)));
    notifyListeners();
  }

  remodeData() {
    currentUser = null;
    markers = {};
    stopUserListen();
  }

  changeFullName(BuildContext context, String name) async {
    return await UserService.changeFullName(currentUser!.id!, name);
  }
  changeEmail(BuildContext context, String email) async {
    return await UserService.changeEmail(currentUser!.id!, email);
  }

  changePassword(BuildContext context, String pass) async{
    return await UserService.changePassword(currentUser!.id!, pass);
  }

  changePhoneNumber(BuildContext context, String phone) async {
    return await UserService.changePhoneNumber(currentUser!.id!, phone);
  }

  addFollow(BuildContext context, UserModel user) async {
    isLoading = true;
    notifyListeners();
    await UserService.addFollow(currentUser!, user);
    isLoading = false;
    // updateUser();
  }

  removeFollow(BuildContext context, UserModel user) async {
    isLoading = true;
    notifyListeners();
    final result = await UserService.removeFollow(currentUser!, user);
    popup(context, "Ok",
        description: result ? "Frind removed" : "Try again later");
    isLoading = false;
    // updateUser();
  }

  addRequest(BuildContext context, String id) async {
    isLoading = true;
    notifyListeners();
    final result = await UserService.addRequest(currentUser!, id);
    popup(context, "Ok",
        description: result ? "Request sent" : "Try again later");
    isLoading = false;
    // updateUser();
  }

  removeRequest(BuildContext context,
      {required UserModel sender, required String user}) async {
    isLoading = true;
    notifyListeners();
    await UserService.removeRequest(sender, user);
    isLoading = false;
    // updateUser();
  }

  addFavorite(BuildContext context, UserModel user) async {
    isLoading = true;
    notifyListeners();
    currentUser!.sharedLocation.add(user.id!);
    final result = await UserService.updateFavorite(currentUser!);
    popup(context, "Ok",
        description: result
            ? "location shared with ${user.fullName}"
            : "Try again later");
    isLoading = false;
    // updateUser();
  }

  removeFavorite(BuildContext context, UserModel user) async {
    isLoading = true;
    notifyListeners();
    currentUser!.sharedLocation.remove(user.id!);
    final result = await UserService.updateFavorite(currentUser!);
    popup(context, "Ok",
        description: result
            ? "Location desactivated with ${user.fullName}"
            : "Try again later");
    isLoading = false;
    // updateUser();
  }

  addBlock(BuildContext context, String id) async {
    isLoadingSecond = true;
    notifyListeners();
    currentUser!.baned.add(id);
    final result = await UserService.updateBlock(currentUser!);
    popup(context, "Ok",
        description: result ? "User Blocked" : "Try again later");
    isLoadingSecond = false;
    // updateUser();
  }

  removeBlock(BuildContext context, String id) async {
    isLoadingSecond = true;
    notifyListeners();
    currentUser!.baned.remove(id);
    final result = await UserService.updateBlock(currentUser!);
    popup(context, "Ok",
        description: result ? "User Unblocked" : "Try again later");
    isLoadingSecond = false;
    // updateUser();
  }

  // Future<void> updateUser() async {
  //   final location = await UserService.getUserCurrentLocation();
  //   if (location != null) {
  //     await UserService.updateLocation(currentUser!, location);
  //     currentUser =
  //         await UserService.getUser(currentUser!.email, currentUser!.password);
  //     notifyListeners();
  //   } else {
  //     ///******************************************you can add a popup or return false ************************/
  //     // popup(context, confirmText)
  //   }
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>>? userStream;

  startUserListen(String userId) {
    if (userStream != null) return;
    userStream =
        UserService.collection.where("id", isEqualTo: userId).snapshots();
    userStream?.listen((event) {}).onData((data) {
      for (var d in data.docChanges) {
        log(d.doc.data().toString());
      }
      currentUser = UserModel.fromMap(data.docChanges.first.doc.data()!);
      log("user updated");
      notifyListeners();
    });
  }

  stopUserListen() {
    if (userStream == null) return;
    userStream?.listen((event) {}).cancel();
    userStream = null;
  }
}
