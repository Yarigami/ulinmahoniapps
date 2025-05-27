import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/properties_api_services.dart';
import '../model/properties_model.dart';

// Provider yang membuat instance service (optional, bisa juga langsung pakai service static)
final propertyServiceProvider = Provider<PropertyService>((ref) {
  return PropertyService();
});

// FutureProvider untuk ambil data properti dari API secara async
final propertiesProvider = FutureProvider<List<PropertyModel>>((ref) async {
  final service = ref.watch(propertyServiceProvider);
  final propertiesList = await service.fetchProperties();

  // Filter list sesuai kebutuhan, misal yg tag-nya mengandung 'house'
  final filteredList = propertiesList
      .where((property) => property.tags.toLowerCase().contains('house'))
      .toList();

  return filteredList;
});
