import 'package:flutter/material.dart';

import '../model/doctor_model.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/doctor',
          arguments: doctor,
        );
      },
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.only(bottom: 12),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade50, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image
              CircleAvatar(
                radius: 30,
                // backgroundImage: NetworkImage(doctor.image),
                backgroundImage: AssetImage('assets/images/home_screen/doctor.png'),
                child: doctor.image.isEmpty
                    ? Icon(Icons.person, size: 30, color: Colors.teal)
                    : null,
              ),
              SizedBox(width: 16),

              // Doctor Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor Name
                    Text(
                      doctor.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Specialization
                    if (doctor.specialization.isNotEmpty)
                      _buildDetailRow(
                        Icons.medical_services,
                        doctor.specialization.join(", "),
                      ),
                    SizedBox(height: 4),

                    // Qualifications
                    if (doctor.qualifications.isNotEmpty)
                      _buildDetailRow(
                        Icons.school,
                        doctor.qualifications.join(", "),
                      ),
                    SizedBox(height: 4),

                    // Designation and Department
                    _buildDetailRow(
                      Icons.work,
                      '${doctor.designation}, ${doctor.department}',
                    ),
                    SizedBox(height: 4),

                    // Hospital
                    _buildDetailRow(
                      Icons.local_hospital,
                      doctor.hospital,
                    ),
                    SizedBox(height: 4),

                    // Experience
                    _buildDetailRow(
                      Icons.timeline,
                      'অভিজ্ঞতাঃ ${doctor.experience}',
                    ),
                    SizedBox(height: 4),

                    // Consultation Fee
                    _buildDetailRow(
                      Icons.monetization_on,
                      'কনসাল্টেশন ফিঃ ${doctor.consultationFee}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.teal),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}