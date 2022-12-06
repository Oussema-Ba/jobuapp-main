import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jobuapp/models/service.dart';
import 'package:jobuapp/services/logic_service.dart';

class DataService {
  static CollectionReference<Map<String, dynamic>> collection =
      FirebaseFirestore.instance.collection('services');


  static Future<List<ServiceModel>> getAllServices() async {
    List<ServiceModel> allServices = [];
    try {
      final data = await collection.get();
      for (var d in data.docs) {
        allServices.add(ServiceModel.fromMap(d.data()));
      }
    } catch (e) {
      log(e.toString());
      return allServices;
    }
    return allServices.reversed.toList();
  }

  static Future<bool> deleteService(String serviceId) async {
    try {
      await collection
          .doc(serviceId)
          .delete()
          .whenComplete(() => log("service deleted"));
    } on Exception {
      return false;
    }
    return true;
  }

  static Future<List<ServiceModel>> getUserServices(String userId) async {
    List<ServiceModel> allServices = [];
    try {
      final data = await collection.where('ownerId', isEqualTo: userId).get();
      for (var d in data.docs) {
        allServices.add(ServiceModel.fromMap(d.data()));
      }
    } catch (e) {
      log(e.toString());
      return allServices;
    }
    return allServices.reversed.toList();
  }

  static Future<bool> addService(ServiceModel service) async {
    service.id = generateId();
    try {
      await collection
          .doc(service.id)
          .set(service.toMap())
          .whenComplete(() => log("service added"));
    } on Exception {
      return false;
    }
    return true;
  }
}
