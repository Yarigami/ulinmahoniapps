class Property {
  final int idrec;
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
  final Features features;
  final Attributes attributes;
  final String? image;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String? createdBy;
  final String? updatedBy;

  Property({
    required this.idrec,
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
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      idrec: json['idrec'],
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
      features: Features.fromJson(json['features']),
      attributes: Attributes.fromJson(json['attributes']),
      image: json['image'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idrec': idrec,
      'slug': slug,
      'tags': tags,
      'name': name,
      'description': description,
      'province': province,
      'city': city,
      'subdistrict': subdistrict,
      'village': village,
      'postal_code': postalCode,
      'address': address,
      'location': location,
      'distance': distance,
      'price': price.toJson(),
      'features': features.toJson(),
      'attributes': attributes.toJson(),
      'image': image,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_by': createdBy,
      'updated_by': updatedBy,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'original': original,
      'discounted': discounted,
    };
  }
}

class Features {
  final Map<String, String> data;

  Features({required this.data});

  factory Features.fromJson(Map<String, dynamic> json){
    return Features(data: json.map((key, value) => MapEntry(key.toString(), value.toString())));
  }

  Map<String, dynamic> toJson(){
    return data;
  }
}

class Attributes {
  final List<String> amenities;
  final List<String> roomFacilities;
  final List<String> rules;

  Attributes({
    required this.amenities,
    required this.roomFacilities,
    required this.rules,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      amenities: List<String>.from(json['amenities']),
      roomFacilities: List<String>.from(json['room_facilities']),
      rules: List<String>.from(json['rules']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amenities': amenities,
      'room_facilities': roomFacilities,
      'rules': rules,
    };
  }
}