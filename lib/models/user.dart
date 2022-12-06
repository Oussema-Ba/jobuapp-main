// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobuapp/services/logic_service.dart';

class UserModel {
  String? id;
  String fullName;
  String email;
  String phoneNumber;
  String password;
  String image;
  LatLng? location;
  DateTime? lastLoggedIn;
  DateTime? lastUpdateLocation;
  bool isLoggedIn;
  bool locationActivated;
  List<String> requested;
  List<String> sentRequest;
  List<String> followed;
  List<String> baned;
  List<String> sharedLocation;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.location,
    this.lastLoggedIn,
    this.image = "",
    this.lastUpdateLocation,
    this.isLoggedIn = false,
    this.locationActivated = false,
    required this.baned,
    required this.followed,
    required this.requested,
    required this.sharedLocation,
    required this.sentRequest
  });

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, image: $image, password: $password, location: $location, lastLoggedIn: $lastLoggedIn, lastUpdateLocation: $lastUpdateLocation, isLoggedIn: $isLoggedIn, locationActivated: $locationActivated, sharedLocation:$sharedLocation, followed:$followed, requested:$requested, baned:$baned, sentRequest:$sentRequest)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'location': location == null
          ? null
          : GeoPoint(location!.latitude, location!.longitude),
      'image': image,
      'lastLoggedIn': lastLoggedIn?.millisecondsSinceEpoch,
      'lastUpdateLocation': lastUpdateLocation?.millisecondsSinceEpoch,
      'isLoggedIn': isLoggedIn,
      'locationActivated': locationActivated,
      'followed': followed,
      'baned': baned,
      'requested': requested,
      'sentRequest':sentRequest,
      'sharedLocation': sharedLocation
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    GeoPoint? gPoint = map['location'];
    
    return UserModel(
      id: map['id'] != null ? map['id'] as String : null,
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      password: map['password'] as String,
      location:
          gPoint != null ? LatLng(gPoint.latitude, gPoint.longitude) : null,
      image: map['image'],
      lastLoggedIn: map['lastLoggedIn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastLoggedIn'] as int)
          : null,
      lastUpdateLocation: map['lastUpdateLocation'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              map['lastUpdateLocation'] as int)
          : null,
      isLoggedIn: map['isLoggedIn'] as bool,
      locationActivated: map['locationActivated'] as bool,
      followed: getListString(map['followed']),
      requested: getListString(map['requested']),
      sentRequest:getListString(map['sentRequest']??[]),
      baned: getListString(map['baned']),
      sharedLocation: getListString(map['sharedLocation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
