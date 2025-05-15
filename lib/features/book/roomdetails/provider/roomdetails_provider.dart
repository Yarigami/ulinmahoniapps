import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/rooms_model.dart';

// Provider yang menyimpan RoomModel yang bisa berubah-ubah (state)
final roomDataProvider = StateProvider<RoomModel?>((ref) => null);
