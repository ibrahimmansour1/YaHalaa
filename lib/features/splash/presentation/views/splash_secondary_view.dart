import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yahalaa/features/splash/presentation/views/widgets/splash_secondary_body.dart';

class SplashSecondary extends StatelessWidget {
  const SplashSecondary({super.key});

  @override
  Widget build(BuildContext context) {
//fayez
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0), // here the desired height
          child: AppBar(
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white, // <-- SEE HERE
              statusBarIconBrightness:
                  Brightness.dark, //<-- For Android SEE HERE (dark icons)
              systemNavigationBarColor: Colors.white,
              statusBarBrightness:
                  Brightness.light, //<-- For iOS SEE HERE (dark icons)
            ),
          )),
      body: const SplashSecondaryBody(),
    );
  }
}
