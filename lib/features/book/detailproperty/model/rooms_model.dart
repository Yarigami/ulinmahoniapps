import 'dart:convert';

class RoomModel {
  final int id;
  final int propertyId;
  final String propertyName;
  final String slug;
  final String name;
  final String descriptions;
  final Map<String, bool> periode;
  final String type;
  final int level;
  final Map<String, bool> facility;
  final Map<String, dynamic> price;
  final Map<String, dynamic>? attachment; // ubah jadi Map
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final String? updatedBy;
  final int status;

  RoomModel({
    required this.id,
    required this.propertyId,
    required this.propertyName,
    required this.slug,
    required this.name,
    required this.descriptions,
    required this.periode,
    required this.type,
    required this.level,
    required this.facility,
    required this.price,
    this.attachment,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    this.updatedBy,
    required this.status,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['idrec'],
      propertyId: json['property_id'],
      propertyName: json['property_name'],
      slug: json['slug'],
      name: json['name'],
      descriptions: json['descriptions'],
      periode: Map<String, bool>.from(jsonDecode(json['periode'])),
      type: json['type'],
      level: json['level'],
      facility: Map<String, bool>.from(jsonDecode(json['facility'])),
      price: Map<String, dynamic>.from(jsonDecode(json['price'])),
      attachment: json['attachment'] == null
          ? null
          : Map<String, dynamic>.from(jsonDecode(json['attachment'])),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      status: json['status'],
    );
  }
}
