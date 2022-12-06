import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jobuapp/models/service.dart';
import 'package:jobuapp/services/data_service.dart';

class DataProvider with ChangeNotifier {
  List<ServiceModel> allServices = [];
  List<ServiceModel> myServices = [];
  TextEditingController searchController = TextEditingController(text: '');
  List<ServiceModel> searchUsers = [];
  String search = "";

  updateSearch(String value) async {
    log("update search :$value");
    search = value;
    if (value.isEmpty) searchUsers = [];
    if (value.isNotEmpty) searchUsers = await getServicesByName(value);
    log(searchUsers.length.toString());
    notifyListeners();
  }

  clearSearch(BuildContext context) {
    search = "";
    searchController.clear();
    searchUsers = [];
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  Future<List<ServiceModel>> getServicesByName(String value) async {
    List<ServiceModel> services = [];

    for (var item in allServices) {
      if (item.metier.toString().toLowerCase().contains(value.toLowerCase())) {
        services.add(item);
      }
    }

    return services;
  }

  getAllServices() async {
    allServices = await DataService.getAllServices();
    notifyListeners();
  }

  deleteService(String serviceId, String userId) async {
    await DataService.deleteService(serviceId);

    await getUserServices(userId);
    await getAllServices();
  }

  getUserServices(String userId) async {
    myServices = await DataService.getUserServices(userId);
    notifyListeners();
  }

  Future<bool> addService(ServiceModel service) async {
    final result = await DataService.addService(service);
    if (result) {
      await getAllServices();
      return true;
    }
    return false;
  }
}
