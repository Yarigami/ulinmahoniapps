import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/auth_services.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>(
      (ref) => AuthController(ref),
);

class AuthController extends StateNotifier<AsyncValue<void>> {
  final Ref ref;

  AuthController(this.ref) : super(const AsyncData(null));

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    final authService = AuthService();

    try {
      final result = await authService.login(email, password);

      if (result != null) {
        // Token diterima dan disimpan otomatis ke Cookie oleh AuthService
        state = const AsyncData(null);
      } else {
        // Jika null atau error message dikembalikan dari login()
        state = AsyncError(result ?? 'Login gagal', StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError('Terjadi kesalahan: $e', st);
    }
  }
}
