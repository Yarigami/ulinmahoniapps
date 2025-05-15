import 'dart:convert';

class RoomModel {
  final int id;
  final int? propertyId;
  final String? propertyName;
  final String? slug;
  final String? name;
  final String? descriptions;
  final Map<String, bool> periode;
  final String? type;
  final String? level;
  final Map<String, bool> facility;
  final Map<String, dynamic> price;
  final double? priceOriginalDaily;
  final double? priceDiscountedDaily;
  final double? priceOriginalMonthly;
  final double? priceDiscountedMonthly;
  final dynamic attachment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? createdBy;
  final String? updatedBy;
  final int status;

  RoomModel({
    required this.id,
    this.propertyId,
    this.propertyName,
    this.slug,
    this.name,
    this.descriptions,
    required this.periode,
    this.type,
    this.level,
    required this.facility,
    required this.price,
    this.priceOriginalDaily,
    this.priceDiscountedDaily,
    this.priceOriginalMonthly,
    this.priceDiscountedMonthly,
    this.attachment,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
    this.updatedBy,
    required this.status,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['idrec'] ?? 0,
      propertyId: json['property_id'],
      propertyName: json['property_name'],
      slug: json['slug'],
      name: json['name'],
      descriptions: json['descriptions'],
      periode: parseMapBool(json['periode']),
      type: json['type'],
      level: json['level']?.toString(),
      facility: parseMapBool(json['facility']),
      price: parseMapDynamic(json['price']),
      priceOriginalDaily: parseDouble(json['price_original_daily']),
      priceDiscountedDaily: parseDouble(json['price_discounted_daily']),
      priceOriginalMonthly: parseDouble(json['price_original_monthly']),
      priceDiscountedMonthly: parseDouble(json['price_discounted_monthly']),
      attachment: json['attachment'],
      createdAt: parseDate(json['created_at']),
      updatedAt: parseDate(json['updated_at']),
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      status: json['status'] ?? 0,
    );
  }

  static DateTime parseDate(dynamic input) {
    if (input is String) {
      return DateTime.tryParse(input) ?? DateTime(2000);
    }
    return DateTime(2000);
  }

  static double? parseDouble(dynamic input) {
    if (input == null) return null;
    try {
      return double.tryParse(input.toString());
    } catch (_) {
      return null;
    }
  }
}

Map<String, bool> parseMapBool(dynamic raw) {
  if (raw == null) return {};
  try {
    if (raw is String) {
      final decoded = jsonDecode(raw);
      if (decoded is Map) {
        return decoded.map((key, value) {
          final k = key.toString();
          final v = value is bool ? value : value.toString().toLowerCase() == 'true';
          return MapEntry(k, v);
        });
      }
    }

    if (raw is Map) {
      return raw.map((key, value) {
        final k = key.toString();
        final v = value is bool ? value : value.toString().toLowerCase() == 'true';
        return MapEntry(k, v);
      });
    }
  } catch (e) {
    print("parseMapBool error: $e");
  }
  return {};
}

Map<String, dynamic> parseMapDynamic(dynamic raw) {
  if (raw == null) return {};
  try {
    if (raw is String) {
      final decoded = jsonDecode(raw);
      if (decoded is Map) {
        return decoded.map((key, value) => MapEntry(key.toString(), value));
      }
    }

    if (raw is Map) {
      return raw.map((key, value) => MapEntry(key.toString(), value));
    }
  } catch (e) {
    print("parseMapDynamic error: $e");
  }
  return {};
}
