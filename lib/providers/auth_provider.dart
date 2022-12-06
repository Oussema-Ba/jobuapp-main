// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jobuapp/models/user.dart';
import 'package:jobuapp/providers/user_provider.dart';
import 'package:jobuapp/services/shared_data.dart';
import 'package:jobuapp/services/user_service.dart';
import 'package:jobuapp/views/login/getstarted.dart';
import 'package:jobuapp/views/login/signup.dart';
import 'package:jobuapp/views/page_structure.dart';
import 'package:jobuapp/widgets/popup.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleUser;
  GoogleSignInAccount get user => googleUser!;
  bool isLoading = false;
  UserModel? currentUser;

  Future<bool> checkLogin(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 50));
    log("Shared prefrences : ${DataPrefrences.getLogin()}, ${DataPrefrences.getPassword()}");
    if (DataPrefrences.getLogin().isNotEmpty &&
        DataPrefrences.getPassword().isNotEmpty) {
      login(context, DataPrefrences.getLogin(), DataPrefrences.getPassword());
      return true;
    }
    return false;
  }

  Future<void> removeData(BuildContext context) async {
    await UserService.removeFcm(currentUser!);
    context.read<UserProvider>().remodeData();
    currentUser = null;
    DataPrefrences.setLogin("");
    DataPrefrences.setPassword("");
  }

  Future<void> logOut(BuildContext context) async {
    await removeData(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const IndexScreen()));
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    isLoading = true;
    notifyListeners();
    // final result = await FirebaseAuth.instance
    //     .signInWithEmailAndPassword(email: email, password: password);
    // log(result.toString());
    var user = await UserService.getUser(email, password);

    if (user != null) {
      user.location = await UserService.getUserCurrentLocation();
      await UserService.updateLocation(user, user.location!);
      currentUser = user;
      DataPrefrences.setLogin(email);
      DataPrefrences.setPassword(password);
      await UserService.saveFcm(user);
      log("connected");
      context.read<UserProvider>().setUser(user);
      context.read<UserProvider>().startUserListen(user.id!);
      isLoading = false;
      notifyListeners();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const PageStructure()));
    } else {
      isLoading = false;
      notifyListeners();
      await popup(context, "Ok",
          title: "Notification",
          description: "Email ou mot de passe incorrect");
    }
  }

  Future<void> signup(BuildContext context, String name, String email,
      String phoneNumber, String password,
      {String photo = ""}) async {
    isLoading = true;
    notifyListeners();

    isLoading = false;
    UserModel tempUser = UserModel(
        fullName: name.trim(),
        email: email.toString().trim(),
        phoneNumber: phoneNumber,
        image: photo,
        password: password,
        baned: [],
        followed: [],
        requested: [],
        sentRequest: [],
        sharedLocation: []);

    var result = await UserService.addUser(tempUser);

    if (result == "true") {
      var user = await UserService.getUser(tempUser.email, tempUser.password);
      if (user != null) {
        user.location = await UserService.getUserCurrentLocation();
        await UserService.updateLocation(user, user.location!);
        currentUser = user;
        UserService.saveFcm(user);
        DataPrefrences.setLogin(email);
        DataPrefrences.setPassword(password);
        context.read<UserProvider>().setUser(user);
        context.read<UserProvider>().startUserListen(user.id!);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const PageStructure()));
      }
    }
  }

  Future<GoogleSignInAccount?> googleLogIn(
      BuildContext context, bool isSignUp) async {
    isLoading = true;
    notifyListeners();
    var googleUser = await UserService.getGoogleUserInfo(context);
    if (googleUser != null) {
      log(googleUser.photoUrl.toString());
      if (await UserService.checkExistingUser(googleUser.email)) {
        currentUser = await UserService.getUserByEmail(googleUser.email);
        log(currentUser.toString());
        currentUser!.location = await UserService.getUserCurrentLocation();
        await UserService.updateLocation(currentUser!, currentUser!.location!);
        context.read<UserProvider>().setUser(currentUser!);
        context.read<UserProvider>().startUserListen(currentUser!.id!);
        DataPrefrences.setLogin(currentUser!.email);
        DataPrefrences.setPassword(currentUser!.password);
        await UserService.saveFcm(currentUser!);
        isLoading = false;
        notifyListeners();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const PageStructure()));
      } else {
        isLoading = false;
        notifyListeners();
        if (isSignUp) return googleUser;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => SignUpScreen(
                      name: googleUser.displayName ?? "",
                      email: googleUser.email,
                      photo: googleUser.photoUrl ?? "",
                    )));
      }
    }
    isLoading = false;
    notifyListeners();
    return null;
  }
}
