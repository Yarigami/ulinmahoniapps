import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/auth_services.dart';
import '../model/auth_model.dart';

// Provider untuk AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// State untuk Auth
class AuthState {
  final bool isLoggedIn;
  final AsyncValue<User?> user;
  final String? token;

  AuthState({
    this.isLoggedIn = false,
    this.user = const AsyncValue.data(null),
    this.token,
  });

  AuthState copyWith({
    bool? isLoggedIn,
    AsyncValue<User?>? user,
    String? token,
  }) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }
}

// AuthNotifier untuk mengelola status Auth
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this.ref) : super(AuthState());

  final Ref ref;

  Future<void> login(String email, String password) async {
    state = state.copyWith(user: const AsyncValue.loading());

    final authService = ref.read(authServiceProvider);
    try {
      final result = await authService.login(email, password);
      if (result != null && result['user'] != null) {
        final user = User.fromJson(result['user']);
        final String token = result['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);

        state = state.copyWith(
          isLoggedIn: true,
          user: AsyncValue.data(user),
          token: token,
        );
      } else {
        state = state.copyWith(
          isLoggedIn: false,
          user: const AsyncValue.data(null),
          token: null,
        );
      }
    } catch (e, st) {
      state = state.copyWith(
        isLoggedIn: false,
        user: AsyncValue.error(e, st),
        token: null,
      );
    }
  }

  Future<void> logout() async {
    final authService = ref.read(authServiceProvider);
    await authService.logout();

    // Hapus token dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');

    state = AuthState(); // Reset state
  }
}

// Provider untuk menyuplai AuthNotifier
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});
