import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/register_service.dart'; // Import RegisterService
import '../model/register_model.dart'; // Import Register model

//  Provider for the RegisterController
final registerControllerProvider = StateNotifierProvider<RegisterController, bool>((ref) {
  return RegisterController(ref);
});

class RegisterController extends StateNotifier<bool> {
  final Ref _ref;

  RegisterController(this._ref) : super(false);

  Future<String?> register(String username, String email, String password) async {
    state = true;

    // Validasi awal
    if (username.trim().isEmpty || email.trim().isEmpty || password.trim().isEmpty) {
      state = false;
      return 'Semua kolom harus diisi.';
    }

    // Validasi format email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      state = false;
      return 'Format email tidak valid.';
    }

    // Validasi panjang password
    if (password.length < 8) {
      state = false;
      return 'Password minimal 8 karakter.';
    }

    try {
      final registerService = RegisterService();
      final Register registerResponse = await registerService.register(
        username: username,
        email: email,
        password: password,
      );

      print('✅ Registration successful');
      return null;
    } catch (e) {
      print('❌ Registration failed: $e');
      return 'Registration gagal: $e';
    } finally {
      state = false;
    }
  }
}

