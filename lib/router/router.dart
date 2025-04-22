import 'package:go_router/go_router.dart';
import 'package:ulinmahoniapps/features/booking/presentation/DetailHousePage.dart';
import 'package:ulinmahoniapps/features/housing/presentation/pages/housingpage.dart';
import 'package:ulinmahoniapps/features/UM/presentation/pages/UMpage.dart';
import 'package:ulinmahoniapps/features/comingsoon/presentation/pages/comingsoon.dart';
import 'package:ulinmahoniapps/features/splashscreen/presentation/pages/splashscreen.dart';
import 'package:ulinmahoniapps/features/home/presentation/pages/homepage.dart';
import 'package:ulinmahoniapps/features/mybooking/presentation/pages/mybookingpage.dart';
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
          builder: (context, state) => MyBookingPage(),
        ),
        GoRoute(
          path: '/um',
          builder: (context, state) => const UMpage(),
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
        GoRoute(
          path: '/housing',
          builder: (context, state) => const HousingPage(),
        ),
        GoRoute(
          path: '/detailhouse',
          builder: (context, state) => const DetailHousePage(),
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
    case '/profile':
      return 2;
    case '/um':
      return 3;
    default:
      return 0;
  }
}
