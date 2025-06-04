import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class PermissionService {
  static Future<bool> requestAppPermissions() async {
    try {
      // Request multiple permissions at once
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.location,
        Permission.sms,
        Permission.phone,
      ].request();

      // Check if all permissions were granted
      bool allGranted = statuses.values.every((status) => 
        status.isGranted || status.isLimited
      );

      if (!allGranted) {
        // Show permission denied dialog
        await showDialog(
          context: navigatorKey.currentContext!,
          builder: (context) => AlertDialog(
            title: const Text('Permissions Required'),
            content: const Text(
              'This app needs access to your files, location, SMS, and phone to function properly. Please grant the required permissions.'
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  await openAppSettings();
                  Navigator.pop(context);
                },
                child: const Text('Open Settings'),
              ),
            ],
          ),
        );
      }

      return allGranted;
    } catch (e) {
      debugPrint('Permission request error: $e');
      return false;
    }
  }

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
