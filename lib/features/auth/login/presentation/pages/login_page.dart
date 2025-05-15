import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ulinmahoniapps/core/widgets/backbutton.dart';
import '../../../login/provider/auth_provider.dart';
import '../../../login/controller/login_controller.dart';
import '../widgets/inputfield.dart';
import '../widgets/passwordfield.dart';
import '../widgets/errordialog.dart';
import '../widgets/socialmedi.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoginButtonEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: CustomBackButton(iconColor: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Image.asset("assets/images/ulinmahonilogo.png", width: 150, height: 150),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Selamat datang kembali , kami senang bertemu denganmu",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    inputField("Masukan email anda", controller: _emailController),
                    SizedBox(height: 16),
                    PasswordField(hint: "Masukan password anda", controller: _passwordController),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.push('/forgetpassword');
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                            foregroundColor: MaterialStateProperty.all(Colors.grey[600]),
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Text("Lupa Password?"),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();

                          // Validasi input
                          if (email.isEmpty || password.isEmpty) {
                            showErrorDialog(context, 'Beberapa kolom wajib tidak boleh kosong');
                            return;
                          }

                          // Validasi format email
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,4}$');
                          if (!emailRegex.hasMatch(email)) {
                            showErrorDialog(context, 'Alamat email yang Anda masukkan tidak valid');
                            return;
                          }

                          // Validasi panjang password
                          if (password.length < 8) {
                            showErrorDialog(context, 'Password Anda harus terdiri dari minimal 8 karakter.');
                            return;
                          }

                          try {
                            // Panggil login controller
                            await ref.read(loginControllerProvider.notifier).login(email, password);

                            final isLoggedIn = ref.read(authProvider).isLoggedIn;
                            if (isLoggedIn) {
                              context.go('/home'); // Arahkan ke halaman home jika login berhasil
                            } else {
                              showErrorDialog(context, 'Email atau password tidak sesuai');
                            }
                          } catch (e) {
                            showErrorDialog(context, 'Terjadi kesalahan: $e');
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: _isLoginButtonEnabled
                              ? MaterialStateProperty.all(Color(0xFF124624))
                              : MaterialStateProperty.all(Colors.grey),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Masuk",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade400)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text("Atau masuk dengan", style: TextStyle(color: Colors.grey)),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade400)),
                      ],
                    ),
                    SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          socialMedia("assets/images/facebook.png"),
                          socialMedia("assets/images/google.png"),
                          socialMedia("assets/images/apple.png"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
                child: TextButton(
                  onPressed: () {
                    context.push('/register');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.transparent),
                    foregroundColor: MaterialStateProperty.all(Color(0xFF124624)),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Tidak punya akun? ", style: TextStyle(color: Colors.black)),
                      Text("Daftar sekarang"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
