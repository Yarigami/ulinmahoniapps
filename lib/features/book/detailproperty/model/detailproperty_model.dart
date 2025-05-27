class DetailPropertyModel {
  final int? id;
  final String? tags;
  final String? name;
  final String? description;
  final String? location;
  final String? image;

  DetailPropertyModel({
    this.id,
    this.tags,
    this.name,
    this.description,
    this.location,
    this.image,
  });

  factory DetailPropertyModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    if (data == null) {
      print('Error: "data" key is missing or null in JSON');
      return DetailPropertyModel();
    }

    return DetailPropertyModel(
      id: data['idrec'] as int?,
      tags: data['tags'] as String?,
      name: data['name'] as String?,
      description: data['description'] as String?,
      location: data['location'] as String?,
      image: data['image'] as String?,
    );
  }
}
