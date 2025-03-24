import 'package:flutter/material.dart';
import '../../model/uddokta_model.dart';
import '../../utils/app_utils.dart';

class UddoktaScreen extends StatefulWidget {
  const UddoktaScreen({super.key});

  @override
  State<UddoktaScreen> createState() => _UddoktaScreenState();
}

class _UddoktaScreenState extends State<UddoktaScreen> {
  List<Uddokta> uddoktas = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      List<Uddokta> data = await AppUtils.loadUddoktas();
      setState(() {
        uddoktas = data;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('উদ্যোক্তা'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: uddoktas.length,
        itemBuilder: (context, index) {
          final uddokta = uddoktas[index];
          return Card(
            elevation: 1,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/uddokta-details',
                  arguments: {'id': uddokta.id},
                );
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.network(
                      uddokta.image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          uddokta.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          uddokta.business,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          uddokta.location,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}