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
        'Leads List ',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: leadsController.getLeads,
          ),
        ],
      ),
      body: Obx(() {
        if (leadsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (leadsController.leadsList.isEmpty) {
          return Center(child: Text('No leads available'));
        }

        return ListView.builder(
          itemCount: leadsController.leadsList.length,
          itemBuilder: (context, index) {
            Leads lead = leadsController.leadsList[index];
            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                onTap: (){
                  Get.to(LeadDetails(lead: lead,));
                },
                title: Text(lead.name ?? 'No Name'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Company: ${lead.companyName ?? 'N/A'}"),
                    Text("Email: ${lead.email ?? 'N/A'}"),
                    Text("Service: ${lead.service ?? 'N/A'}"),
                    Text("Project Details: ${lead.projectDetails ?? 'N/A'}"),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
