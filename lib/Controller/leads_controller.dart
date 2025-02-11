import 'package:get/get.dart';
import '../Api Services/api_helper.dart';
import '../Model/leads_model.dart';
import '../Services/notification_services.dart';

class LeadsController extends GetxController {
  var isLoading = false.obs;
  var leadsList = <Leads>[].obs; // Using the Leads model list
  var previousLeadsCount = 0.obs; // Track previous number of leads


  @override
  void onInit() {
    // TODO: implement onInit
    getLeads();
    super.onInit();
  }

  /// Fetch Leads from API
  /// Fetch Leads from API and Show Notification if New Leads Come
  Future<void> getLeads() async {
    isLoading.value = true;
    LeadsModel? response = await ApiHelper.fetchLeads();

    if (response != null && response.leads != null) {
      int newLeadsCount = response.leads!.length - previousLeadsCount.value;

      if (newLeadsCount > 0) {
        // Send device notification
        NotificationService.showNotification(
          "New Leads Available",
          "$newLeadsCount new leads have been received!",
        );
      }

      // Update the previous lead count and the list
      previousLeadsCount.value = response.leads!.length;
      leadsList.value = response.leads!;
    } else {
      Get.snackbar("Error", "Failed to fetch leads");
    }

    isLoading.value = false;
  }}
