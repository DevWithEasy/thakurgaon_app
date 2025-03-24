import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/job_model.dart';
import '../../utils/app_utils.dart';
import '../../provider/app_provider.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  late Future<List<Job>> futureJobs;

  @override
  void initState() {
    super.initState();
    futureJobs = AppUtils.jobs();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'চাকরি',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Job>>(
        future: futureJobs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'কোনো চাকরি পাওয়া যায়নি।',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            );
          } else {
            final jobs = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/job-details',
                      arguments: job,
                    );
                  },
                  child: Card(
                    elevation: 2,
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Job Title
                          Text(
                            job.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.teal[200] : Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Company Name
                          Text(
                            job.company,
                            style: TextStyle(
                              fontSize: 16,
                              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Location and Deadline
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: isDarkMode ? Colors.teal[200] : Colors.teal,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    job.location,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'ডেডলাইন: ${job.deadline}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Salary
                          Row(
                            children: [
                              Icon(
                                Icons.attach_money,
                                size: 16,
                                color: isDarkMode ? Colors.teal[200] : Colors.teal,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                job.salary,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.teal[200] : Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}