import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/mainlayout.dart'; // ganti sesuai path project kamu

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    const maroon = Color(0xFF800000);
    const darkGreen = Color(0xFF184D37);

    final screenSize = MediaQuery.of(context).size;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return MainLayout(
      currentIndex: 0,
      showBottomNav: false,
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
                      const SizedBox(height: 32),
                      Center(
                        child: Image.asset(
                          'assets/images/ulinmahonilogo.jpeg',
                          width: isLandscape ? screenSize.height * 0.2 : screenSize.width * 0.3,
                          height: isLandscape ? screenSize.height * 0.2 : screenSize.width * 0.3,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'COMING',
                        style: TextStyle(
                          fontSize: isLandscape ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          color: maroon,
                        ),
                      ),
                      Text(
                        'SOON',
                        style: TextStyle(
                          fontSize: isLandscape ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          color: darkGreen,
                        ),
                      ),
                      const SizedBox(height: 24),
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
                      const SizedBox(height: 32),
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
