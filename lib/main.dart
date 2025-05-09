import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'presentation/widgets/bottomnavbar.dart';
import 'package:ulinmahoniapps/presentation/pages/splashscreen.dart';
import 'package:ulinmahoniapps/presentation/pages/homepage.dart';
import 'package:ulinmahoniapps/presentation/pages/bookingpage.dart';
import 'package:ulinmahoniapps/presentation/pages/smarthome.dart';
import 'package:ulinmahoniapps/presentation/pages/umi.dart';
import 'package:ulinmahoniapps/presentation/pages/profilepage.dart';

void main() {
  runApp(const MyApp());
}

/// Routing config
final GoRouter _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    /// Splash screen tanpa bottom nav
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),

    /// Route dengan BottomNavigationBar menggunakan ShellRoute
    ShellRoute(
      builder: (context, state, child) {
        // Menentukan currentIndex berdasarkan path yang sedang aktif
        String currentLocation = state.uri.toString();
        int currentIndex = _getCurrentIndex(currentLocation);
        return Scaffold(
          body: child,
          bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex),
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/booking',
          builder: (context, state) => const Bookingpage(),
        ),
        GoRoute(
          path: '/smart-home',
          builder: (context, state) => const SmartHomePage(),
        ),
        GoRoute(
          path: '/umi',
          builder: (context, state) => const UmiPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
);

/// Fungsi untuk menentukan currentIndex berdasarkan path
int _getCurrentIndex(String path) {
  switch (path) {
    case '/home':
      return 0;
    case '/booking':
      return 1;
    case '/smart-home':
      return 2;
    case '/umi':
      return 3;
    case '/profile':
      return 4;
    default:
      return 0; // default ke halaman Home jika tidak ditemukan
  }
}

/// Aplikasi utama
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ulin Mahoni',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
