import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rapidoclone/routes/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'RapidO',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.offNamed(AppRoutes.home);
              },
              child: const Text('Skip to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
