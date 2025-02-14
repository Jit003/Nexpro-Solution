import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import '../Api Services/api_helper.dart';
import '../Model/leads_model.dart';
import '../Services/notification_services.dart';
import 'package:url_launcher/url_launcher.dart';

class LeadsController extends GetxController {
  var isLoading = false.obs;
  var leadsList = <Leads>[].obs;
  var previousLeadsCount = 0.obs;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    super.onInit();
    getLeads(); // Fetch leads initially
    _startPolling(); // Start polling API for updates
    _setupFCM(); // Initialize Firebase Cloud Messaging
  }

  /// Fetch Leads from API and Show Notification if New Leads Come
  Future<void> getLeads() async {
    isLoading.value = true;
    LeadsModel? response = await ApiHelper.fetchLeads();

    if (response != null && response.leads != null) {
      int newLeadsCount = response.leads!.length - previousLeadsCount.value;

      if (newLeadsCount > 0) {
        // ✅ Show notification when new leads arrive
        NotificationService.showNotification(
          "New Leads Available",
          "$newLeadsCount new leads have been received!",
        );
      }

      previousLeadsCount.value = response.leads!.length;
      leadsList.value = response.leads!;
    } else {
      Get.snackbar("Error", "Failed to fetch leads");
    }

    isLoading.value = false;
  }

  /// Start polling API every 5 minutes
  void _startPolling() {
    Timer.periodic(Duration(minutes: 5), (timer) {
      getLeads();
    });
  }

  /// Set up Firebase Cloud Messaging (FCM)
  void _setupFCM() async {
    // Request permission
    NotificationSettings settings = await _firebaseMessaging.requestPermission();
    print("FCM Permission: ${settings.authorizationStatus}");

    // Get FCM Token (Print & Send to Backend)
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    // Subscribe to topic (for mass notifications)
    _firebaseMessaging.subscribeToTopic("leads");

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        NotificationService.showNotification(
          message.notification!.title ?? "New Update",
          message.notification!.body ?? "Check your leads!",
        );
      }
    });

    // Handle background notifications (Click event)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("User clicked on a notification!");
    });
  }
  /// Make a phone call
  Future<void> makeCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: "tel", path: phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      Get.snackbar("Error", "Could not launch call",);
    }
  }
}
