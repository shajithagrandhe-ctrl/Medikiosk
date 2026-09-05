import 'package:flutter/material.dart';
import 'medical_history_screen.dart';

class SymptomQuestionScreen extends StatefulWidget {
  final String chiefComplaint;

  const SymptomQuestionScreen({
    super.key,
    required this.chiefComplaint,
  });

  @override
  State<SymptomQuestionScreen> createState() =>
      _SymptomQuestionScreenState();
}

class _SymptomQuestionScreenState extends State<SymptomQuestionScreen> {
  int currentQuestionIndex = 0;

  final Map<String, dynamic> answers = {};

  late List<QuestionData> questions;

  @override
  void initState() {
    super.initState();
    questions = getQuestions(widget.chiefComplaint);
  }

  List<QuestionData> getQuestions(String complaint) {
    switch (complaint) {
      case 'Pain':
        return [
          QuestionData(
            question: 'Where is the pain located?',
            type: QuestionType.text,
          ),
          QuestionData(
            question: 'How long have you had the pain?',
            type: QuestionType.text,
          ),
          QuestionData(
            question: 'How would you describe the pain?',
            type: QuestionType.options,
            options: [
              'Sharp',
              'Burning',
              'Pressure',
              'Dull',
            ],
          ),
          QuestionData(
            question: 'How severe is the pain?',
            type: QuestionType.slider,
          ),
          QuestionData(
            question: 'Does the pain spread to another area?',
            type: QuestionType.options,
            options: [
              'Yes',
              'No',
            ],
          ),
          QuestionData(
            question: 'Does anything make the pain worse?',
            type: QuestionType.options,
            options: [
              'Walking',
              'Breathing',
              'Eating',
              'Nothing',
            ],
          ),
        ];

      case 'Fever':
        return [
          QuestionData(
            question: 'How long have you had fever?',
            type: QuestionType.options,
            options: [
              'Less than 1 day',
              '1–3 days',
              'More than 3 days',
            ],
          ),
          QuestionData(
            question: 'Do you have chills?',
            type: QuestionType.options,
            options: [
              'Yes',
              'No',
            ],
          ),
          QuestionData(
            question: 'Do you have body pain?',
            type: QuestionType.options,
            options: [
              'Yes',
              'No',
            ],
          ),
          QuestionData(
            question: 'Do you have cough?',
            type: QuestionType.options,
            options: [
              'Yes',
              'No',
            ],
          ),
        ];

      case 'Breathing Problem':
        return [
          QuestionData(
            question: 'When did the breathing problem start?',
            type: QuestionType.options,
            options: [
              'Suddenly',
              'Gradually',
            ],
          ),
          QuestionData(
            question: 'Do you have chest pain?',
            type: QuestionType.options,
            options: [
              'Yes',
              'No',
            ],
          ),
          QuestionData(
            question: 'Is breathing difficult while resting?',
            type: QuestionType.options,
            options: [
              'Yes',
              'No',
            ],
          ),
        ];

      default:
        return [
          QuestionData(
            question: 'Please describe your symptoms.',
            type: QuestionType.text,
          ),
        ];
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MedicalHistoryScreen(),
        ),
      );
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final QuestionData currentQuestion =
    questions[currentQuestionIndex];

    final double progress =
        (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Health Questions'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'Question ${currentQuestionIndex + 1} of ${questions.length}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),

              const SizedBox(height: 40),

              Expanded(
                child: SingleChildScrollView(
                  child: _buildQuestion(currentQuestion),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: previousQuestion,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 56),
                      ),
                      child: const Text(
                        'BACK',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: FilledButton(
                      onPressed: nextQuestion,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 56),
                      ),
                      child: Text(
                        currentQuestionIndex == questions.length - 1
                            ? 'CONTINUE'
                            : 'NEXT',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(QuestionData question) {
    if (question.type == QuestionType.text) {
      return _TextQuestion(
        question: question.question,
        initialValue: answers[question.question] ?? '',
        onChanged: (value) {
          answers[question.question] = value;
        },
      );
    }

    if (question.type == QuestionType.options) {
      return _OptionQuestion(
        question: question.question,
        options: question.options ?? [],
        selectedValue: answers[question.question],
        onSelected: (value) {
          setState(() {
            answers[question.question] = value;
          });
        },
      );
    }

    if (question.type == QuestionType.slider) {
      return _SliderQuestion(
        question: question.question,
        value: answers[question.question] ?? 5.0,
        onChanged: (value) {
          setState(() {
            answers[question.question] = value;
          });
        },
      );
    }

    return const SizedBox();
  }
}

enum QuestionType {
  text,
  options,
  slider,
}

class QuestionData {
  final String question;
  final QuestionType type;
  final List<String>? options;

  QuestionData({
    required this.question,
    required this.type,
    this.options,
  });
}

class _TextQuestion extends StatelessWidget {
  final String question;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _TextQuestion({
    required this.question,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          question,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 24),

        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          maxLines: 3,
          style: const TextStyle(fontSize: 18),
          decoration: const InputDecoration(
            hintText: 'Enter your answer',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

class _OptionQuestion extends StatelessWidget {
  final String question;
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String> onSelected;

  const _OptionQuestion({
    required this.question,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          question,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 24),

        ...options.map(
              (option) {
            final bool isSelected = selectedValue == option;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Material(
                color: isSelected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  onTap: () {
                    onSelected(option);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outlineVariant,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            option,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color:
                            Theme.of(context).colorScheme.primary,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SliderQuestion extends StatelessWidget {
  final String question;
  final double value;
  final ValueChanged<double> onChanged;

  const _SliderQuestion({
    required this.question,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          question,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 30),

        Center(
          child: Text(
            value.toInt().toString(),
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),

        const SizedBox(height: 16),

        Slider(
          value: value,
          min: 1,
          max: 10,
          divisions: 9,
          label: value.toInt().toString(),
          onChanged: onChanged,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('1\nMild', textAlign: TextAlign.center),
            Text('10\nSevere', textAlign: TextAlign.center),
          ],
        ),
      ],
    );
  }
}