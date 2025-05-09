import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/register_services.dart';

// StateNotifier untuk mengelola status registrasi
class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier() : super(RegisterState());

  Future<void> register(String username, String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: '');
      final registerService = RegisterService();
      await registerService.register(username: username, email: email, password: password);
      state = state.copyWith(isLoading: false, errorMessage: '');
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

class RegisterState {
  final bool isLoading;
  final String errorMessage;

  RegisterState({this.isLoading = false, this.errorMessage = ''});

  RegisterState copyWith({bool? isLoading, String? errorMessage}) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// RegisterProvider untuk digunakan di UI
final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  return RegisterNotifier();
});
