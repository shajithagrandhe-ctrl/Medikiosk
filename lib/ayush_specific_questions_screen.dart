

import 'package:flutter/material.dart';

import 'ayush_treatment_history_screen.dart';

class AyushSpecificQuestionsScreen extends StatefulWidget {
final String selectedAyushSystem;
final Map<String, dynamic> collectedAnswers;
final String mainHealthConcern;

const AyushSpecificQuestionsScreen({
super.key,
required this.selectedAyushSystem,
required this.collectedAnswers,
required this.mainHealthConcern,
});

@override
State<AyushSpecificQuestionsScreen> createState() =>
_AyushSpecificQuestionsScreenState();
}

class _AyushSpecificQuestionsScreenState
extends State<AyushSpecificQuestionsScreen> {
int currentQuestionIndex = 0;

final TextEditingController textController =
TextEditingController();

String? selectedAnswer;

final Map<String, dynamic> specificAnswers = {};

@override
void initState() {
super.initState();
_loadCurrentAnswer();
}

@override
void dispose() {
textController.dispose();
super.dispose();
}

List<Map<String, dynamic>> get questions {
switch (widget.selectedAyushSystem) {

case 'Ayurveda':
return [
{
'question':
'How would you describe your natural body type? (Prakriti)',
'type': 'options',
'key': 'prakriti',
'options': [
'Lean or light build',
'Medium build',
'Broad or heavy build',
'A combination',
'Not sure',
],
},
{
'question':
'Have you noticed any recent changes in your usual body condition? (Vikriti)',
'type': 'text',
'key': 'vikriti',
},
{
'question':
'How is your digestive capacity? (Agni)',
'type': 'options',
'key': 'agni',
'options': [
'Good and regular',
'Sometimes irregular',
'Often weak',
'Very variable',
],
},
{
'question':
'How would you describe your usual bowel nature? (Koshtha)',
'type': 'options',
'key': 'koshtha',
'options': [
'Usually regular',
'Usually hard or constipated',
'Usually soft or loose',
'Changes frequently',
],
},
{
'question':
'How would you describe your usual diet? (Ahara)',
'type': 'text',
'key': 'ahara',
},
{
'question':
'How would you describe your daily lifestyle and activities? (Vihara)',
'type': 'text',
'key': 'vihara',
},
{
'question':
'How would you describe your sleep? (Nidra)',
'type': 'options',
'key': 'nidra',
'options': [
'Good and refreshing',
'Average',
'Disturbed',
'Poor',
],
},
];

case 'Yoga & Naturopathy':
return [
{
'question':
'How physically active are you in your daily life?',
'type': 'options',
'key': 'physicalActivity',
'options': [
'Very active',
'Moderately active',
'Low activity',
'Mostly inactive',
],
},
{
'question':
'Do you practice yoga regularly?',
'type': 'yesno',
'key': 'yogaPractice',
'options': ['Yes', 'No'],
},
{
'question':
'Do you practice breathing exercises?',
'type': 'yesno',
'key': 'breathingPractice',
'options': ['Yes', 'No'],
},
{
'question':
'How would you describe your current stress level?',
'type': 'options',
'key': 'stress',
'options': [
'Low',
'Moderate',
'High',
'Very high',
],
},
{
'question':
'How is your sleep?',
'type': 'options',
'key': 'sleep',
'options': [
'Good',
'Average',
'Disturbed',
'Poor',
],
},
{
'question':
'How would you describe your usual diet?',
'type': 'text',
'key': 'diet',
},
{
'question':
'How much water do you usually drink in a day?',
'type': 'options',
'key': 'waterIntake',
'options': [
'Less than 4 glasses',
'4 to 6 glasses',
'7 to 8 glasses',
'More than 8 glasses',
],
},
{
'question':
'Do you follow any natural lifestyle practices?',
'type': 'text',
'key': 'naturalLifestyle',
},
];

case 'Unani':
return [
{
'question':
'How would you describe your general body constitution?',
'type': 'options',
'key': 'bodyConstitution',
'options': [
'Lean',
'Medium build',
'Broad build',
'Not sure',
],
},
{
'question':
'How would you describe your usual body tendencies? (Mizaj)',
'type': 'options',
'key': 'mizaj',
'options': [
'I usually feel warm',
'I usually feel cold',
'I usually feel balanced',
'Not sure',
],
},
{
'question':
'How would you describe your usual diet?',
'type': 'text',
'key': 'diet',
},
{
'question':
'How is your sleep?',
'type': 'options',
'key': 'sleep',
'options': [
'Good',
'Average',
'Disturbed',
'Poor',
],
},
{
'question':
'How physically active are you?',
'type': 'options',
'key': 'physicalActivity',
'options': [
'Very active',
'Moderately active',
'Low activity',
'Mostly inactive',
],
},
{
'question':
'How would you describe your general wellbeing?',
'type': 'text',
'key': 'generalWellbeing',
},
];

case 'Siddha':
return [
{
'question':
'How would you describe your general body constitution?',
'type': 'options',
'key': 'bodyConstitution',
'options': [
'Lean',
'Medium build',
'Broad build',
'Not sure',
],
},
{
'question':
'How would you describe your usual diet? (Unavu)',
'type': 'text',
'key': 'diet',
},
{
'question':
'How would you describe your daily lifestyle? (Vazhkai Murai)',
'type': 'text',
'key': 'lifestyle',
},
{
'question':
'How is your sleep?',
'type': 'options',
'key': 'sleep',
'options': [
'Good',
'Average',
'Disturbed',
'Poor',
],
},
{
'question':
'How are your bowel habits?',
'type': 'options',
'key': 'bowelHabits',
'options': [
'Regular',
'Sometimes irregular',
'Frequently irregular',
'Often constipated',
],
},
{
'question':
'How would you describe your general wellbeing?',
'type': 'text',
'key': 'generalWellbeing',
},
];

case 'Homoeopathy':
return [
{
'question':
'How would you describe the nature of your symptoms?',
'type': 'text',
'key': 'natureOfSymptoms',
},
{
'question':
'What makes your symptoms worse?',
'type': 'text',
'key': 'worseFactors',
},
{
'question':
'What makes your symptoms better?',
'type': 'text',
'key': 'betterFactors',
},
{
'question':
'How sensitive are you to temperature?',
'type': 'options',
'key': 'temperatureSensitivity',
'options': [
'I feel cold easily',
'I feel hot easily',
'Both hot and cold bother me',
'No major sensitivity',
],
},
{
'question':
'How is your sleep?',
'type': 'options',
'key': 'sleep',
'options': [
'Good',
'Average',
'Disturbed',
'Poor',
],
},
{
'question':
'How is your appetite?',
'type': 'options',
'key': 'appetite',
'options': [
'Good',
'Average',
'Poor',
'Changes frequently',
],
},
{
'question':
'How would you describe your thirst?',
'type': 'options',
'key': 'thirst',
'options': [
'I drink very little',
'Normal',
'I feel thirsty often',
'Not sure',
],
},
{
'question':
'How would you describe your emotional wellbeing?',
'type': 'text',
'key': 'emotionalWellbeing',
},
];

case 'Sowa-Rigpa':
return [
{
'question':
'How would you describe your general wellbeing?',
'type': 'text',
'key': 'generalWellbeing',
},
{
'question':
'How is your usual energy level?',
'type': 'options',
'key': 'energyLevel',
'options': [
'High',
'Moderate',
'Low',
'Very low',
],
},
{
'question':
'How is your digestion?',
'type': 'options',
'key': 'digestion',
'options': [
'Good',
'Average',
'Poor',
'Frequently uncomfortable',
],
},
{
'question':
'How is your sleep?',
'type': 'options',
'key': 'sleep',
'options': [
'Good',
'Average',
'Disturbed',
'Poor',
],
},
{
'question':
'How would you describe your daily lifestyle?',
'type': 'text',
'key': 'dailyLifestyle',
},
{
'question':
'How would you describe your emotional wellbeing?',
'type': 'text',
'key': 'emotionalWellbeing',
},
];

default:
return [];
}
}

void _loadCurrentAnswer() {
if (questions.isEmpty) return;

final question = questions[currentQuestionIndex];
final key = question['key'];
final savedAnswer = specificAnswers[key];

if (question['type'] == 'text') {
textController.text = savedAnswer ?? '';
selectedAnswer = null;
} else {
selectedAnswer = savedAnswer;
textController.clear();
}
}

bool _hasAnswer() {
if (questions.isEmpty) return false;

final question = questions[currentQuestionIndex];

if (question['type'] == 'text') {
return textController.text.trim().isNotEmpty;
}

return selectedAnswer != null;
}

void _saveAnswer() {
final question = questions[currentQuestionIndex];
final key = question['key'];

if (question['type'] == 'text') {
specificAnswers[key] = textController.text.trim();
} else {
specificAnswers[key] = selectedAnswer;
}
}

void _nextQuestion() {
if (!_hasAnswer()) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'Please answer the question before continuing.',
),
),
);
return;
}

_saveAnswer();

if (currentQuestionIndex < questions.length - 1) {
setState(() {
currentQuestionIndex++;
_loadCurrentAnswer();
});
} else {
_goToTreatmentHistory();
}
}

void _previousQuestion() {
if (currentQuestionIndex == 0) {
Navigator.pop(context);
return;
}

_saveAnswer();

setState(() {
currentQuestionIndex--;
_loadCurrentAnswer();
});
}

void _goToTreatmentHistory() {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
AyushTreatmentHistoryScreen(
selectedAyushSystem: widget.selectedAyushSystem,
commonAnswers: widget.collectedAnswers,
specificAnswers: specificAnswers,
mainHealthConcern: widget.mainHealthConcern,
),
),
);
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

if (questions.isEmpty) {
return Scaffold(
appBar: AppBar(
title: const Text('AYUSH Health Assessment'),
),
body: const Center(
child: Text('No questions available.'),
),
);
}

final question = questions[currentQuestionIndex];

final progress =
(currentQuestionIndex + 1) / questions.length;

return Scaffold(
appBar: AppBar(
title: const Text('AYUSH Health Assessment'),
),

body: SafeArea(
child: Padding(
padding: const EdgeInsets.all(16),

child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

Text(
'Selected System: ${widget.selectedAyushSystem}',
style: theme.textTheme.titleMedium?.copyWith(
color: theme.colorScheme.primary,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 20),

LinearProgressIndicator(
value: progress,
borderRadius: BorderRadius.circular(10),
),

const SizedBox(height: 8),

Text(
'Question ${currentQuestionIndex + 1} '
'of ${questions.length}',
style: theme.textTheme.bodyMedium,
),

const SizedBox(height: 28),

Text(
question['question'],
style: theme.textTheme.headlineSmall?.copyWith(
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 24),

Expanded(
child: SingleChildScrollView(
child: _buildAnswerInput(question, theme),
),
),

Row(
children: [

Expanded(
child: OutlinedButton(
onPressed: _previousQuestion,
style: OutlinedButton.styleFrom(
minimumSize: const Size(
double.infinity,
52,
),
),
child: Text(
currentQuestionIndex == 0
? 'BACK'
    : 'PREVIOUS',
),
),
),

const SizedBox(width: 12),

Expanded(
child: FilledButton(
onPressed: _nextQuestion,
style: FilledButton.styleFrom(
minimumSize: const Size(
double.infinity,
52,
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
],
),
),
),
);
}

Widget _buildAnswerInput(
Map<String, dynamic> question,
ThemeData theme,
) {
if (question['type'] == 'text') {
return TextField(
controller: textController,
maxLines: 5,
decoration: InputDecoration(
hintText: 'Enter your answer here...',
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
),
),
);
}

final List<String> options =
List<String>.from(question['options']);

return Column(
children: options.map((option) {
final isSelected = selectedAnswer == option;

return Padding(
padding: const EdgeInsets.only(bottom: 12),

child: InkWell(
borderRadius: BorderRadius.circular(16),

onTap: () {
setState(() {
selectedAnswer = option;
});
},

child: AnimatedContainer(
duration: const Duration(milliseconds: 200),

width: double.infinity,

padding: const EdgeInsets.all(18),

decoration: BoxDecoration(
color: isSelected
? theme.colorScheme.primaryContainer
    : theme.colorScheme.surface,

borderRadius: BorderRadius.circular(16),

border: Border.all(
color: isSelected
? theme.colorScheme.primary
    : theme.colorScheme.outlineVariant,
width: isSelected ? 2 : 1,
),
),

child: Row(
children: [

Expanded(
child: Text(
option,
style: theme.textTheme.titleMedium?.copyWith(
fontWeight: isSelected
? FontWeight.bold
    : FontWeight.normal,
),
),
),

if (isSelected)
Icon(
Icons.check_circle,
color: theme.colorScheme.primary,
),
],
),
),
),
);
}).toList(),
);
}
}

