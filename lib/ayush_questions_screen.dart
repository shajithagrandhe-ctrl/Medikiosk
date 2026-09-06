import 'package:flutter/material.dart';
import 'red_flag_screen.dart';

class AyushQuestionsScreen extends StatefulWidget {
  final String selectedAyushSystem;

  const AyushQuestionsScreen({super.key,
    required this.selectedAyushSystem,
  });

  @override
  State<AyushQuestionsScreen> createState() =>
      _AyushQuestionsScreenState();
}

class _AyushQuestionsScreenState
    extends State<AyushQuestionsScreen> {

  int currentQuestionIndex = 0;

  final TextEditingController complaintController =
  TextEditingController();

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is your main health concern?',
      'type': 'text',
    },
    {
      'question': 'How long have you had this problem?',
      'type': 'options',
      'options': [
        'Less than 1 day',
        '1–7 days',
        '1–4 weeks',
        'More than 1 month',
      ],
    },
    {
      'question': 'How would you describe your body type?',
      'type': 'options',
      'options': [
        'Thin and lean',
        'Medium build',
        'Broad or heavy build',
        'Not sure',
      ],
    },
    {
      'question': 'How is your digestion (Agni)?',
      'type': 'options',
      'options': [
        'Strong and regular',
        'Irregular',
        'Slow',
        'Weak',
      ],
    },
    {
      'question': 'How are your bowel habits (Koshtha)?',
      'type': 'options',
      'options': [
        'Regular',
        'Usually constipated',
        'Usually loose',
        'Irregular',
      ],
    },
    {
      'question': 'How is your appetite?',
      'type': 'options',
      'options': [
        'Good',
        'Very strong',
        'Low',
        'Irregular',
      ],
    },
    {
      'question': 'How many meals do you usually eat per day?',
      'type': 'options',
      'options': [
        '1–2 meals',
        '3 meals',
        'More than 3 meals',
      ],
    },
    {
      'question': 'What type of food do you usually eat?',
      'type': 'options',
      'options': [
        'Vegetarian',
        'Non-vegetarian',
        'Mixed',
      ],
    },
    {
      'question': 'How often do you eat outside food?',
      'type': 'options',
      'options': [
        'Rarely',
        'Sometimes',
        'Frequently',
        'Almost daily',
      ],
    },
    {
      'question': 'How would you describe your physical activity?',
      'type': 'options',
      'options': [
        'Low',
        'Moderate',
        'High',
      ],
    },
    {
      'question': 'How is your sleep (Nidra)?',
      'type': 'options',
      'options': [
        'Good and refreshing',
        'Light sleep',
        'Disturbed sleep',
        'Poor sleep',
      ],
    },
    {
      'question': 'How many hours do you usually sleep?',
      'type': 'options',
      'options': [
        'Less than 5 hours',
        '5–6 hours',
        '7–8 hours',
        'More than 8 hours',
      ],
    },
    {
      'question': 'How is your urination?',
      'type': 'options',
      'options': [
        'Normal',
        'Frequent',
        'Less frequent',
        'Pain or discomfort',
      ],
    },
    {
      'question': 'How often do you pass stools?',
      'type': 'options',
      'options': [
        'Once daily',
        'More than once daily',
        'Once every 2 days',
        'Irregular',
      ],
    },
    {
      'question': 'Do you experience excessive thirst?',
      'type': 'yesno',
    },
    {
      'question': 'Do you experience excessive sweating?',
      'type': 'yesno',
    },
    {
      'question': 'Do you often feel tired or weak?',
      'type': 'yesno',
    },
    {
      'question':
      'Have you taken Ayurvedic treatment previously?',
      'type': 'yesno',
    },
  ];

  final Map<int, String> answers = {};

  void nextQuestion() {
    if (questions[currentQuestionIndex]['type'] == 'text') {
      if (complaintController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please enter your main health concern.',
            ),
          ),
        );
        return;
      }

      answers[currentQuestionIndex] =
          complaintController.text.trim();
    } else {
      if (answers[currentQuestionIndex] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please select an answer.',
            ),
          ),
        );
        return;
      }
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      goToNextScreen();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void goToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RedFlagScreen(
          chiefComplaint: answers[0] ?? '',
        ),
      ),
    );
  }

  @override
  void dispose() {
    complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    final progress =
        (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AYUSH Case-Taking',
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              LinearProgressIndicator(
                value: progress,
              ),

              const SizedBox(height: 12),

              Text(
                'Question ${currentQuestionIndex + 1} '
                    'of ${questions.length}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),

              const SizedBox(height: 30),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        currentQuestion['question'],
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 30),

                      if (currentQuestion['type'] ==
                          'text')
                        TextField(
                          controller: complaintController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText:
                            'Describe your health concern...',
                            border:
                            OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                        ),

                      if (currentQuestion['type'] ==
                          'options')
                        ...buildOptionCards(
                          currentQuestion['options'],
                        ),

                      if (currentQuestion['type'] ==
                          'yesno')
                        ...buildOptionCards([
                          'Yes',
                          'No',
                        ]),
                    ],
                  ),
                ),
              ),

              Row(
                children: [

                  if (currentQuestionIndex > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: previousQuestion,

                        style:
                        OutlinedButton.styleFrom(
                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),

                        child: const Text('BACK'),
                      ),
                    ),

                  if (currentQuestionIndex > 0)
                    const SizedBox(width: 16),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: nextQuestion,

                      style:
                      ElevatedButton.styleFrom(
                        padding:
                        const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),

                      child: Text(
                        currentQuestionIndex ==
                            questions.length - 1
                            ? 'CONTINUE'
                            : 'NEXT',
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Text(
                'Responses are collected for '
                    'practitioner assessment.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildOptionCards(
      List<dynamic> options) {

    return options.map((option) {

      final isSelected =
          answers[currentQuestionIndex] == option;

      return Padding(
        padding: const EdgeInsets.only(
          bottom: 12,
        ),

        child: InkWell(
          onTap: () {
            setState(() {
              answers[currentQuestionIndex] = option;
            });
          },

          borderRadius:
          BorderRadius.circular(12),

          child: Container(
            width: double.infinity,

            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(12),

              border: Border.all(
                color: isSelected
                    ? Theme.of(context)
                    .colorScheme
                    .primary
                    : Colors.grey,
                width: isSelected ? 2 : 1,
              ),

              color: isSelected
                  ? Theme.of(context)
                  .colorScheme
                  .primaryContainer
                  : null,
            ),

            child: Text(
              option.toString(),

              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}