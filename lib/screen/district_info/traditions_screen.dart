import 'package:flutter/material.dart';
import '../../model/Info_model.dart';
import '../../utils/app_utils.dart';

class TraditionsScreen extends StatefulWidget {
  const TraditionsScreen({super.key});

  @override
  State<TraditionsScreen> createState() => _TraditionsScreenState();
}

class _TraditionsScreenState extends State<TraditionsScreen> {
  List<Info> _traditions = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final traditions = await AppUtils.traditions();
    setState(() {
      _traditions = traditions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'জেলার ঐতিহ্য',
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Image
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/village_scene.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'নদী মেখলা প্রকৃতি দুলালী এই বাংলাদেশে সংস্কৃতি ও জীবনধারার সাথে লোক সংস্কৃতি অবিচ্ছেদ্য। আজ অত্যাধুনিক বিজ্ঞানের যুগে সভ্যতার চরম বিকাশ হওয়ার সাথে সাথে বাংলার পল্লী জীবনের জীবনযাত্রা পদ্ধতিতে, আচার-অনুষ্ঠানেও পরিবর্তনের হাওয়া লেগেছে। কিন্তু এতদসত্বেও তা একেবারে বিলুপ্ত হয়ে যায়নি। এই দেশ কৃষির- এই দেশ কৃষকের। তারই প্রতিফলন রয়েছে ঠাকুরগাঁও-এর পরতে পরতে। এখানে দিনান্তে শ্রান্ত ক্লান্ত কৃষকের ঘরের দাওয়ায় মাদুর পেতে বসে কেরোসিনের বাতি জ্বালিয়ে সোনাভানের পুঁথি কিংবা দেওয়ান ভাবনার পালাপাঠের আসর বসে। লোকসাহিত্য, লোকনৃত্য, ভাটিয়ালি, ভাওয়াইয়া, বাউল মুর্শিদি, মারফতী, কবিগান, যাত্রা, জারী, কীর্তন, পালাগান ইত্যাদি সকল ক্ষেত্রে ঠাকুরগাঁওয়ের লোকসংস্কৃতির অবদান রয়েছে। সমগ্র দেশের লোকসংস্কৃতির মধ্যে একটা সামঞ্জস্য থাকলেও ভৌগোলিক পরিবেশের কারণে অঞ্চল ভেদে এখানে এর ভিন্নতা লক্ষ করা যায়।',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontFamily: 'kalpurush',
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 16),

            // Traditions List
            ListView.builder(
              itemCount: _traditions.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final tradition = _traditions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 0.2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    title: Text(
                      tradition.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Colors.teal,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/tradition',
                        arguments: {'index': index, 'traditions': _traditions},
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}