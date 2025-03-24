import 'package:flutter/material.dart';
import 'package:thakurgaon/model/upazilla_model.dart';
import 'package:thakurgaon/model/union_model.dart';
import '../../utils/app_utils.dart';

class AreasScreen extends StatefulWidget {
  const AreasScreen({super.key});

  @override
  State<AreasScreen> createState() => _AreasScreenState();
}

class _AreasScreenState extends State<AreasScreen> {
  List<Upazilla> _upazillas = [];
  final Map<int, List<Union>> _unionsByUpazilla = {};
  bool _isLoading = true;
  String _searchQuery = ''; // Search query

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    // Load upazillas
    final upazillas = await AppUtils.upazillas();
    setState(() {
      _upazillas = upazillas;
    });

    // Load unions for each upazilla
    for (var upazilla in upazillas) {
      final unions = await AppUtils.unions(upazilla.id);
      setState(() {
        _unionsByUpazilla[upazilla.id] = unions; // Store unions by upazilla ID
      });
    }

    setState(() {
      _isLoading = false; // Hide loading indicator
    });
  }

  // Filtered upazillas based on search query
  List<Upazilla> get _filteredUpazillas {
    if (_searchQuery.isEmpty) {
      return _upazillas; // Return all upazillas if no search query
    }
    return _upazillas.where((upazilla) {
      final nameMatches = upazilla.bnName.toLowerCase().contains(_searchQuery.toLowerCase());
      final unionsMatch = _unionsByUpazilla[upazilla.id]?.any((union) =>
          union.bnName.toLowerCase().contains(_searchQuery.toLowerCase())) ??
          false;
      return nameMatches || unionsMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'উপজেলা ও ইউনিয়ন',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ইউনিয়ন খুঁজুন...',
                      prefixIcon: const Icon(Icons.search, color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.teal),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.teal, width: 2),
                      ),
                      filled: true,
                fillColor: Colors.teal.shade50,
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.teal),
                              onPressed: () {
                                setState(() {
                                  _searchQuery = '';
                                });
                              },
                            )
                          : null,
                    ),
                    onChanged: (query) {
                      setState(() {
                        _searchQuery = query; // Update search query
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 180, // Fixed height for the grid
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _upazillas.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 items per row
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 4, // Adjust aspect ratio for text height
                      ),
                      itemBuilder: (context, index) {
                        final upazilla = _upazillas[index];
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.teal.shade100, Colors.teal.shade50],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(
                            upazilla.bnName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Scrollable List View for Filtered Results
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredUpazillas.length,
                    itemBuilder: (context, index) {
                      final upazilla = _filteredUpazillas[index];
                      final unions = _unionsByUpazilla[upazilla.id] ?? [];

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 0.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ExpansionTile(
                          title: Text(
                            upazilla.bnName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          children: unions
                              .where((union) =>
                                  union.bnName.toLowerCase().contains(_searchQuery.toLowerCase()))
                              .map((union) => ListTile(
                                    leading: const Icon(Icons.pin_drop, color: Colors.teal),
                                    title: Text(
                                      '${union.bnName} (${union.name})',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('${union.bnName} selected')),
                                      );
                                    },
                                  ))
                              .toList(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}