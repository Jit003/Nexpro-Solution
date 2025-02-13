import 'package:flutter/material.dart';
import 'package:nexpro_solution/Widgets/appbar.dart';
import '../../Model/leads_model.dart';

class LeadDetails extends StatelessWidget {
  final Leads lead; // Receive lead data

  LeadDetails({required this.lead});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('${lead.name}'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Card
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.orangeAccent,
                          child: Text(
                            lead.name?.substring(0, 1) ?? "N",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          lead.name ?? 'N/A',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          lead.companyName ?? 'N/A',
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Details Section
              _buildDetailItem(Icons.email, "Email", lead.email),
              _buildDetailItem(Icons.work, "Service", lead.service),
              _buildDetailItem(Icons.info, "Project Details", lead.projectDetails),
              _buildDetailItem(Icons.calendar_today, "Created At", lead.createdAt),
              _buildDetailItem(Icons.update, "Updated At", lead.updatedAt),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add future action here (e.g., Call or Email)
        },
        backgroundColor: Colors.orangeAccent,
        child: IconButton(onPressed: (){
        },
            icon: Icon(Icons.call,color: Colors.white,)),
      ),
    );
  }

  /// Widget for each detail row with icon
  Widget _buildDetailItem(IconData icon, String label, String? value) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(value ?? 'N/A', style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
