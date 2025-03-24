import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/doctor_model.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({super.key});

  // Method to initiate a phone call
  _makePhoneCall(String phoneNumber, BuildContext context) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('ফোন কল শুরু করা যায়নি।'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ফোন কল শুরু করা যায়নি: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the passed Doctor object
    final Doctor doctor = ModalRoute.of(context)!.settings.arguments as Doctor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          doctor.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade50, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/home_screen/doctor.png'),
                      backgroundColor: Colors.grey[200],
                    ),
                    SizedBox(height: 16),
                    Text(
                      doctor.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                      textAlign: TextAlign.center, // Center text
                    ),
                    SizedBox(height: 8),
                    Text(
                      doctor.designation,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.teal.shade700,
                      ),
                      textAlign: TextAlign.center, // Center text
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(Icons.medical_services, 'বিশেষজ্ঞতা: ${doctor.specialization.join(", ")}'),
                    SizedBox(height: 8),
                    _buildDetailRow(Icons.work, 'পদবী: ${doctor.designation}'),
                    SizedBox(height: 8),
                    _buildDetailRow(Icons.local_hospital, 'হাসপাতাল: ${doctor.hospital}'),
                    SizedBox(height: 8),
                    _buildDetailRow(Icons.school, 'যোগ্যতা: ${doctor.qualifications.join(", ")}'),
                    SizedBox(height: 8),
                    _buildDetailRow(Icons.timeline, 'অভিজ্ঞতা: ${doctor.experience}'),
                    SizedBox(height: 8),
                    _buildDetailRow(Icons.monetization_on, 'কনসাল্টেশন ফি: ${doctor.consultationFee}'),
                    SizedBox(height: 8),
                    _buildDetailRow(Icons.phone, 'যোগাযোগ: ${doctor.contact}', isClickable: true, onTap: () => _makePhoneCall(doctor.contact, context)),
                    SizedBox(height: 8),
                    _buildDetailRow(Icons.email, 'ইমেল: ${doctor.email}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),

            // Chambers Section
            Text(
              'চেম্বার:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 8),
            ...doctor.chambers.map((chamber) => Card(
              elevation: 1,
              margin: EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chamber.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildDetailRow(Icons.location_on, 'ঠিকানা: ${chamber.address}'),
                    SizedBox(height: 8),
                    _buildDetailRow(Icons.phone, 'সিরিয়াল: ${chamber.contact}', isClickable: true, onTap: () => _makePhoneCall(chamber.contact, context)),
                    SizedBox(height: 8),
                    _buildDetailRow(Icons.access_time, 'ভিজিটিং ঘন্টা: ${chamber.visitingHours}'),
                  ],
                ),
              ),
            )),
            SizedBox(height: 12),

            // About Section
            Text(
              'সম্পর্কে:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 4),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  doctor.about,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, {bool isClickable = false, VoidCallback? onTap}) {
    return InkWell(
      onTap: isClickable ? onTap : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.teal),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: isClickable ? Colors.blue : Colors.black87,
                decoration: isClickable ? TextDecoration.underline : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}