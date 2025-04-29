import 'package:go_router/go_router.dart';
import 'package:ulinmahoniapps/features/book/presentation/pages/bookhousepage.dart';
import 'package:ulinmahoniapps/features/detailproperty/presentation/pages/detailhousepage.dart';
import 'package:ulinmahoniapps/features/housing/presentation/pages/housingpage.dart';
import 'package:ulinmahoniapps/features/UM/presentation/pages/UMpage.dart';
import 'package:ulinmahoniapps/features/comingsoon/presentation/pages/comingsoon.dart';
import 'package:ulinmahoniapps/features/mybooking/presentation/pages/mybookingdetailspage.dart';
import 'package:ulinmahoniapps/features/payment/presentation/paymentpage.dart';
import 'package:ulinmahoniapps/features/profiles/presentation/pages/updateprofilepage.dart';
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
    // ShellRoute untuk halaman-halaman yang menggunakan MainLayout
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
          path: '/mybooking',
          builder: (context, state) => const MyBookingPage(),
        ),
        GoRoute(
          path: '/um',
          builder: (context, state) => const UMpage(),
        ),
        GoRoute(
          path: '/comingsoon',
          builder: (context, state) => const ComingSoonPage(),
        ),
      ],
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
      path: '/bookhouse',
      builder: (context, state) => const BookHousePage(),
    ),
    GoRoute(
      path: '/housing',
      builder: (context, state) => const HousingPage(),
    ),
    GoRoute(
      path: '/detailhouse',
      builder: (context, state) => const DetailHousePage(),
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) => PaymentPage(),
    ),
    GoRoute(
      path: '/mybookingdetails',
      builder: (context, GoRouterState state) {
        return const MyBookingDetail();
      },
    ),
    GoRoute(
      path: '/updateprofile',
      builder: (context, state) => UpdateProfile(),
    ),
  ],
);

int _getCurrentIndex(String path) {
  switch (path) {
    case '/home':
      return 0;
    case '/mybooking':
      return 1;
    case '/um':
      return 2;
    case '/profile':
      return 3;
    default:
      return 4;
  }
}
