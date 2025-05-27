// lib/features/home/provider/property_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/properties_api_services.dart'; // Pastikan path ini benar
import '../model/properties_model.dart';   // Pastikan path ini benar

// Provider yang membuat instance service
final propertyServiceProvider = Provider<PropertyService>((ref) {
  return PropertyService();
});

// FutureProvider.family untuk ambil data properti berdasarkan tag
// Parameter 'String tag' akan diterima dari ref.watch(propertiesProvider(tag)) di HomePage
final propertiesProvider = FutureProvider.family<List<PropertyModel>, String>((ref, tag) async {
  final service = ref.watch(propertyServiceProvider);

  // Jika tag kosong, ambil semua properti. Jika ada tag, ambil berdasarkan tag.
  if (tag.isEmpty) {
    print('Fetching all properties...'); // Debugging log
    return await service.fetchProperties(); // Memanggil metode fetchProperties tanpa filter tag
  } else {
    print('Fetching properties with tag: $tag'); // Debugging log
    return await service.fetchPropertiesByTag(tag); // Memanggil metode fetchPropertiesByTag dengan filter tag
  }
});