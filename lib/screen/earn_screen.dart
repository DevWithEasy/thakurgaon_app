import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class EarnScreen extends StatefulWidget {
  const EarnScreen({super.key});

  @override
  State<EarnScreen> createState() => _EarnScreenState();
}

class _EarnScreenState extends State<EarnScreen> {
  final List<Map<String, String>> _list = [
    {
      "title": "সাপ্তাহিক কুইজ",
      "route": "/quiz",
      "image": "assets/images/home_screen/quiz_reward.png",
      "description":
          "সপ্তাহে প্রতি শুক্রবার সাপ্তাহিক কুইজের হবে যাতে সকল ইউজার অংশগ্রহনে করে সবোর্চ্চ ৩ জন জিতে নিবেন মোবাইল রিচার্জ। ",
    },
    {
      "title": "কয়েন জিতুন লটারি কিনুন",
      "route": "/video-earn",
      "image": "assets/images/home_screen/learn_earn.png",
      "description":
          "ভিডিও দেখে রিওয়ার্ড কয়েন জিতুন এবং কয়েন দিয়ে লটারি কিনুন অথবা কয়েন দিয়ে রিচার্জ জিতুন",
    },
    {
      "title": "অ্যাপে অবদান",
      "route": "/contributor",
      "image": "assets/images/home_screen/contributor.png",
      "description":
          " অ্যাপসে তথ্য ভান্ডার সহায়ক হিসাবে কন্ট্রিবিউশনের মাধ্যমে মোবাইল রিচার্জ নিন। যা আপনার সম্মাননা হিসাবে গন্য করা হবে।",
    },
    {
      "title": "মাসিক লটারি",
      "route": "/monthly-reward",
      "image": "assets/images/home_screen/raffle.png",
      "description":
          "সকল ব্যবহারিদের জন্য প্রতিমাসের পহেলা তারিখে একটি লটারি আয়োজন করা হবে। লটারি নাম্বার ইউজার আইডি গন্য করা হবে।",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    final bgColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    final cardColor = isDarkMode ? Colors.grey[800]! : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.grey[400]! : const Color(0xFF6D6D6D);
    final borderColor = isDarkMode ? Colors.grey[700]! : Colors.black12;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor, width: 0.5),
                boxShadow: isDarkMode ? null : [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 0.5,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Text(
                'অ্যাপসের সকল ব্যবহারকারিদের জন্য অ্যাপসের পক্ষ থেকে আমরা চেষ্টা করেছি ছোট পরিসরে কিছু উপহার দেওয়ার ব্যবস্থা।\n✅ আপনাকে উপহার হিসাবে আপনার রেজিস্টার মোবাইল নাম্বারে রিচার্জ দেওয়া হবে।\n⚠️ কোন নগদ অর্থ প্রদান করা হবেনা।',
                style: TextStyle(color: textColor),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _list.length,
              itemBuilder: (context, itemIndex) {
                final item = _list[itemIndex];
                return GestureDetector(
                  onTap: () {
                    if (item['route'] != null) {
                      Navigator.pushNamed(context, item['route']!);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: borderColor, width: 0.5),
                      boxShadow: isDarkMode ? null : [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          blurRadius: 0.5,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              item['image']!,
                              height: 25,
                              width: 25,
                              color: isDarkMode ? Colors.white : null,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              item['title']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item['description']!,
                          style: TextStyle(color: secondaryTextColor),
                        ),
                      ],
                    ),
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