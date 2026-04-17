// // Integrating push notifications into your Flutter app is a crucial step for sending real-time updates, like the subscription status changes we discussed. The industry standard and most reliable approach is to use Firebase Cloud Messaging (FCM) .
// //
// // Here is a practical guide to get you started, keeping your goal of a free and scalable backend in mind.
// //
// // 💡 1. Local vs. Remote Notifications
// // Before diving into code, it's helpful to distinguish between the two main types of notifications.
// //
// // Remote Notifications (Push Notifications): These are messages sent from your server (or a service like Firebase) to a user's device, even when the app is closed. This is what you need to send alerts about subscription status or promotional offers. FCM is the solution for this and has a generous free tier perfect for starting out .
// //
// // Local Notifications: These are triggered directly by the app on the device, based on a schedule or an event. For example, a to-do app reminding you of a task at 5 PM. It doesn't require any server. Packages like awesome_notifications or flutter_local_notifications are great for this . You can use them to create a seamless user experience, like a welcome message right after a user subscribes.
// //
// // 🛠️ 2. Step-by-Step: Setting Up FCM in Flutter
// // Follow these steps to integrate FCM. The setup involves work in the Firebase Console, your Flutter code, and native platform configurations.
// //
// // Step 1: Project Setup (Firebase Console & Dependencies)
// // Create a Firebase Project: Go to the Firebase Console and create a new project.
// //
// // Register Your App: Register both your Android and iOS apps with Firebase. You will need your app's package name.
// //
// // Download Config Files: Download the google-services.json (Android) and GoogleService-Info.plist (iOS) files and place them in the correct folders as instructed by Firebase .
// //
// // Add Dependencies: In your Flutter project's pubspec.yaml, add the core Firebase packages:
// //
// // yaml
// // dependencies:
// //   firebase_core: ^latest_version
// //   firebase_messaging: ^latest_version
// // Run flutter pub get to install them.
// //
// // Step 2: Platform-Specific Configurations
// // For everything to work, you need to enable a few capabilities natively.
// //
// // For iOS:
// //
// // Open ios/Runner.xcworkspace in Xcode.
// // Go to the Signing & Capabilities tab.
// // Click + Capability and add Push Notifications.
// // Add Background Modes and check Remote notifications .
// // Upload your Apple Push Notification Authentication Key (APNs key) to Firebase. You can find this in the Firebase Console under Project Settings > Cloud Messaging.
// // For Android:
// //
// // The google-services.json file handles most of the setup. Ensure your minSdk in android/app/build.gradle is at least 21, as FCM requires this for full functionality.
// //
// // Step 3: Implementing FCM in Flutter Code
// // Now for the core logic. The best practice is to centralize all this in a single service class, as shown in the code below. This creates a NotificationService that you can call from anywhere in your app, especially after a successful payment.
//
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:timezone/data/latest.dart' as tz;
//
// class NotificationService {
// final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//
// // Call this when your app starts, e.g., in main() or your splash screen
// Future<void> init() async {
// // 1. Request permissions (required for iOS)
// NotificationSettings settings = await _fcm.requestPermission(
// alert: true,
// badge: true,
// sound: true,
// provisional: false,
// );
//
// // 2. Get the device token (this is the unique ID to send notifications to)
// String? token = await _fcm.getToken();
// print('Device FCM Token: $token');
// // TODO: Send this token to your Java backend and save it for the logged-in user
//
// // 3. Listen for when the app is in the foreground
// FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// print('Got a message while in foreground!');
// // You can show a custom in-app dialog here
// });
//
// // 4. Listen for when the user taps on a notification (app in background)
// FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
// print('User tapped on a notification!');
// // Navigate to a specific screen, e.g., the subscription page
// });
//
// // 5. Handle the case when the app is opened from a terminated state
// RemoteMessage? initialMessage = await _fcm.getInitialMessage();
// if (initialMessage != null) {
// print('App opened from a terminated state via notification!');
// // Handle navigation as needed
// }
// }
// }
//
//
// // 🔗 3. Connecting Notifications to Subscriptions
// // This is where you link back to your previous question. Notifications become a powerful tool to manage your user subscription lifecycle.
// //
// // Send Token to Backend: After a user logs in, call a secure API endpoint on your Java backend to store the FCM token you got from getToken() . Associate it with the user's profile in your database.
// //
// // Send Subscription Alerts: When a user successfully purchases a subscription (and your backend confirms it via a Stripe webhook), your Java backend can immediately use the stored FCM token to send a "Purchase Successful" or "Subscription Activated" push notification to that specific device .
// //
// // ✅ 4. Action Plan for Your Project
// // Here’s how you can start implementing this in your app:
// //
// // Start Simple: First, get the firebase_messaging plugin installed and the device token printing to your console. This confirms your setup is correct.
// //
// // Create a Service: Implement a NotificationService class, like in the code example above. This keeps your code organized.
// //
// // Connect to Your Backend: Write the API call to send the FCM token to your Java backend. Also, test sending a message from the Firebase Console to your device using that token.
// //
// // Combine with Subscriptions: Once a user pays, trigger a push notification from your backend. In your Flutter app, listen for that specific notification type and use it to force-refresh the user's subscription cache (as we discussed before), ensuring a seamless and instant upgrade experience.
// //
// // This approach will give you a professional and reliable notification system using the generous free tiers of Firebase, which is a perfect fit for a project just starting out.
// //
// // But i want to give other notifications as well
// // Means daily i would like to give a notification that your today's outfit is ready
// //
// // And there is an option of calendar event
// // For that also
// // Trip plans with date
// // That also
// // On night, that go check your outfit for tomorrow
// //
// // So many other small things
// // Read 10 web pages
// // You're absolutely right to think about all those personalized, daily reminders! The good news is that you don't need a backend for any of these - they're all perfect use cases for local notifications, which work entirely on the user's device, cost nothing, and work even without internet.
// //
// // 🎯 Remote vs. Local: The Right Tool for Each Job
// // Let me clarify the distinction based on your needs:
// //
// // Notification Type	When to Use	Backend Required?	Cost
// // Remote (FCM)	Subscription updates, time-sensitive offers, breaking news	Yes	Free tier available
// // Local	Daily outfit reminders, calendar events, trip plans, nighttime check-ins	No	$0
// // For your specific needs:
// //
// // "Today's outfit is ready" → Local notification (daily schedule)
// //
// // Calendar events → Local notification (scheduled for event time)
// //
// // Trip plans with dates → Local notification (schedule before trip)
// //
// // Nighttime "check tomorrow's outfit" → Local notification (daily at 9 PM)
// //
// // 📱 The Solution: Local Notifications for Everything
// // Local notifications are scheduled and triggered entirely on the user's device . Once you schedule them, your app doesn't need to be running - the device's operating system handles delivery .
// //
// // Recommended Package: flutter_local_notifications
// // This is the most popular and battle-tested package for local notifications :
// //
// // yaml
//
//
//
//
// // import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:timezone/data/latest.dart' as tz;
// // import 'package:timezone/timezone.dart' as tz;
// // import 'package:timezone/timezone.dart';
//
// class NotificationService {
// static final NotificationService _instance = NotificationService._internal();
// factory NotificationService() => _instance;
// NotificationService._internal();
//
// final FlutterLocalNotificationsPlugin _notifications =
// FlutterLocalNotificationsPlugin();
//
// // Call this ONCE when your app starts
// Future<void> initialize() async {
// // Initialize timezone database (critical for scheduled notifications)
// tz.initializeTimeZones();
//
// // Android setup
// const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//
// // iOS setup
// const ios = DarwinInitializationSettings(
// requestAlertPermission: true,
// requestBadgePermission: true,
// requestSoundPermission: true,
// );
//
// const settings = InitializationSettings(android: android, iOS: ios);
//
// await _notifications.initialize(
// settings,
// onDidReceiveNotificationResponse: _onNotificationTap,
// );
// }
//
// // ============================================================
// // SCENARIO 1: Daily outfit reminder (every morning)
// // ============================================================
// Future<void> scheduleDailyOutfitReminder(TimeOfDay time) async {
// await _scheduleDaily(
// id: 1,
// title: "👕 Your Outfit Is Ready!",
// body: "Check out today's personalized outfit recommendation",
// hour: time.hour,
//       minute: time.minute,
//     );
//   }
//   
//   // ============================================================
//   // SCENARIO 2: Calendar event reminder
//   // ============================================================
//   Future<void> scheduleCalendarEvent({
//     required int eventId,
//     required String eventTitle,
//     required DateTime eventTime,
//     int minutesBefore = 15,
//   }) async {
//     final scheduledTime = eventTime.subtract(Duration(minutes: minutesBefore));
//     
//     // Only schedule if it's in the future
//     if (scheduledTime.isAfter(DateTime.now())) {
//       await _scheduleOnce(
//         id: 1000 + eventId,  // Offset to avoid ID conflicts
//         title: "📅 Upcoming Event",
//         body: "$eventTitle starts in $minutesBefore minutes",
//         scheduledDate: scheduledTime,
//       );
//     }
//   }
//   
//   // ============================================================
//   // SCENARIO 3: Trip plan reminder (day before, morning of)
//   // ============================================================
//   Future<void> scheduleTripReminders({
//     required int tripId,
//     required String destination,
//     required DateTime startDate,
//   }) async {
//     // Reminder 1: Day before at 7 PM
//     final dayBefore = startDate.subtract(Duration(days: 1));
//     final eveningReminder = DateTime(
//       dayBefore.year, dayBefore.month, dayBefore.day, 19, 0,
//     );
//     
//     if (eveningReminder.isAfter(DateTime.now())) {
//       await _scheduleOnce(
//         id: 2000 + tripId,
//         title: "✈️ Trip Tomorrow!",
//         body: "Your trip to $destination starts tomorrow. Ready your bags!",
//         scheduledDate: eveningReminder,
//       );
//     }
//     
//     // Reminder 2: Morning of trip at 8 AM
//     const morningOf = DateTime(startDate.year, startDate.month, startDate.day, 8, 0);
//     if (morningOf.isAfter(DateTime.now())) {
//       await _scheduleOnce(
//         id: 3000 + tripId,
//         title: "🧳 Trip Day!",
//         body: "Your trip to $destination starts today. Have a great journey!",
//         scheduledDate: morningOf,
//       );
//     }
//   }
//   
//   // ============================================================
//   // SCENARIO 4: Nighttime reminder to check tomorrow's outfit
//   // ============================================================
//   Future<void> scheduleNighttimeCheck(TimeOfDay time) async {
//     await _scheduleDaily(
//       id: 4,
//       title: "🌙 Plan Tomorrow's Look",
//       body: "Spend 2 minutes picking tomorrow's outfit. Future you will thank you!",
//       hour: time.hour,
//       minute: time.minute,
//     );
//   }
//   
//   // ============================================================
//   // PRIVATE METHODS
//   // ============================================================
//   
//   Future<void> _scheduleDaily({
//     required int id,
//     required String title,
//     required String body,
//     required int hour,
//     required int minute,
//   }) async {
//     final androidDetails = AndroidNotificationDetails(
//       'daily_channel_$id',
//       'Daily Reminders',
//       channelDescription: 'Daily reminders for outfit and planning',
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//     
//     const iosDetails = DarwinNotificationDetails();
//     const details = NotificationDetails(android: androidDetails, iOS: iosDetails);
//     
//     final scheduledTime = tz.TZDateTime(
//       tz.local,
//       DateTime.now().year,
//       DateTime.now().month,
//       DateTime.now().day,
//       hour,
//       minute,
//     );
//     
//     // If scheduled time already passed today, schedule for tomorrow
//     final finalTime = scheduledTime.isBefore(tz.TZDateTime.now(tz.local))
//         ? scheduledTime.add(const Duration(days: 1))
//         : scheduledTime;
//     
//     await _notifications.zonedSchedule(
//       id,
//       title,
//       body,
//       finalTime,
//       details,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,  // Repeats daily
//     );
//   }
//   
//   Future<void> _scheduleOnce({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime scheduledDate,
//   }) async {
//     final androidDetails = AndroidNotificationDetails(
//       'event_channel',
//       'Event Reminders',
//       channelDescription: 'One-time reminders for events and trips',
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//     
//     const iosDetails = DarwinNotificationDetails();
//     const details = NotificationDetails(android: androidDetails, iOS: iosDetails);
//     
//     await _notifications.zonedSchedule(
//       id,
//       title,
//       body,
//       tz.TZDateTime.from(scheduledDate, tz.local),
//       details,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
//   
//   // Handle when user taps a notification
//   void _onNotificationTap(NotificationResponse response) {
//     final payload = response.payload;
//     // Navigate based on notification type
//     // Example: payload contains event ID or screen to navigate to
//   }
//   
//   // Utility: Cancel specific notification
//   Future<void> cancelNotification(int id) async {
//     await _notifications.cancel(id);
//   }
//   
//   // Utility: Cancel all notifications (useful on logout)
//   Future<void> cancelAll() async {
//     await _notifications.cancelAll();
//   }
// }
//
//
//
// 🎯 Using It in Your App
// dart
// // In your app's initialization (main.dart or splash screen)
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await NotificationService().initialize();
//   runApp(MyApp());
// }
//
// // When user enables daily outfit reminders
// void onUserEnablesOutfitReminders() {
//   NotificationService().scheduleDailyOutfitReminder(TimeOfDay(hour: 8, minute: 0));
// }
//
// // When user creates a calendar event
// void onUserCreatesEvent(String title, DateTime time) {
//   NotificationService().scheduleCalendarEvent(
//     eventId: DateTime.now().millisecondsSinceEpoch,
//     eventTitle: title,
//     eventTime: time,
//     minutesBefore: 15,
//   );
// }
//
// // When user books a trip
// void onUserBooksTrip(String destination, DateTime startDate) {
//   NotificationService().scheduleTripReminders(
//     tripId: DateTime.now().millisecondsSinceEpoch,
//     destination: destination,
//     startDate: startDate,
//   );
// }
//
// // When user enables nighttime planning reminder
// void onUserEnablesNightReminder() {
//   NotificationService().scheduleNighttimeCheck(TimeOfDay(hour: 21, minute: 0)); // 9 PM
// }
// 🛠️ Alternative Packages
// While flutter_local_notifications is the most comprehensive , you have other options:
//
// Package	Best For
// awesome_notifications	Rich media (images, buttons, custom layouts)
// custom_notification_scheduler	Simpler API, built-in FCM support
// flutter_local_notifications	Most features, best documentation, most stable
// 📊 Architecture Summary
// Here's how everything fits together:
//
// text
// ┌─────────────────────────────────────────────────────────────┐
// │                      YOUR FLUTTER APP                        │
// ├─────────────────────────────────────────────────────────────┤
// │                                                              │
// │  ┌──────────────────┐        ┌──────────────────────────┐  │
// │  │  REMOTE (FCM)    │        │    LOCAL NOTIFICATIONS   │  │
// │  │  Only for:       │        │    For:                   │  │
// │  │  • Subscription  │        │    • Daily outfit ready   │  │
// │  │    updates       │        │    • Calendar events      │  │
// │  │  • Offers        │        │    • Trip reminders       │  │
// │  │  • Urgent alerts │        │    • Nighttime checks     │  │
// │  └────────┬─────────┘        └───────────┬──────────────┘  │
// │           │                              │                   │
// │           ▼                              ▼                   │
// │  ┌─────────────────────────────────────────────────────┐   │
// │  │              NotificationService                     │   │
// │  │  • initialize()                                      │   │
// │  │  • scheduleDailyOutfitReminder()                    │   │
// │  │  • scheduleCalendarEvent()                          │   │
// │  │  • scheduleTripReminders()                          │   │
// │  │  • scheduleNighttimeCheck()                         │   │
// │  └─────────────────────────────────────────────────────┘   │
// │                              │                               │
// └──────────────────────────────┼───────────────────────────────┘
//                                │
//               ┌────────────────┼────────────────┐
//               ▼                ▼                ▼
//          ┌─────────┐    ┌──────────┐    ┌──────────┐
//          │ Android │    │   iOS    │    │   Web    │
//          │ System  │    │  System  │    │ (limited)│
//          └─────────┘    └──────────┘    └──────────┘
// ✅ Key Takeaways
// No backend needed for daily reminders, calendar events, or trip plans - local notifications handle everything for free
//
// Schedule once, runs forever - Once you schedule a daily notification, the OS handles it every day, even if the app is closed or phone restarts
//
// Zero API cost - All your daily reminders, calendar events, and trip notifications cost nothing to send
//
// Works offline - Users get notifications even without internet
//
// Combine with FCM - Use FCM only for things that truly need a server (like "your subscription just expired" or "flash sale today")
//
// This approach keeps your backend costs minimal while giving users all the rich, personalized reminders they expect from a modern app. Your free backend tier will easily handle the few remote notifications you need, while local notifications handle the volume completely for free.
//
// I dont want user to enable or disable notification in app,
// It should just notify user
// You're right to want a frictionless experience! However, there's an important technical and ethical constraint you need to understand: On both iOS and Android, you cannot send notifications without the user's explicit permission. The operating systems require this for user privacy and to prevent notification spam.
//
// 🔒 The Hard Truth: Permission Is Required by OS
// Both Apple and Google mandate that apps must ask for permission before sending any notifications:
//
// iOS: Shows a native system dialog the first time you try to send a notification. User must tap "Allow"
//
// Android 13+: Same requirement - system dialog with "Allow" or "Don't allow"
//
// You cannot bypass this. Apps that try to get around this get rejected from app stores or removed.
// ✅ The Smart Approach: Ask Once, Automatically
// But here's the good news - you can make this completely seamless by asking for permission at the right moment, with the right context, and never asking again. Most users will say yes.
// Best Practice: Ask During Onboarding
// Instead of giving users a toggle in settings (which you don't want), just ask for permission once when the app first launches or during signup:
// dart
// class OnboardingScreen extends StatelessWidget { @override Widget build(BuildContext context) { return Scaffold( body: Center( child: Column( mainAxisAlignment: MainAxisAlignment.center, children: [ Icon(Icons.notifications_active, size: 80, color: Colors.blue), SizedBox(height: 24), Text( "Stay Updated", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), ), SizedBox(height: 16), Text( "We'll notify you about:\n" "• Your daily outfit recommendations\n" "• Upcoming trips and events\n" "• Nighttime planning reminders\n\n" "You can turn this off anytime in system settings", textAlign: TextAlign.center, ), SizedBox(height: 32), ElevatedButton( onPressed: () async { // Ask for permission ONCE final settings = await FirebaseMessaging.instance.requestPermission(); // User either said yes or no - we never ask again // Continue to app regardless Navigator.pushReplacement( context, MaterialPageRoute(builder: (_) => HomeScreen()), ); }, child: Text("Continue"), ), ], ), ), ); } }
// If User Denies Permission
// If the user denies permission, you still have options:
// 1. Respect their choice - Some users genuinely don't want notifications
// 2. Use in-app messages instead - Show a subtle badge or banner inside the app
// 3. Never ask again - Don't be annoying by repeatedly asking
// dart
// Future<void> requestNotificationPermission() async { final settings = await FirebaseMessaging.instance.requestPermission(); switch (settings.authorizationStatus) { case AuthorizationStatus.authorized: print("✅ User granted permission - we can send notifications"); break; case AuthorizationStatus.denied: print("❌ User denied permission - we won't send notifications"); // Show a gentle explanation once, but don't force _showGentleExplanationOnce(); break; case AuthorizationStatus.notDetermined: print("⚠️ User hasn't decided yet"); break; } } void _showGentleExplanationOnce() { // Show ONE TIME only final hasShown = SharedPreferences.getInstance().then((prefs) { return prefs.getBool('shown_notification_explanation') ?? false; }); if (!hasShown) { showDialog( context: context, builder: (_) => AlertDialog( title: Text("You're missing out!"), content: Text( "We can't send you daily outfit reminders or trip alerts. " "You can enable notifications in your phone's settings anytime." ), actions: [ TextButton( onPressed: () => Navigator.pop(context), child: Text("Got it"), ), ], ), ); // Mark as shown SharedPreferences.getInstance().then((prefs) { prefs.setBool('shown_notification_explanation', true); }); } }
// 🎯 The "No Settings Toggle" Pattern
// You said you don't want users to enable/disable notifications in the app. That's fine! Here's how to implement exactly that:
// dart
// class NotificationService { // This runs automatically when app starts static Future<void> autoSetupNotifications() async { // Request permission silently (system dialog will appear) final settings = await FirebaseMessaging.instance.requestPermission(); // Based on user's choice, either schedule or don't schedule if (settings.authorizationStatus == AuthorizationStatus.authorized) { await scheduleAllNotifications(); // Schedule daily reminders, etc. } // If denied, do nothing - user won't get notifications } // No toggle button anywhere in your app UI // Users who want to change their mind must go to system settings }
// 📱 How Users Can Change Their Mind (Without Your App)
// If a user denies permission initially but later wants notifications, they must go to their phone's system settings. This is by OS design, not your choice.
// For users on iOS/Android:
// 1. Open phone Settings app
// 2. Find your app in the list
// 3. Tap "Notifications"
// 4. Enable "Allow Notifications"
// You cannot provide an in-app toggle that overrides this. Even if you add a button, it just opens the system settings page:
// dart
// // If you REALLY want to help users who change their mind // (This just opens system settings, not a toggle) Future<void> openAppSettings() async { if (Platform.isIOS) { await FirebaseMessaging.instance.openAppSettings(); } else if (Platform.isAndroid) { await FlutterLocalNotificationsPlugin().openAppSettings(); } } // Optional: Add a tiny "Settings" link in your profile screen // This is not a toggle, just a helper to open system settings GestureDetector( onTap: () => openAppSettings(), child: Text("Notification settings", style: TextStyle(fontSize: 12)), )
// 🚀 The Optimal Flow for Your App
// Here's the complete, minimal-friction approach:
// dart
// // In main.dart void main() async { WidgetsFlutterBinding.ensureInitialized(); await Firebase.initializeApp(); // Automatically request permission on app start await NotificationService.autoSetupNotifications(); runApp(MyApp()); } // That's it! No toggles, no settings page, no user decision inside your app. // The system dialog appears once. User says yes/no. Done.
// 📊 What Users Will ExperienceUser Action	Result
// Launches app first time	Sees system permission dialog once
// Taps "Allow"	Gets all notifications automatically
// Taps "Don't Allow"	Gets no notifications (and no annoying prompts ever again)
// Changes mind later	Must go to phone Settings app
//
// ⚠️ Important Note on Ethics
// You should know that trying to send notifications without permission:
// • Is technically impossible on modern iOS/Android
// • Will get your app rejected from App Store/Play Store if you attempt workarounds
// • Damages user trust if you're deceptive about it
// The system permission dialog exists for good reason - users should have control over interruptions. Most users will grant permission if you ask nicely once with a clear value proposition (like "Get your daily outfit recommendations").
// 🎯 Final Recommendation
// 1. Ask once during onboarding with a friendly explanation of what users will get
// 2. No toggle switch anywhere in your app (what you wanted)
// 3. Automatically schedule notifications if user approved
// 4. Do nothing if user denied (don't ask again)
// 5. Optional: Add a small "Open notification settings" link in profile for power users
// This gives you the frictionless experience you want while respecting platform requirements and user choice.






import 'dart:io';
import 'dart:ui';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

/// Notification Service
///
/// Handles all push notification logic including initialization,
/// scheduling, and delivery.
///
/// Features:
/// - Proper Flutter Local Notifications setup
/// - Auto-scheduler for periodic notifications
/// - Notification channels configuration
/// - Error handling
/// - Platform-specific initialization
///
/// Usage:
/// ```dart
/// // Initialize in main()
/// await NotificationService().initializeNotifications();
///
/// // Show test notification
/// await NotificationService().showTestNotification();
///
/// // Start auto scheduler
/// NotificationService().startAutoScheduler(
///   message: "Your message here",
///   intervalInMinutes: 30,
/// );
///
/// // Stop auto scheduler
/// NotificationService().stopAutoScheduler();
/// ```

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

// class NotificationService {
//   /// Singleton instance
//   static final NotificationService _instance = NotificationService._internal();
//
//   /// Flutter Local Notifications plugin instance
//   late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
//
//   /// Track if service is initialized
//   bool _isInitialized = false;
//
//   /// Constructor
//   NotificationService._internal() {
//     _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   }
//
//   /// Factory constructor for singleton
//   factory NotificationService() {
//     return _instance;
//   }
//
//   /// Check if notifications are initialized
//   bool get isInitialized => _isInitialized;
//
//   /// Initialize notifications - MUST be called in main() before runApp()
//   Future<bool> initializeNotifications() async {
//     try {
//       // Initialize timezone database
//       tz_data.initializeTimeZones();
//
//       // Android initialization settings
//       const AndroidInitializationSettings androidInitializationSettings =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//
//       // iOS initialization settings
//       const DarwinInitializationSettings iosInitializationSettings =
//       DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//       );
//
//       // Combined initialization settings
//       const InitializationSettings initializationSettings =
//       InitializationSettings(
//         android: androidInitializationSettings,
//         iOS: iosInitializationSettings,
//       );
//
//       // Initialize the plugin
//       await _flutterLocalNotificationsPlugin.initialize(
//         initializationSettings,
//         onDidReceiveNotificationResponse: _handleNotificationTap,
//       );
//
//       // Request permissions (iOS 13+)
//       await _requestPermissions();
//
//       // Create notification channels (Android)
//       await _createNotificationChannels();
//
//       _isInitialized = true;
//       print('✅ Notification Service Initialized Successfully');
//       return true;
//     } catch (e) {
//       print('❌ Notification Initialization Error: $e');
//       return false;
//     }
//   }
//
//   /// Request notification permissions
//   Future<void> _requestPermissions() async {
//     try {
//       // Android 13+ permission request
//       final androidPlugin =
//       _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>();
//
//       if (androidPlugin != null) {
//         await androidPlugin.requestNotificationsPermission();
//         print('📱 Android notification permissions requested');
//       }
//
//       // iOS permission request
//       final iosPlugin =
//       _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//           IOSFlutterLocalNotificationsPlugin>();
//
//       if (iosPlugin != null) {
//         await iosPlugin.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//         print('📱 iOS notification permissions requested');
//       }
//     } catch (e) {
//       print('⚠️ Permission Request Error: $e');
//     }
//   }
//
//   /// Create notification channels for Android
//   Future<void> _createNotificationChannels() async {
//     try {
//       final androidPlugin =
//       _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>();
//
//       if (androidPlugin != null) {
//         // Default channel
//         await androidPlugin.createNotificationChannel(
//           const AndroidNotificationChannel(
//              'default_channel',
//              'Default Channel',
//             description: 'Default notification channel',
//             importance: Importance.defaultImportance,
//             enableLights: true,
//             enableVibration: true,
//           ),
//         );
//
//         // High priority channel
//         await androidPlugin.createNotificationChannel(
//           const AndroidNotificationChannel(
//              'high_priority_channel',
//              'High Priority Channel',
//             description: 'High priority notification channel',
//             importance: Importance.high,
//             enableLights: true,
//             enableVibration: true,
//             sound: RawResourceAndroidNotificationSound('notification'),
//           ),
//         );
//
//         print('📢 Notification channels created');
//       }
//     } catch (e) {
//       print('⚠️ Channel Creation Error: $e');
//     }
//   }
//
//   /// Handle notification tap
//   void _handleNotificationTap(NotificationResponse notificationResponse) {
//     final String? payload = notificationResponse.payload;
//     print('📥 Notification Tapped: $payload');
//
//     // TODO: Handle notification tap action
//     // Navigate to specific page or perform action
//   }
//
//   /// Show an immediate test notification
//   Future<void> showTestNotification() async {
//     try {
//       if (!_isInitialized) {
//         print('⚠️ Notification Service not initialized');
//         return;
//       }
//
//       const AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails(
//         'default_channel',
//         'Default Channel',
//         channelDescription: 'Default notification channel',
//         importance: Importance.high,
//         priority: Priority.high,
//         enableLights: true,
//         enableVibration: true,
//         showProgress: false,
//         actions: <AndroidNotificationAction>[
//           AndroidNotificationAction(
//             'action_id',
//             'Reply',
//           ),
//         ],
//       );
//
//       const DarwinNotificationDetails iosNotificationDetails =
//       DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//         sound: 'default',
//       );
//
//       const NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails,
//         iOS: iosNotificationDetails,
//       );
//
//       await _flutterLocalNotificationsPlugin.show(
//         0, // Notification ID
//         'Ohh Mittar',
//         'This is a test notification , if you received means youre fucked up',
//         notificationDetails,
//         payload: 'test_payload',
//       );
//
//       print('📤 Test notification sent successfully');
//     } catch (e) {
//       print('❌ Error showing test notification: $e');
//     }
//   }
//
//   /// Show a notification with custom title and message
//   Future<void> showNotification({
//     required String title,
//     required String message,
//     String? payload,
//     int notificationId = 1,
//   }) async {
//     try {
//       if (!_isInitialized) {
//         print('⚠️ Notification Service not initialized');
//         return;
//       }
//
//       final AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails(
//         'default_channel',
//         'Default Channel',
//         channelDescription: 'Default notification channel',
//         importance: Importance.high,
//         priority: Priority.high,
//         enableLights: true,
//         enableVibration: true,
//         color: const Color(0xFF4CAF50),
//       );
//
//       const DarwinNotificationDetails iosNotificationDetails =
//       DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       );
//
//       final NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails,
//         iOS: iosNotificationDetails,
//       );
//
//       await _flutterLocalNotificationsPlugin.show(
//         notificationId,
//         title,
//         message,
//         notificationDetails,
//         payload: payload ?? '',
//       );
//
//       print('📤 Notification sent: $title');
//     } catch (e) {
//       print('❌ Error showing notification: $e');
//     }
//   }
//
//   /// Schedule a notification to show at specific time
//   Future<void> scheduleNotification({
//     required String title,
//     required String message,
//     required DateTime scheduledTime,
//     int notificationId = 2,
//     String? payload,
//   }) async {
//     try {
//       if (!_isInitialized) {
//         print('⚠️ Notification Service not initialized');
//         return;
//       }
//
//       const AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails(
//         'scheduled_channel',
//         'Scheduled Channel',
//         channelDescription: 'Channel for scheduled notifications',
//         importance: Importance.high,
//         priority: Priority.high,
//         enableLights: true,
//         enableVibration: true,
//       );
//
//       const DarwinNotificationDetails iosNotificationDetails =
//       DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       );
//
//       final NotificationDetails notificationDetails = const NotificationDetails(
//         android: androidNotificationDetails,
//         iOS: iosNotificationDetails,
//       );
//
//       final tzDateTime = tz.TZDateTime.from(scheduledTime, tz.local);
//
//       await _flutterLocalNotificationsPlugin.zonedSchedule(
//         notificationId,
//         title,
//         message,
//         tzDateTime,
//         notificationDetails,
//         androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//         payload: payload ?? '',
//       );
//
//       print('⏰ Notification scheduled for: $scheduledTime');
//     } catch (e) {
//       print('❌ Error scheduling notification: $e');
//     }
//   }
//
//   /// Start auto scheduler - shows notification at regular intervals
//   Future<void> startAutoScheduler({
//     required String message,
//     int intervalInMinutes = 2,
//     String title = 'Notification',
//     int notificationId = 10,
//   }) async {
//     try {
//       if (!_isInitialized) {
//         print('⚠️ Notification Service not initialized');
//         return;
//       }
//
//       // Calculate next schedule time (now + interval)
//       final DateTime now = DateTime.now();
//       final DateTime scheduledTime =
//       now.add(Duration(minutes: intervalInMinutes));
//
//       const AndroidNotificationDetails androidNotificationDetails =
//       AndroidNotificationDetails(
//         'scheduled_channel',
//         'Scheduled Channel',
//         channelDescription: 'Channel for auto-scheduled notifications',
//         importance: Importance.high,
//         priority: Priority.high,
//         enableLights: true,
//         enableVibration: true,
//         sound: RawResourceAndroidNotificationSound('notification'),
//       );
//
//       const DarwinNotificationDetails iosNotificationDetails =
//       DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//         sound: 'default',
//       );
//
//       final NotificationDetails notificationDetails = const NotificationDetails(
//         android: androidNotificationDetails,
//         iOS: iosNotificationDetails,
//       );
//
//       // Schedule first notification
//       final tzDateTime = tz.TZDateTime.from(scheduledTime, tz.local);
//
//       await _flutterLocalNotificationsPlugin.zonedSchedule(
//         notificationId,
//         title,
//         message,
//         tzDateTime,
//         notificationDetails,
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time,
//         payload: 'auto_scheduled',
//       );
//
//       print('🔄 Auto scheduler started');
//       print('   • Title: $title');
//       print('   • Message: $message');
//       print('   • Interval: $intervalInMinutes minutes');
//       print('   • First notification: $scheduledTime');
//     } catch (e) {
//       print('❌ Error starting auto scheduler: $e');
//     }
//   }
//
//   /// Stop auto scheduler
//   Future<void> stopAutoScheduler({int notificationId = 10}) async {
//     try {
//       await _flutterLocalNotificationsPlugin.cancel(notificationId);
//       print('⏹️ Auto scheduler stopped');
//     } catch (e) {
//       print('❌ Error stopping auto scheduler: $e');
//     }
//   }
//
//   /// Cancel all notifications
//   Future<void> cancelAllNotifications() async {
//     try {
//       await _flutterLocalNotificationsPlugin.cancelAll();
//       print('🗑️ All notifications canceled');
//     } catch (e) {
//       print('❌ Error canceling notifications: $e');
//     }
//   }
//
//   /// Cancel specific notification
//   Future<void> cancelNotification(int notificationId) async {
//     try {
//       await _flutterLocalNotificationsPlugin.cancel(notificationId);
//       print('🗑️ Notification $notificationId canceled');
//     } catch (e) {
//       print('❌ Error canceling notification: $e');
//     }
//   }
//
//   /// Get pending notifications
//   Future<List<PendingNotificationRequest>> getPendingNotifications() async {
//     try {
//       final pendingNotifications =
//       await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
//       print('📋 Pending notifications: ${pendingNotifications.length}');
//       return pendingNotifications;
//     } catch (e) {
//       print('❌ Error getting pending notifications: $e');
//       return [];
//     }
//   }
// }


import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  static final NotificationService _instance =
  NotificationService._internal();

  factory NotificationService() => _instance;

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  Timer? _timer;

  bool get isInitialized => _initialized;

  // =========================================================
  // INIT NOTIFICATIONS
  // =========================================================
  Future<void> initializeNotifications() async {
    try {
      tz.initializeTimeZones(); // ✅ FIXED

      const androidInit = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );

      const iosInit = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const settings = InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );

      await _plugin.initialize(settings);

      _initialized = true;
    } catch (e) {
      print("❌ Init Error: $e");
    }
  }

  // =========================================================
  // PERMISSIONS (optional call)
  // =========================================================
  Future<void> requestPermissions() async {
    final android =
    _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await android?.requestNotificationsPermission();
  }

  // =========================================================
  // BASIC NOTIFICATION
  // =========================================================
  Future<void> showNotification({
    required String title,
    required String message,
    int id = 0,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'default_channel',
        'Default Channel',
        channelDescription: 'Default notifications',
        importance: Importance.max,
        priority: Priority.high,
      );

      const iosDetails = DarwinNotificationDetails();

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _plugin.show(id, title, message, details);
    } catch (e) {
      print("❌ Show Notification Error: $e");
    }
  }

  // =========================================================
  // TEST NOTIFICATION
  // =========================================================
  Future<void> showTestNotification() async {
    await showNotification(
      title: "Test Notification 👕",
      message: "Agar Notification aa gya means you're FUCKED UP",
      id: 1,
    );
  }

  // =========================================================
  // SCHEDULED NOTIFICATION (ONE TIME)
  // =========================================================
  Future<void> scheduleNotification({
    required String title,
    required String message,
    required DateTime time,
    int id = 2,
  }) async {
    try {
      final tzTime = tz.TZDateTime.from(time, tz.local);

      const androidDetails = AndroidNotificationDetails(
        'scheduled_channel',
        'Scheduled Channel',
        channelDescription: 'Scheduled notifications',
        importance: Importance.high,
        priority: Priority.high,
      );

      const iosDetails = DarwinNotificationDetails();

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _plugin.zonedSchedule(
        id,
        title,
        message,
        tzTime,
        details,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (e) {
      print("❌ Schedule Error: $e");
    }
  }

  // =========================================================
  // START AUTO NOTIFICATION (EVERY 2 MIN OR CUSTOM)
  // =========================================================
  void startAutoScheduler({
    required String title,
    required String message,
    int intervalInMinutes = 2,
    int id = 10,
  }) {
    // stop previous timer
    _timer?.cancel();

    _timer = Timer.periodic(
      Duration(minutes: intervalInMinutes),
          (timer) async {
        await showNotification(
          title: title,
          message: message,
          id: id,
        );
      },
    );

    print("🔄 Auto Scheduler Started ($intervalInMinutes min)");
  }

  // =========================================================
  // STOP AUTO NOTIFICATION
  // =========================================================
  void stopAutoScheduler() {
    _timer?.cancel();
    _timer = null;

    print("⏹️ Auto Scheduler Stopped");
  }

  // =========================================================
  // CANCEL ALL
  // =========================================================
  Future<void> cancelAllNotifications() async {
    await _plugin.cancelAll();
  }

  // =========================================================
  // DISPOSE (optional)
  // =========================================================
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}