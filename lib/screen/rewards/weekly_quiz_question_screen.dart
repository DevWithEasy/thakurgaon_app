import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thakurgaon/utils/bengali_numerals.dart';
import '../../provider/app_provider.dart';

class WeeklyQuizQuestionScreen extends StatefulWidget {
  const WeeklyQuizQuestionScreen({super.key});

  @override
  State<WeeklyQuizQuestionScreen> createState() =>
      _WeeklyQuizQuestionScreenState();
}

class _WeeklyQuizQuestionScreenState extends State<WeeklyQuizQuestionScreen> {
  final List<Map<String, dynamic>> _questions =  [
    {
      "question": "ফ্রান্সের রাজধানী কোনটি?",
      "options": ["প্যারিস", "লন্ডন", "বার্লিন", "মাদ্রিদ"],
      "answer": "প্যারিস",
    },
    {
      "question": "কোন গ্রহটি লাল গ্রহ নামে পরিচিত?",
      "options": ["পৃথিবী", "মঙ্গল", "বৃহস্পতি", "শনি"],
      "answer": "মঙ্গল",
    },
    {
      "question": "রোমিও অ্যান্ড জুলিয়েট কে লিখেছেন?",
      "options": [
        "উইলিয়াম শেক্সপিয়র",
        "চার্লস ডিকেন্স",
        "মার্ক টোয়েন",
        "জেন অস্টেন",
      ],
      "answer": "উইলিয়াম শেক্সপিয়র",
    },
    {
      "question": "কোন দেশটি 'উদীয়মান সূর্যের দেশ' নামে পরিচিত?",
      "options": ["চীন", "জাপান", "ভারত", "কোরিয়া"],
      "answer": "জাপান",
    },
    {
      "question": "কোন মহাসাগরটি বিশ্বের বৃহত্তম?",
      "options": [
        "আটলান্টিক মহাসাগর",
        "ভারত মহাসাগর",
        "প্রশান্ত মহাসাগর",
        "আর্কটিক মহাসাগর",
      ],
      "answer": "প্রশান্ত মহাসাগর",
    },
    {
      "question": "কে আপেক্ষিকতার তত্ত্ব আবিষ্কার করেন?",
      "options": [
        "আইজ্যাক নিউটন",
        "আলবার্ট আইনস্টাইন",
        "গ্যালিলিও গ্যালিলি",
        "স্টিফেন হকিং",
      ],
      "answer": "আলবার্ট আইনস্টাইন",
    },
    {
      "question": "কোন প্রাণীটি 'মরুভূমির জাহাজ' নামে পরিচিত?",
      "options": ["ঘোড়া", "উট", "গাধা", "হাতি"],
      "answer": "উট",
    },
    {
      "question": "কোন শহরটি 'সাত পাহাড়ের শহর' নামে পরিচিত?",
      "options": ["প্যারিস", "রোম", "লন্ডন", "এথেন্স"],
      "answer": "রোম",
    },
  ];

  int _currentQuestionIndex = 0;
  final List<String?> _userAnswers = [];
  int _score = 0;
  Timer? _questionTimer;
  int _timeLeftForQuestion = 10;
  bool _quizStarted = false;
  bool _quizCompleted = false;

  @override
  void initState() {
    super.initState();
    _userAnswers.addAll(List.filled(_questions.length, null));
  }

  @override
  void dispose() {
    _questionTimer?.cancel();
    super.dispose();
  }

  void _onOptionSelected(String option) {
    if (_userAnswers[_currentQuestionIndex] != null) return;
    
    setState(() {
      _userAnswers[_currentQuestionIndex] = option;
    });

    _questionTimer?.cancel();
    Timer(const Duration(seconds: 1), _nextQuestion);
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _timeLeftForQuestion = 10;
        _startQuestionTimer();
      });
    } else {
      _completeQuiz();
    }
  }

  void _startQuestionTimer() {
    _questionTimer?.cancel();
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeftForQuestion > 0) {
          _timeLeftForQuestion--;
        } else {
          _questionTimer?.cancel();
          _nextQuestion();
        }
      });
    });
  }

  void _calculateScore() {
    _score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_userAnswers[i] == _questions[i]['answer']) {
        _score++;
      }
    }
  }

  void _completeQuiz() {
    _calculateScore();
    _questionTimer?.cancel();
    setState(() {
      _quizCompleted = true;
    });
  }

  void _cancelQuiz() {
    _completeQuiz();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    final themeColor = isDarkMode ? Colors.teal[200]! : Colors.teal;
    final bgColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    final cardColor = isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;

    if (!_quizStarted) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('সাপ্তাহিক কুইজ', style: TextStyle(color: Colors.white)),
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
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'গেমের নিয়মাবলী',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '১. আপনার কাছে প্রতিটি প্রশ্নের জন্য ১০ সেকেন্ড সময় থাকবে।\n'
                '২. প্রতিটি প্রশ্নের জন্য একটি উত্তর নির্বাচন করুন।\n'
                '৩. ভুল উত্তরের জন্য কোনো নেগেটিভ মার্কিং নেই।\n'
                '৪. আপনি একটি উত্তর একটবারই বাচাই করতে পারবেন। বাছাই করার পর পুনরায় বাছাইয়ের সুযোগ থাকবে না\n'
                '৫. সময় শেষ হওয়ার আগে সবগুলো প্রশ্নের উত্তর দিন।',
                style: TextStyle(fontSize: 16, color: secondaryTextColor),
              ),
              const SizedBox(height: 16),
              Text(
                'বিজয়ী নির্ধারন',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '১. সর্বোচ্চ সঠিক উত্তর দাতা বিজয়ী বলে ঘোষিত হবে।\n'
                '২. সমান স্কোর হলে লটারির মাধ্যমে বিজয়ী নির্ধারন।\n'
                '৩. বিজয়ী ৩ জন পাবে মোবাইল রিচার্জ যথাক্রমে (৩০,২০,২০) টাকা।',
                style: TextStyle(fontSize: 16, color: secondaryTextColor),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _quizStarted = true;
                    _startQuestionTimer();
                  });
                },
                icon: const Icon(Icons.play_arrow, color: Colors.white),
                label: const Text('শুরু করুন', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_quizCompleted) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('আপনার কুইজের রেজাল্ট', style: TextStyle(color: Colors.white)),
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
        backgroundColor: bgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'কুইজ সম্পন্ন হয়েছে!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: themeColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'আপনার স্কোর ${enToBnNumerals(_score)} এর মধ্যে ${enToBnNumerals(_questions.length)}',
                style: TextStyle(fontSize: 20, color: secondaryTextColor),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/quiz-dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('ড্যাশবোর্ডে ফিরে যান', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    final correctAnswer = currentQuestion['answer'];
    final selectedAnswer = _userAnswers[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('সাপ্তাহিক কুইজের প্রশ্ন', style: TextStyle(color: Colors.white)),
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
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'সময় বাকি: ${enToBnNumerals(_timeLeftForQuestion)} সেকেন্ড',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                ),
                Text(
                  'প্রশ্ন ${enToBnNumerals(_currentQuestionIndex + 1)}/${enToBnNumerals(_questions.length)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              currentQuestion['question'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion['options'].length,
                itemBuilder: (context, index) {
                  final option = currentQuestion['options'][index];
                  final isSelected = selectedAnswer == option;
                  final isCorrect = option == correctAnswer;

                  Color backgroundColor = cardColor;
                  Color optionTextColor = textColor;
                  
                  if (isSelected) {
                    backgroundColor = isCorrect ? Colors.green : Colors.red;
                    optionTextColor = Colors.white;
                  }

                  return GestureDetector(
                    onTap: () => _onOptionSelected(option),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isDarkMode ? null : [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(fontSize: 16, color: optionTextColor),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              isCorrect ? Icons.check_circle : Icons.cancel,
                              color: optionTextColor,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _cancelQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('কুইজ বাতিল করুন', style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                minimumSize: const Size(double.infinity, 50),
              ),
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              label: Text(
                _currentQuestionIndex == _questions.length - 1 ? 'শেষ করুন' : 'পরবর্তী প্রশ্ন',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}