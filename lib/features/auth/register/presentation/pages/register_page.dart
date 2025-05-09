import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../controller/register_controller.dart';
import '../widgets/errordialog.dart';
import '../widgets/inputfield.dart';
import '../widgets/passwordfield.dart';
import '../widgets/socialmedi.dart';

class RegisterPage extends ConsumerStatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    // Get the state from the provider
    final registerState = ref.watch(registerControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo image
                Image.asset("assets/images/ulinmahonilogo.png", height: 120),
                SizedBox(height: 24),
                Text(
                  "Hello! Daftar untuk memulai",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),

                // Username input
                inputField("Username", _usernameController),
                SizedBox(height: 16),

                // Email input
                inputField("Email", _emailController),
                SizedBox(height: 16),

                passwordField(
                  "Password",
                  _passwordController,
                  obscure: _obscurePassword,
                  onToggleVisibility: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                SizedBox(height: 4),
                Text(
                  "Password harus terdiri dari minimal 8 karakter.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 16),

                passwordField(
                  "Konfirmasi password",
                  _confirmPasswordController,
                  obscure: _obscureConfirmPassword,
                  onToggleVisibility: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                SizedBox(height: 4),
                Text(
                  "Masukkan ulang password yang sama untuk konfirmasi.",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 24),

                // Register Button
                ElevatedButton(
                  onPressed: registerState
                      ? null
                      : () async {
                    final username = _usernameController.text;
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final confirmPassword = _confirmPasswordController.text;

                    // Password validation
                    if (password != confirmPassword) {
                      showErrorDialog(context, 'Password dan konfirmasi password yang Anda masukkan tidak sesuai');
                      return;
                    }

                    // Validasi di UI
                    if (username.trim().isEmpty || email.trim().isEmpty || password.trim().isEmpty) {
                      showErrorDialog(context, 'Beberapa kolom wajib tidak boleh kosong.');
                      return;
                    }

                    // Validasi format email
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(email)) {
                      showErrorDialog(context, 'Alamat email yang Anda masukkan tidak valid');
                      return;
                    }

                    // Validasi panjang password
                    if (password.length < 8) {
                      showErrorDialog(context, 'Password Anda harus terdiri dari minimal 8 karakter');
                      return;
                    }

                    // Call provider for registration
                    final errorMessage = await ref.read(registerControllerProvider.notifier).register(username, email, password);

                    if (errorMessage == null) {
                      context.go('/login');
                    } else {
                      showErrorDialog(context, errorMessage);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF124624),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: registerState
                      ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ))
                      : Text("Daftar"),
                ),
                SizedBox(height: 32),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text("Atau daftar dengan", style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade400)),
                  ],
                ),
                SizedBox(height: 24),

                // Social Media login options
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialMedia("assets/images/facebook.png"),
                    SizedBox(width: 24),
                    socialMedia("assets/images/google.png"),
                    SizedBox(width: 24),
                    socialMedia("assets/images/apple.png"),
                  ],
                ),
                SizedBox(height: 48),

                // Navigate to Login page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sudah punya akun?"),
                    TextButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      style: TextButton.styleFrom(foregroundColor: Color(0xFF124624)),
                      child: Text("Masuk sekarang"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
