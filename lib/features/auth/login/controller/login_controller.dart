import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../login/provider/auth_providers.dart';

final loginControllerProvider = StateNotifierProvider<LoginController, bool>((ref) {
  return LoginController(ref);
});

class LoginController extends StateNotifier<bool> {
  final Ref _ref;

  LoginController(this._ref) : super(false);

  Future<String?> login(String email, String password) async {
    state = true; // Set loading

    // Validasi awal
    if (email.trim().isEmpty || password.trim().isEmpty) {
      state = false;
      return 'Semua kolom wajib terisi.';
    }

    try {
      await _ref.read(authProvider.notifier).login(email, password);

      final authState = _ref.read(authProvider);
      if (authState.isLoggedIn) {
        print('✅ Login berhasil');
        return null;
      } else {
        print('❌ Login gagal');
        return 'Login gagal. Periksa kembali data Anda.';
      }
    } catch (e) {
      print('❌ Exception: $e');
      return 'Terjadi kesalahan: $e';
    } finally {
      state = false;
    }
  }
}
