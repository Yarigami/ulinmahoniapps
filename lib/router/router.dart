import 'package:go_router/go_router.dart';
import 'package:ulinmahoniapps/features/auth/presentation/pages/createnewpassword_page.dart';
import 'package:ulinmahoniapps/features/auth/presentation/pages/forgotpassword_page.dart';
import 'package:ulinmahoniapps/features/auth/presentation/pages/login_page.dart';
import 'package:ulinmahoniapps/features/auth/presentation/pages/otpverify_page.dart';
import 'package:ulinmahoniapps/features/auth/presentation/pages/passwordchanged_page.dart';
import 'package:ulinmahoniapps/features/auth/presentation/pages/register_page.dart';
import 'package:ulinmahoniapps/features/auth/presentation/pages/welcoming_page.dart';
import 'package:ulinmahoniapps/features/book/presentation/pages/bookhousepage.dart';
import 'package:ulinmahoniapps/features/detailproperty/presentation/pages/detailhousepage.dart';
import 'package:ulinmahoniapps/features/help/presentation/pages/help_page.dart';
import 'package:ulinmahoniapps/features/housing/presentation/pages/searchresult_page.dart';
import 'package:ulinmahoniapps/features/UM/presentation/pages/um_page.dart';
import 'package:ulinmahoniapps/features/comingsoon/presentation/pages/comingsoon.dart';
import 'package:ulinmahoniapps/features/mybooking/presentation/pages/mybookingdetails_page.dart';
import 'package:ulinmahoniapps/features/payment/presentation/pages/paymentpage.dart';
import 'package:ulinmahoniapps/features/profiles/presentation/pages/updateprofilepage.dart';
import 'package:ulinmahoniapps/features/splashscreen/presentation/pages/splashscreen.dart';
import 'package:ulinmahoniapps/features/home/presentation/pages/homepage.dart';
import 'package:ulinmahoniapps/features/mybooking/presentation/pages/mybooking_page.dart';
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
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: '/mybookingdetails',
          builder: (context, GoRouterState state) {
            // Menerima data extra yang dikirim dari halaman sebelumnya
            final bookingData = state.extra as Map<String, dynamic>;
            // Mengirimkan data ke MyBookingDetail
            return MyBookingDetail(bookingData: bookingData);  // Tidak perlu null untuk bookingId
          },
        ),

      ],
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
      path: '/search',
      builder: (context, state) => const SearchResult(),
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
      path: '/updateprofile',
      builder: (context, state) => UpdateProfile(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => WelcomePage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => Registerpage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/forgetpassword',
      builder: (context, state) => ForgotPassword(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => OTP_VerifyPage(),
    ),
    GoRoute(
      path: '/createnewpassword',
      builder: (context, state) => CreateNewPassword(),
    ),
    GoRoute(
      path: '/passwordchanged',
      builder: (context, state) => PasswordChanged(),
    ),
    GoRoute(
      path: '/help',
      builder: (context, state) => HelpPage(),
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
