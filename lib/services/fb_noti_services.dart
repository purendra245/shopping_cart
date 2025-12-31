import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/main.dart';

class FbNotiServices {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    debugPrint('🚀 Starting FCM Init...');
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken == null) {
      debugPrint('❌ Token is NULL - Check Firebase Console/Config');
    } else {
      debugPrint('✅ FCM Token: $fcmToken');
    }
    initPushNotification();
  }

  void handleNotfication(RemoteMessage? message) {
    if (message != null) {
      //handle to screen when user tap on notification
      navigatorKey.currentState?.pushNamed(
        '/notification_page',
        arguments: message,
      );
    }
  }

  Future initPushNotification() async {
    // handle notification if the app was terminated and now open

    FirebaseMessaging.instance.getInitialMessage().then(handleNotfication);

    // attach even listener for  when the notification open the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotfication);
  }
}
