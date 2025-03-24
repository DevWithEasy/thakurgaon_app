import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/doctor_model.dart';
import '../../provider/app_provider.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/doctor',
          arguments: doctor,
        );
      },
      child: Card(
        elevation: isDarkMode ? 0 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.only(bottom: 12),
        color: isDarkMode ? Colors.grey[800] : null,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: isDarkMode
                ? LinearGradient(
                    colors: [Colors.grey.shade900.withOpacity(0.3), Colors.grey[800]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
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
                backgroundColor: isDarkMode ? Colors.teal.shade800 : Colors.teal.shade50,
                backgroundImage: doctor.image.isNotEmpty
                    ? NetworkImage(doctor.image)
                    : AssetImage('assets/images/home_screen/doctor.png') as ImageProvider,
                child: doctor.image.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 30,
                      )
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
                        color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Specialization
                    if (doctor.specialization.isNotEmpty)
                      _buildDetailRow(
                        Icons.medical_services,
                        doctor.specialization.join(", "),
                        isDarkMode,
                      ),
                    SizedBox(height: 4),

                    // Qualifications
                    if (doctor.qualifications.isNotEmpty)
                      _buildDetailRow(
                        Icons.school,
                        doctor.qualifications.join(", "),
                        isDarkMode,
                      ),
                    SizedBox(height: 4),

                    // Designation and Department
                    _buildDetailRow(
                      Icons.work,
                      '${doctor.designation}, ${doctor.department}',
                      isDarkMode,
                    ),
                    SizedBox(height: 4),

                    // Hospital
                    _buildDetailRow(
                      Icons.local_hospital,
                      doctor.hospital,
                      isDarkMode,
                    ),
                    SizedBox(height: 4),

                    // Experience
                    _buildDetailRow(
                      Icons.timeline,
                      'অভিজ্ঞতাঃ ${doctor.experience}',
                      isDarkMode,
                    ),
                    SizedBox(height: 4),

                    // Consultation Fee
                    _buildDetailRow(
                      Icons.monetization_on,
                      'কনসাল্টেশন ফিঃ ${doctor.consultationFee}',
                      isDarkMode,
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

  Widget _buildDetailRow(IconData icon, String text, bool isDarkMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[300] : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}