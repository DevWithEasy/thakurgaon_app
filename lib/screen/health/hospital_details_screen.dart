import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thakurgaon/model/doctor_model.dart';
import 'package:thakurgaon/model/hospital_model.dart';
import 'package:thakurgaon/utils/app_utils.dart';
import '../../components/doctor_card.dart';
import '../../provider/app_provider.dart';

class HospitalDetailsScreen extends StatefulWidget {
  const HospitalDetailsScreen({super.key});

  @override
  State<HospitalDetailsScreen> createState() => _HospitalDetailsScreenState();
}

class _HospitalDetailsScreenState extends State<HospitalDetailsScreen> {
  late Hospital _hospital;
  List<Doctor> _doctors = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is Hospital) {
      _hospital = args;
      _loadDoctors();
    }
  }

  Future<void> _loadDoctors() async {
    final allDoctors = await AppUtils.doctors();
    setState(() {
      _doctors = allDoctors
          .where((doctor) => _hospital.doctors.contains(doctor.id))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _hospital.name,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [Colors.teal.shade800, Colors.teal.shade900]
                  : [Colors.teal, Colors.teal.shade700],
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
      body: Container(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hospital Details Card
              Card(
                elevation: isDarkMode ? 0 : 1,
                color: isDarkMode ? Colors.grey[800] : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _hospital.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildDetailRow(
                        Icons.location_on, 
                        _hospital.address,
                        isDarkMode,
                      ),
                      SizedBox(height: 8),
                      _buildDetailRow(
                        Icons.phone, 
                        _hospital.contact.join(", "),
                        isDarkMode,
                      ),
                      SizedBox(height: 8),
                      _buildDetailRow(
                        Icons.email, 
                        _hospital.email,
                        isDarkMode,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Doctors Section
              Text(
                'ডাক্তারগণ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                ),
              ),
              SizedBox(height: 12),
              _doctors.isEmpty
                  ? Center(
                      child: Text(
                        "কোন ডাক্তার খুঁজে পাওয়া যায়নি।",
                        style: TextStyle(
                          fontSize: 16, 
                          color: isDarkMode ? Colors.grey[400] : Colors.grey,
                        ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _doctors.length,
                      separatorBuilder: (context, index) => SizedBox(height: 2),
                      itemBuilder: (context, index) {
                        final doctor = _doctors[index];
                        return DoctorCard(doctor: doctor);
                      },
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
          size: 20, 
          color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.grey[300] : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}