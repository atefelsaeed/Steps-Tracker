import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String profileImage;
  final int totalSteps;
  final double weight;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.name,
    this.totalSteps = 0,
    this.weight = 0.0,
    this.createdAt,
    this.profileImage = "",
  });

  factory UserModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    // Corrected createdAt field handling
    final createdAt = map['createdAt'];
    DateTime? parsedCreatedAt;

    if (createdAt is Timestamp) {
      parsedCreatedAt = createdAt.toDate();
    } else if (createdAt is String) {
      parsedCreatedAt = DateTime.tryParse(createdAt);
    }

    return UserModel(
      uid: documentId,
      name: map['userName'] as String,
      profileImage: map['profileImage'] ?? "",
      totalSteps: map['totalSteps'] as int,
      weight: map['weight'] as double,
      createdAt: parsedCreatedAt,
    );
  }

  Map<String, dynamic> toMap({
    bool forFirestore = false,
    bool forLocalStorage = false,
  }) {
    return {
      'uid': uid,
      'userName': name,
      'profileImage': profileImage,
      'totalSteps': totalSteps,
      'weight': weight,
      'createdAt': createdAt!.toIso8601String(),
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? profileImage,
    int? totalSteps,
    double? weight,
    DateTime? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      profileImage: profileImage ?? this.profileImage,
      totalSteps: totalSteps ?? this.totalSteps,
      weight: weight ?? this.weight,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
