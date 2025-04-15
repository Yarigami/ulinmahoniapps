import 'package:go_router/go_router.dart';
import 'package:ulinmahoniapps/features/comingsoon/presentation/pages/comingsoon.dart';
import 'package:ulinmahoniapps/features/splashscreen/presentation/pages/splashscreen.dart';
import 'package:ulinmahoniapps/features/home/presentation/pages/homepage.dart';
import 'package:ulinmahoniapps/features/mybooking/presentation/pages/bookingpage.dart';
import 'package:ulinmahoniapps/features/smarthome/presentation/pages/smarthome.dart';
import 'package:ulinmahoniapps/features/umi/presentation/pages/umi.dart';
import 'package:ulinmahoniapps/features/profiles/presentation/pages/profilepage.dart';
import 'package:ulinmahoniapps/features/propertytype/presentation/pages/propertytypepage.dart';
import 'package:ulinmahoniapps/core/layout/mainlayout.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        final path = state.uri.toString();
        final currentIndex = _getCurrentIndex(path);
        return MainLayout(currentIndex: currentIndex, child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/booking',
          builder: (context, state) => const BookingPage(),
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
        GoRoute(
          path: '/browse-all',
          builder: (context, state) => const PropertyTypePage(),
        ),
        GoRoute(
          path: '/comingsoon',
          builder: (context, state) => const ComingSoonPage(),
        ),
      ],
    ),
  ],
);

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
      return 0;
  }
}
