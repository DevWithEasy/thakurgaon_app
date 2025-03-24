import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/tourist_place_model.dart';
import '../../provider/app_provider.dart';
import '../../utils/app_utils.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  List<TouristPlace> _places = [];
  List<TouristPlace> _filteredPlaces = [];
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    final places = await AppUtils.touristPlaces();
    setState(() {
      _places = places;
      _filteredPlaces = places;
      _isLoading = false;
    });
  }

  void _filterPlaces(String query) {
    setState(() {
      _filteredPlaces = _places
          .where((place) =>
              place.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'দর্শনীয় স্থান',
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
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'স্থান খুঁজুন...',
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
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                        ),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _filterPlaces('');
                          });
                        },
                      )
                    : null,
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              onChanged: _filterPlaces,
            ),
          ),

          // Grid View for Tourist Places
          Expanded(
            child: Container(
              color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                      ),
                    )
                  : _filteredPlaces.isEmpty
                      ? Center(
                          child: Text(
                            'কোন স্থান পাওয়া যায়নি',
                            style: TextStyle(
                              fontSize: 18,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        )
                      : GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                            childAspectRatio: 0.75,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _filteredPlaces.length,
                          itemBuilder: (context, index) {
                            final place = _filteredPlaces[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/place',
                                  arguments: {
                                    'index': index,
                                    'places': _filteredPlaces
                                  },
                                );
                              },
                              child: Hero(
                                tag: '${place.name}_${place.image}',
                                child: Card(
                                  elevation: isDarkMode ? 0 : 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Place Image
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(12),
                                        ),
                                        child: Image.asset(
                                          place.image,
                                          height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                      // Place Name
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          place.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: isDarkMode
                                                ? Colors.teal.shade200
                                                : Colors.teal,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),

                                      // Place Description
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          place.description,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: isDarkMode
                                                ? Colors.grey[300]
                                                : Colors.grey[700],
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}