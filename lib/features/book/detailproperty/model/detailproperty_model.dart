class DetailPropertyModel {
  final int id;
  final String slug;
  final String tags;
  final String name;
  final String description;
  final String province;
  final String city;
  final String subdistrict;
  final String village;
  final String postalCode;
  final String address;
  final String location;
  final String distance;
  final Price price;
  final Map<String, String> features;
  final Attributes attributes;
  final String? image; // bisa null atau blob
  final int status;
  final String createdAt;
  final String updatedAt;
  final String? createdBy;
  final String? updatedBy;

  DetailPropertyModel({
    required this.id,
    required this.slug,
    required this.tags,
    required this.name,
    required this.description,
    required this.province,
    required this.city,
    required this.subdistrict,
    required this.village,
    required this.postalCode,
    required this.address,
    required this.location,
    required this.distance,
    required this.price,
    required this.features,
    required this.attributes,
    this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  factory DetailPropertyModel.fromJson(Map<String, dynamic> json) {
    return DetailPropertyModel(
      id: json['idrec'],
      slug: json['slug'],
      tags: json['tags'],
      name: json['name'],
      description: json['description'],
      province: json['province'],
      city: json['city'],
      subdistrict: json['subdistrict'],
      village: json['village'],
      postalCode: json['postal_code'],
      address: json['address'],
      location: json['location'],
      distance: json['distance'],
      price: Price.fromJson(json['price']),
      features: Map<String, String>.from(json['features']),
      attributes: Attributes.fromJson(json['attributes']),
      image: json['image'], // jika di backend base64/blob, bisa didecode nanti
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }
}

class Price {
  final int original;
  final int discounted;

  Price({required this.original, required this.discounted});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      original: json['original'],
      discounted: json['discounted'],
    );
  }
}

class Attributes {
  final List<String> amenities;

  Attributes({required this.amenities});

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      amenities: List<String>.from(json['amenities']),
    );
  }
}
