// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:thakurgaon/utils/bengali_numerals.dart';
//
// class VideoEarnScreen extends StatefulWidget {
//   const VideoEarnScreen({super.key});
//
//   @override
//   State<VideoEarnScreen> createState() => _VideoEarnScreenState();
// }
//
// class _VideoEarnScreenState extends State<VideoEarnScreen> {
//   // Rewarded Ad
//   RewardedAd? _rewardedAd;
//   bool _isRewardedAdLoaded = false;
//
//   // Coin values for each grid container
//   final List<int> _coinValues = [1, 2, 3, 3, 4, 4, 4, 4, 5, 5];
//
//   // Track which containers have been rewarded
//   final List<bool> _rewardedContainers = List.filled(8, false);
//
//   // Track the current active container index
//   int _activeIndex = 0;
//
//   // Total rewards earned
//   int _totalRewards = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadRewardedAd();
//   }
//
//   // Load a rewarded ad
//   void _loadRewardedAd() {
//     RewardedAd.load(
//       adUnitId: 'ca-app-pub-3940256099942544/5224354917',
//       request: const AdRequest(),
//       rewardedAdLoadCallback: RewardedAdLoadCallback(
//         onAdLoaded: (ad) {
//           setState(() {
//             _rewardedAd = ad;
//             _isRewardedAdLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (error) {
//           print('Failed to load rewarded ad: $error');
//           setState(() {
//             _isRewardedAdLoaded = false;
//           });
//         },
//       ),
//     );
//   }
//
//   // Show the rewarded ad
//   void _showRewardedAd(int index) {
//     if (_rewardedAd == null || !_isRewardedAdLoaded) {
//       print('Rewarded ad not loaded yet.');
//       return;
//     }
//
//     _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdDismissedFullScreenContent: (ad) {
//         ad.dispose();
//         _loadRewardedAd();
//       },
//       onAdFailedToShowFullScreenContent: (ad, error) {
//         ad.dispose();
//         print('Failed to show rewarded ad: $error');
//         _loadRewardedAd();
//       },
//     );
//
//     _rewardedAd!.show(
//       onUserEarnedReward: (ad, reward) {
//         // Handle the reward
//         setState(() {
//           _rewardedContainers[index] = true;
//           _totalRewards += _coinValues[index];
//           _activeIndex = index + 1; // Move to the next container
//         });
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('ভিডিও রিওয়ার্ড কয়েন')),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             Column(
//               children: [
//                 Text('আজকের রিওয়ার্ড জিতেছেন - ${enToBnNumerals(_totalRewards)}', style: const TextStyle()),
//               ],
//             ),
//             const SizedBox(height: 16),
//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 4,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//               ),
//               itemCount: _coinValues.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     if (index == _activeIndex) {
//                       _showRewardedAd(index); // Show the rewarded ad
//                     }
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color:
//                           index <= _activeIndex
//                               ? Colors.blue
//                               : Colors.grey.shade50,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset('assets/images/coin.png', width: 25),
//                         const SizedBox(height: 8),
//                         RichText(
//                           text: TextSpan(
//                             text: '${enToBnNumerals(_coinValues[index])} ',
//                             style: TextStyle(
//                               fontSize: 18,
//                               color:
//                                   index <= _activeIndex
//                                       ? Colors.white
//                                       : Colors.black,
//                               fontFamily: 'kalpurush',
//                             ),
//                             children: [
//                               const TextSpan(
//                                 text: 'কয়েন',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.normal,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 16),
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.blue.shade200, Colors.blue],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(Icons.play_circle, color: Colors.white),
//                   const SizedBox(width: 8),
//                   Text(
//                     'রিওয়ার্ড পেতে ভিডিও দেখুন $_activeIndex/${_coinValues.length}',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _rewardedAd?.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';

class VideoEarnScreen extends StatefulWidget {
  const VideoEarnScreen({super.key});

  @override
  State<VideoEarnScreen> createState() => _VideoEarnScreenState();
}

class _VideoEarnScreenState extends State<VideoEarnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}

