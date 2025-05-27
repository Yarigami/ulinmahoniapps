import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ulinmahoniapps/features/auth/createnewpassword/presentation/pages/createnewpassword_page.dart';
import 'package:ulinmahoniapps/features/auth/forgotpassword/presentation/pages/forgotpassword_page.dart';
import 'package:ulinmahoniapps/features/auth/login/presentation/pages/login_page.dart';
import 'package:ulinmahoniapps/features/auth/otpverify/presentation/pages/otpverify_page.dart';
import 'package:ulinmahoniapps/features/auth/passwordchanged/presentation/pages/passwordchanged_page.dart';
import 'package:ulinmahoniapps/features/auth/register/presentation/pages/register_page.dart';
import 'package:ulinmahoniapps/features/auth/welcoming/presentation/pages/welcoming_page.dart';
import 'package:ulinmahoniapps/features/book/detailproperty/model/detailproperty_model.dart';
import 'package:ulinmahoniapps/features/book/roomdetails/presentation/pages/roomdetails_page.dart';
import 'package:ulinmahoniapps/features/book/detailproperty/presentation/pages/detailhousepage.dart';
import 'package:ulinmahoniapps/features/error/presentation/pages/errorpage.dart';
import 'package:ulinmahoniapps/features/help/presentation/pages/help_page.dart';
import 'package:ulinmahoniapps/features/searchresult/presentation/pages/searchresult_page.dart';
import 'package:ulinmahoniapps/features/comingsoon/presentation/pages/comingsoon.dart';
import 'package:ulinmahoniapps/features/mybooking/mybookingdetails/presentation/pages/mybookingdetails_page.dart';
import 'package:ulinmahoniapps/features/book/payment/presentation/pages/paymentpage.dart';
import 'package:ulinmahoniapps/features/profiles/updateprofile/presentation/pages/updateprofilepage.dart';
import 'package:ulinmahoniapps/features/splashscreen/presentation/pages/splashscreen.dart';
import 'package:ulinmahoniapps/features/home/presentation/pages/homepage.dart';
import 'package:ulinmahoniapps/features/mybooking/mybooking/presentation/pages/mybooking_page.dart';
import 'package:ulinmahoniapps/features/profiles/viewprofile/presentation/pages/profilepage.dart';
import 'package:ulinmahoniapps/features/propertytype/presentation/pages/propertytypepage.dart';
import 'package:ulinmahoniapps/core/layout/mainlayout.dart';
import '../features/book/roomdetails/model/rooms_model.dart';

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
        GoRoute(
          path: '/error',
          builder: (context, state) {
            final errorMessage = state.extra as String? ?? 'Unknown error';
            return ErrorPage(errorMessage: errorMessage);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/browse-all',
      builder: (context, state) => const PropertyTypePage(),
    ),
    GoRoute(
      path: '/roomdetails/:id', // Menggunakan parameter :id
      builder: (context, state) {
        // Ambil ID dari path
        final roomId = state.pathParameters['id'];
        print('Navigating to RoomDetails for ID: $roomId'); // Untuk debugging
        final extra = state.extra as Map<String, dynamic>?;
        if (extra == null) {
          return const Scaffold(
            body: Center(child: Text('No data provided')),
          );
        }

        final room = extra['room'] as RoomModel;
        final property = extra['property'] as DetailPropertyModel;

        return RoomDetailsPage(
          room: room,
          propertyData: property,
        );
      },
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchResult(),
    ),
    GoRoute(
      path: '/detailhouse/:id',
      builder: (context, state) {
        final idString = state.pathParameters['id'];
        print('Navigating to DetailProperty for ID: $idString'); // Untuk debugging
        final id = int.tryParse(idString ?? '');
        if (id == null) {
          return const Scaffold(body: Center(child: Text('Invalid ID')));
        }
        return DetailHousePage(id: id);
      },
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;

        return PaymentPage(
          room: extra['room'] as RoomModel,
          propertyData: extra['propertyData'] as DetailPropertyModel,
          rentType: extra['rentType'] as String,
          duration: extra['duration'] as int,
          checkInDate: extra['checkInDate'] as DateTime,
          checkOutDate: extra['checkOutDate'] as DateTime,
        );
      },
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
      builder: (context, state) => RegisterPage(),
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
