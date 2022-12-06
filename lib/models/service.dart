import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ServiceModel {
  String id;

  String ownerId;

  String ownerName;

  String ownerImage;

  String metier;

  String description;

  String location;

  String phoneNumber;

  bool deplacement;

  int cost;

  ServiceModel({
    required this.id,
    required this.ownerId,
    required this.ownerName,
    required this.ownerImage,
    required this.metier,
    required this.description,
    required this.location,
    required this.phoneNumber,
    required this.deplacement,
    required this.cost,
  });

  @override
  String toString() {
    return 'ServiceModel(id: $id, ownerId: $ownerId, ownerName: $ownerName, ownerImage: $ownerImage, metier: $metier, description: $description, location: $location, phoneNumber: $phoneNumber, deplacement: $deplacement, cost: $cost)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'ownerImage': ownerImage,
      'metier': metier,
      'description': description,
      'location': location,
      'phoneNumber': phoneNumber,
      'deplacement': deplacement,
      'cost': cost,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      ownerName: map['ownerName'] as String,
      ownerImage: map['ownerImage'] as String,
      metier: map['metier'] as String,
      description: map['description'] as String,
      location: map['location'] as String,
      phoneNumber: map['phoneNumber'] as String,
      deplacement: map['deplacement'] as bool,
      cost: map['cost'] as int,
    );
  }
  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
