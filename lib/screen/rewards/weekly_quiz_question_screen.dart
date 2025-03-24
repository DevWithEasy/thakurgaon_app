import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thakurgaon/utils/bengali_numerals.dart';

class WeeklyQuizQuestionScreen extends StatefulWidget {
  const WeeklyQuizQuestionScreen({super.key});

  @override
  State<WeeklyQuizQuestionScreen> createState() =>
      _WeeklyQuizQuestionScreenState();
}

class _WeeklyQuizQuestionScreenState extends State<WeeklyQuizQuestionScreen> {
  // List of questions and answers
  final List<Map<String, dynamic>> _questions = [
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

  // Track the current question index
  int _currentQuestionIndex = 0;

  // Track the user's selected answers
  final List<String?> _userAnswers = [];

  // Track the user's score
  int _score = 0;

  // Timer variables
  Timer? _questionTimer;
  int _timeLeftForQuestion = 10; // 10 seconds per question

  // Track if the quiz has started
  bool _quizStarted = false;

  // Track if the quiz is completed
  bool _quizCompleted = false;

  @override
  void initState() {
    super.initState();
    // Initialize user answers list
    _userAnswers.addAll(List.filled(_questions.length, null));
  }

  @override
  void dispose() {
    _questionTimer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Handle option selection (only allow one selection per question)
  void _onOptionSelected(String option) {
    if (_userAnswers[_currentQuestionIndex] != null) {
      // If an answer is already selected, do nothing
      return;
    }
    setState(() {
      _userAnswers[_currentQuestionIndex] = option;
    });

    // Cancel the current question timer
    _questionTimer?.cancel();

    // Automatically move to the next question after 1 second
    Timer(const Duration(seconds: 1), () {
      _nextQuestion();
    });
  }

  // Navigate to the next question
  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _timeLeftForQuestion = 10; // Reset the timer for the next question
        _startQuestionTimer(); // Start the timer for the next question
      });
    } else {
      _completeQuiz(); // Complete the quiz if it's the last question
    }
  }

  // Start the timer for the current question
  void _startQuestionTimer() {
    _questionTimer?.cancel(); // Cancel any existing timer
    _questionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeftForQuestion > 0) {
          _timeLeftForQuestion--;
        } else {
          _questionTimer?.cancel(); // Stop the timer
          _nextQuestion(); // Move to the next question
        }
      });
    });
  }

  // Calculate the user's score
  void _calculateScore() {
    _score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_userAnswers[i] == _questions[i]['answer']) {
        _score++;
      }
    }
  }

  // Complete the quiz
  void _completeQuiz() {
    _calculateScore();
    _questionTimer?.cancel(); // Ensure the timer is stopped
    setState(() {
      _quizCompleted = true; // Mark the quiz as completed
    });
  }

  // Cancel the quiz and complete it immediately
  void _cancelQuiz() {
    _completeQuiz(); // Complete the quiz with the current answers
  }

  @override
  Widget build(BuildContext context) {
    if (!_quizStarted) {
      // Show the "Start Quiz" button and rules initially
      return Scaffold(
        appBar: AppBar(
          title: const Text('সাপ্তাহিক কুইজ'),
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rules Section
              Text(
                'গেমের নিয়মাবলী',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '১. আপনার কাছে প্রতিটি প্রশ্নের জন্য ১০ সেকেন্ড সময় থাকবে।\n'
                '২. প্রতিটি প্রশ্নের জন্য একটি উত্তর নির্বাচন করুন।\n'
                '৩. ভুল উত্তরের জন্য কোনো নেগেটিভ মার্কিং নেই।\n'
                '৪. আপনি একটি উত্তর একটবারই বাচাই করতে পারবেন। বাছাই করার পর পুনরায় বাছাইয়ের সুযোগ থাকবে না\n'
                '৫. সময় শেষ হওয়ার আগে সবগুলো প্রশ্নের উত্তর দিন।',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
              Text(
                'বিজয়ী নির্ধারন',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '১. সর্বোচ্চ সঠিক উত্তর দাতা বিজয়ী বলে ঘোষিত হবে।\n'
                '২. সমান স্কোর হলে লটারির মাধ্যমে বিজয়ী নির্ধারন।\n'
                '৩. বিজয়ী ৩ জন পাবে মোবাইল রিচার্জ যথাক্রমে (৩০,২০,২০) টাকা।',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 24),

              // Start Quiz Button
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _quizStarted = true;
                    _startQuestionTimer(); // Start the timer for the first question
                  });
                },
                icon: const Icon(Icons.play_arrow, color: Colors.white),
                label: const Text(
                  'শুরু করুন',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
          title: const Text('আপনার কুইজের রেজাল্ট'),
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'কুইজ সম্পন্ন হয়েছে!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'আপনার স্কোর ${enToBnNumerals(_score)} এর মধ্যে ${enToBnNumerals(_questions.length)}',
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/quiz-dashboard');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'ড্যাশবোর্ডে ফিরে যান',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
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
        title: const Text('সাপ্তাহিক কুইজের প্রশ্ন'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Timer display
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'সময় বাকি: ${enToBnNumerals(_timeLeftForQuestion)} সেকেন্ড',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                Text(
                  'প্রশ্ন ${enToBnNumerals(_currentQuestionIndex + 1)}/${enToBnNumerals(_questions.length)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Question text
            Text(
              currentQuestion['question'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),

            // Options
            Expanded(
              child: ListView.builder(
                itemCount: currentQuestion['options'].length,
                itemBuilder: (context, index) {
                  final option = currentQuestion['options'][index];
                  final isSelected = selectedAnswer == option;
                  final isCorrect = option == correctAnswer;

                  // Determine the color based on selection and correctness
                  Color backgroundColor = Colors.grey[200]!;
                  Color textColor = Colors.black;
                  if (isSelected) {
                    if (isCorrect) {
                      backgroundColor = Colors.green;
                      textColor = Colors.white;
                    } else {
                      backgroundColor = Colors.red;
                      textColor = Colors.white;
                    }
                  }

                  return GestureDetector(
                    onTap: () => _onOptionSelected(option),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                      )],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(fontSize: 16, color: textColor),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              isCorrect ? Icons.check_circle : Icons.cancel,
                              color: textColor,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const Spacer(),

            // Cancel Button
            ElevatedButton(
              onPressed: _cancelQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'কুইজ বাতিল করুন',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            const SizedBox(height: 10),

            // Next button (full width with icon)
            ElevatedButton.icon(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              label: Text(
                _currentQuestionIndex == _questions.length - 1
                    ? 'শেষ করুন'
                    : 'পরবর্তী প্রশ্ন',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}