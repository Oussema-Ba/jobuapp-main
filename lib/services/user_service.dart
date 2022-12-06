import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobuapp/models/user.dart';
import 'package:jobuapp/services/logic_service.dart';
import 'package:jobuapp/services/shared_data.dart';
import 'package:jobuapp/widgets/popup.dart';

class UserService {
  static CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('users');

  static Future<String> addUser(UserModel user) async {
    if (await checkExistingUser(user.email)) {
      return "Email already exists";
    }
    user.id = generateId();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      await collection
          .doc(user.id)
          .set(user.toMap())
          .whenComplete(() => log("user added"));
    } on Exception {
      return "An error has occurred, please try again later";
    }
    return "true";
  }

  static Future<bool> checkExistingUser(String email) async {
    final snapshot =
        await collection.where('email', isEqualTo: email).limit(1).get();
    if (snapshot.docs.isNotEmpty) return true;
    return false;
  }

  static Future<bool> changeFullName(String id, String name) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .update({"fullName": name});
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<bool> changeEmail(String id, String email) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .update({"email": email});
      DataPrefrences.setLogin(email);
      return true;
    } on Exception {
      return false;
    }
  }
    static Future<bool> changePassword(String id, String password) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .update({"password": password});
      DataPrefrences.setPassword(password);
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<bool> checkExistingPhone(String phone) async {
    final snapshot =
        await collection.where('phoneNumber', isEqualTo: phone).limit(1).get();
    if (snapshot.docs.isNotEmpty) return true;
    return false;
  }

  static Future<UserModel?> getUser(String email, String password) async {
    final snapshot = await collection
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();
    if (snapshot.docs.isNotEmpty) {
      log(snapshot.docs.first.data().toString());
      UserModel user = UserModel.fromMap(snapshot.docs.first.data());

      return user;
    } else {
      return null;
    }
  }

  static Future<UserModel?> getUserByEmail(String email) async {
    final snapshot = await collection.where('email', isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      log("by email${snapshot.docs.first.data()}");
      UserModel user = UserModel.fromMap(snapshot.docs.first.data());

      return user;
    } else {
      return null;
    }
  }

  static Future<GoogleSignInAccount?> getGoogleUserInfo(
      BuildContext context) async {
    try {
      final googleSignIn = GoogleSignIn();

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return null;
      googleSignIn.signOut();

      return googleUser;
    } on PlatformException catch (e) {
      popup(context, "Ok", title: "Erreur", description: e.toString());
      return null;
    } catch (e) {
      popup(context, "Ok", title: "Erreur", description: e.toString());
      return null;
    }
  }

  // static Future<bool> changePassword(UserModel user) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(user.id)
  //         .update({"password": user.password});
  //     return true;
  //   } on Exception {
  //     return false;
  //   }
  // }

  static Future<bool> updateLocation(UserModel user, LatLng location) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(user.id).update({
        "location": GeoPoint(location.latitude, location.longitude),
        "lastUpdateLocation": DateTime.now().millisecondsSinceEpoch
      });
      return true;
    } on Exception {
      return false;
    }
  }

  /////////////////////////////////////////////
  static Future<bool> removeFollow(UserModel sender, UserModel user) async {
    sender.followed.remove(user.id!);
    user.followed.remove(sender.id!);
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update({"followed": user.followed});
      await FirebaseFirestore.instance
          .collection("users")
          .doc(sender.id)
          .update({"followed": sender.followed});
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<bool> addFollow(UserModel sender, UserModel user) async {
    sender.followed.add(user.id!);
    user.followed.add(sender.id!);
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update({"followed": user.followed});
      await FirebaseFirestore.instance
          .collection("users")
          .doc(sender.id)
          .update({"followed": sender.followed});
      await removeRequest(sender, user.id!);
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<bool> addRequest(UserModel sender, String userId) async {
    final secondUser = await getUserById(userId);
    try {
      if (secondUser != null) {
        if (!secondUser.requested.contains(sender.id!)) {
          secondUser.requested.add(sender.id!);
          await FirebaseFirestore.instance
              .collection("users")
              .doc(userId)
              .update({"requested": secondUser.requested});
        }

        if (!sender.sentRequest.contains(userId)) {
          sender.sentRequest.add(userId);
          await FirebaseFirestore.instance
              .collection("users")
              .doc(sender.id!)
              .update({"sentRequest": sender.sentRequest});
          return true;
        }
      }
      return false;
    } on Exception {
      return false;
    }
  }

  static Future<bool> removeRequest(UserModel user, String userId) async {
    final secondUser = await getUserById(userId);
    try {
      if (secondUser != null) {
        secondUser.requested.remove(user.id!);
        secondUser.sentRequest.remove(user.id!);

        await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .update({
          "requested": secondUser.requested,
          "sentRequest": secondUser.sentRequest
        });
      }

      if (user.sentRequest.contains(userId) ||
          user.requested.contains(userId)) {
        user.sentRequest.remove(userId);
        user.requested.remove(userId);

        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.id)
            .update(
                {"sentRequest": user.sentRequest, "requested": user.requested});
        return true;
      }

      return false;
    } on Exception {
      return false;
    }
  }

  static Future<bool> updateFavorite(
    UserModel user,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update({"sharedLocation": user.sharedLocation});
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<bool> updateBlock(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update({"baned": user.baned});
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<bool> changePhoneNumber(String id, String phoneNumber) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .update({"phoneNumber": phoneNumber});
      return true;
    } on Exception {
      return false;
    }
  }

  static Future<bool> saveFcm(UserModel user) async {
    return false;
  }

  static Future<bool> removeFcm(UserModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update({'fcm': null}).whenComplete(() => log("token removed"));
      return true;
    } on Exception catch (e) {
      log("token error : $e");
      return false;
    }
  }

  static Future<String?> getUserFcm(String email) async {
    final snapshot = await collection.where('email', isEqualTo: email).get();
    if (snapshot.docs.isNotEmpty) {
      log(snapshot.docs.first.data().toString());

      return snapshot.docs.first.data()['fcm'];
    } else {
      return null;
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllTrackedUser(
      List<String> listId) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("id", whereIn: listId)
        .snapshots();
  }

  static Future<bool> checkLocationPermission() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        //return Future.error("service desactivé");
        return false;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.always) {
          return true;
        } else if (permission == LocationPermission.whileInUse) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<LatLng?> getUserCurrentLocation() async {
    try {
      if (!await checkLocationPermission()) {
        return null;
      }
      Position pos = await Geolocator.getCurrentPosition();
      LatLng l = LatLng(pos.latitude, pos.longitude);
      log(pos.toString());
      return l;
    } catch (e) {
      return null;
    }
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getUsersByName(String name) async {
    final snapshot = await collection.get();
    if (snapshot.docs.isNotEmpty) {
      log("search by name${snapshot.docs.length}");
      return snapshot.docs;
    } else {
      return [];
    }
  }

  static Future<UserModel?> getUserById(String id) async {
    final data = await collection.doc(id).get();
    return UserModel.fromMap(data.data()!);
  }

  static Future<List<UserModel>> getUsersByIds(List<String> ids) async {
    List<UserModel> users = [];
    final data = await collection.where("id", whereIn: ids).get();

    users = data.docs.map((user) => UserModel.fromMap(user.data())).toList();

    return users;
  }
}
