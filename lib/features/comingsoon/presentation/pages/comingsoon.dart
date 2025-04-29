import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart'; // Menambahkan import untuk mengatur orientasi layar
import '../../../../core/layout/mainlayout.dart'; // ganti sesuai path project kamu

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mengunci orientasi layar ke portrait
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    const maroon = Color(0xFF800000);
    const darkGreen = Color(0xFF184D37);

    final screenSize = MediaQuery.of(context).size;

    return MainLayout(
      currentIndex: 4,
      showBottomNav: false,
      showNavBar: false,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/ulinmahonilogo.png',
                          width: screenSize.width * 0.7,
                          height: screenSize.width * 0.7,
                        ),
                      ),

                      Text(
                        'COMING',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: maroon,
                        ),
                      ),
                      Text(
                        'SOON',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: darkGreen,
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "We're working hard to making\nsomething amazing, stay tune",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
