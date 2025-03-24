import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thakurgaon/model/upazilla_model.dart';
import 'package:thakurgaon/model/union_model.dart';
import '../../provider/app_provider.dart';
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
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    final upazillas = await AppUtils.upazillas();
    setState(() {
      _upazillas = upazillas;
    });

    for (var upazilla in upazillas) {
      final unions = await AppUtils.unions(upazilla.id);
      setState(() {
        _unionsByUpazilla[upazilla.id] = unions;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  List<Upazilla> get _filteredUpazillas {
    if (_searchQuery.isEmpty) {
      return _upazillas;
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
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;

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
              colors: isDarkMode
                  ? [Colors.teal.shade800, Colors.teal.shade900]
                  : [Colors.teal, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              )
            : Column(
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ইউনিয়ন খুঁজুন...',
                        hintStyle: TextStyle(
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                      ),
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      onChanged: (query) {
                        setState(() {
                          _searchQuery = query;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      height: 180,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _upazillas.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 4,
                        ),
                        itemBuilder: (context, index) {
                          final upazilla = _upazillas[index];
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: isDarkMode
                                  ? LinearGradient(
                                      colors: [Colors.teal.shade900, Colors.teal.shade800],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : LinearGradient(
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
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredUpazillas.length,
                      itemBuilder: (context, index) {
                        final upazilla = _filteredUpazillas[index];
                        final unions = _unionsByUpazilla[upazilla.id] ?? [];

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          elevation: isDarkMode ? 0 : 0.5,
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ExpansionTile(
                            title: Text(
                              upazilla.bnName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                              ),
                            ),
                            iconColor: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                            collapsedIconColor: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                            children: unions
                                .where((union) => union.bnName
                                    .toLowerCase()
                                    .contains(_searchQuery.toLowerCase()))
                                .map((union) => ListTile(
                                      leading: Icon(
                                        Icons.pin_drop,
                                        color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                                      ),
                                      title: Text(
                                        '${union.bnName} (${union.name})',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isDarkMode ? Colors.white : Colors.black,
                                        ),
                                      ),
                                      onTap: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '${union.bnName} selected',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            backgroundColor: Colors.teal,
                                          ),
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
      ),
    );
  }
}