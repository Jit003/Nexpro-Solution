import 'package:flutter/material.dart';
import 'package:nexpro_solution/Widgets/appbar.dart';
import '../../Controller/leads_controller.dart';
import '../../Model/leads_model.dart';
import 'package:get/get.dart';

class LeadDetails extends StatelessWidget {
  final Leads lead; // Receive lead data
  final LeadsController leadsController = Get.put(LeadsController());


  LeadDetails({required this.lead});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        '${lead.name}',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Card with Gradient
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Text(
                          lead.name?.substring(0, 1) ?? "N",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        lead.name ?? 'N/A',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        lead.companyName ?? 'N/A',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Details Section with Animated Cards
              _buildDetailItem(Icons.email, "Email", lead.email),
              _buildDetailItem(Icons.phone, "Phone Number", lead.mobileNumber),
              _buildDetailItem(Icons.work, "Service", lead.service),
              _buildDetailItem(
                  Icons.info, "Project Details", lead.projectDetails),
              _buildDetailItem(
                  Icons.calendar_today, "Created At", lead.createdAt),
              _buildDetailItem(Icons.update, "Updated At", lead.updatedAt),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => leadsController.makeCall(lead.mobileNumber ?? ''),
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.call, color: Colors.white),
        elevation: 5,
      ),
    );
  }

  /// Widget for each detail row with icon and animation
  Widget _buildDetailItem(IconData icon, String label, String? value) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.deepPurple),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.deepPurple,
          ),
        ),
        subtitle: Text(
          value ?? 'N/A',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }
}
