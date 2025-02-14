import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexpro_solution/Controller/login_controller.dart';
import 'package:nexpro_solution/Screens/Home%20Screen/lead_details.dart';
import '../../Controller/leads_controller.dart';
import '../../Model/leads_model.dart';
import '../../Widgets/appbar.dart';
class LeadsScreen extends StatelessWidget {
  final LeadsController leadsController = Get.put(LeadsController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        'Leads List',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: leadsController.getLeads,
          ),
        ],
      ),
      body: Obx(() {
        if (leadsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (leadsController.leadsList.isEmpty) {
          return Center(
            child: Text(
              'No leads available',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          itemCount: leadsController.leadsList.length,
          itemBuilder: (context, index) {
            Leads lead = leadsController.leadsList.reversed.toList()[index];
            return GestureDetector(
              onTap: () {
                Get.to(LeadDetails(lead: lead));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromRGBO(17, 79, 143, 1),
                        child: Text(
                          lead.name?.substring(0, 1) ?? 'N',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lead.name ?? 'No Name',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Email: ${lead.email ?? 'N/A'}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Phone Number: ${lead.mobileNumber ?? 'N/A'}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}