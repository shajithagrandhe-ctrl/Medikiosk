
import 'package:flutter/material.dart';

import 'ayush_referral_screen.dart';

class AyushTreatmentHistoryScreen extends StatefulWidget {
final String selectedAyushSystem;
final Map<String, dynamic> commonAnswers;
final Map<String, dynamic> specificAnswers;
final String mainHealthConcern;

const AyushTreatmentHistoryScreen({
super.key,
required this.selectedAyushSystem,
required this.commonAnswers,
required this.specificAnswers,
required this.mainHealthConcern,
});

@override
State<AyushTreatmentHistoryScreen> createState() =>
_AyushTreatmentHistoryScreenState();
}

class _AyushTreatmentHistoryScreenState
extends State<AyushTreatmentHistoryScreen> {
int currentQuestionIndex = 0;

final TextEditingController textController =
TextEditingController();

String? selectedAnswer;

final Map<String, dynamic> treatmentAnswers = {};

List<Map<String, dynamic>> get questions {
final List<Map<String, dynamic>> questionList = [
{
'question':
'Have you received treatment for this problem before?',
'type': 'yesno',
'key': 'previousTreatment',
'options': ['Yes', 'No'],
},
];

// Conditional AYUSH treatment questions
if (treatmentAnswers['previousTreatment'] == 'Yes') {
questionList.addAll([
{
'question':
'Have you previously received AYUSH treatment?',
'type': 'yesno',
'key': 'previousAyushTreatment',
'options': ['Yes', 'No'],
},
]);

if (treatmentAnswers['previousAyushTreatment'] == 'Yes') {
questionList.addAll([
{
'question':
'Which AYUSH system was used?',
'type': 'options',
'key': 'previousAyushSystem',
'options': [
'Ayurveda',
'Yoga & Naturopathy',
'Unani',
'Siddha',
'Homoeopathy',
'Sowa-Rigpa',
'Not sure',
],
},
{
'question':
'Are you currently taking any AYUSH medicines?',
'type': 'yesno',
'key': 'currentlyTakingAyushMedicine',
'options': ['Yes', 'No'],
},
]);

if (treatmentAnswers['currentlyTakingAyushMedicine'] ==
'Yes') {
questionList.add({
'question':
'Please provide the medicine details if known.',
'type': 'text',
'key': 'ayushMedicineDetails',
});
}
}

questionList.addAll([
{
'question':
'Have you experienced any improvement from previous treatment?',
'type': 'yesno',
'key': 'improvementFromTreatment',
'options': ['Yes', 'No'],
},
{
'question':
'Have you experienced any unwanted effects from previous treatment?',
'type': 'yesno',
'key': 'unwantedEffects',
'options': ['Yes', 'No'],
},
{
'question':
'Have you received conventional medical treatment for this problem?',
'type': 'yesno',
'key': 'conventionalTreatment',
'options': ['Yes', 'No'],
},
]);
}

questionList.add({
'question':
'Are you currently taking any medicines?',
'type': 'yesno',
'key': 'currentlyTakingMedicines',
'options': ['Yes', 'No'],
});

return questionList;
}

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

void _loadCurrentAnswer() {
final currentQuestions = questions;

if (currentQuestions.isEmpty ||
currentQuestionIndex >= currentQuestions.length) {
return;
}

final question = currentQuestions[currentQuestionIndex];
final key = question['key'];

final savedAnswer = treatmentAnswers[key];

if (question['type'] == 'text') {
textController.text = savedAnswer ?? '';
selectedAnswer = null;
} else {
selectedAnswer = savedAnswer;
textController.clear();
}
}

bool _hasAnswer() {
final currentQuestions = questions;
final question = currentQuestions[currentQuestionIndex];

if (question['type'] == 'text') {
return textController.text.trim().isNotEmpty;
}

return selectedAnswer != null;
}

void _saveAnswer() {
final currentQuestions = questions;
final question = currentQuestions[currentQuestionIndex];

final key = question['key'];

if (question['type'] == 'text') {
treatmentAnswers[key] =
textController.text.trim();
} else {
treatmentAnswers[key] =
selectedAnswer;
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

final currentQuestions = questions;

if (currentQuestionIndex <
currentQuestions.length - 1) {
setState(() {
currentQuestionIndex++;
_loadCurrentAnswer();
});
} else {
_goToReferralScreen();
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

void _goToReferralScreen() {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
AyushReferralScreen(
selectedAyushSystem:
widget.selectedAyushSystem,

commonAnswers:
widget.commonAnswers,

specificAnswers:
widget.specificAnswers,

treatmentAnswers:
treatmentAnswers,

mainHealthConcern:
widget.mainHealthConcern,
),
),
);
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

final currentQuestions = questions;

if (currentQuestionIndex >=
currentQuestions.length) {
currentQuestionIndex =
currentQuestions.length - 1;
}

final question =
currentQuestions[currentQuestionIndex];

final progress =
(currentQuestionIndex + 1) /
currentQuestions.length;

return Scaffold(
appBar: AppBar(
title: const Text('Treatment History'),
),

body: SafeArea(
child: Padding(
padding: const EdgeInsets.all(16),

child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [

Text(
'Selected System: '
'${widget.selectedAyushSystem}',
style: theme
    .textTheme
    .titleMedium
    ?.copyWith(
color:
theme.colorScheme.primary,
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 20),

LinearProgressIndicator(
value: progress,
borderRadius:
BorderRadius.circular(10),
),

const SizedBox(height: 8),

Text(
'Question '
'${currentQuestionIndex + 1} '
'of ${currentQuestions.length}',
style:
theme.textTheme.bodyMedium,
),

const SizedBox(height: 28),

Text(
question['question'],
style: theme
    .textTheme
    .headlineSmall
    ?.copyWith(
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 24),

Expanded(
child: SingleChildScrollView(
child: _buildAnswerInput(
question,
theme,
),
),
),

Row(
children: [

Expanded(
child: OutlinedButton(
onPressed:
_previousQuestion,

style:
OutlinedButton.styleFrom(
minimumSize:
const Size(
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
onPressed:
_nextQuestion,

style:
FilledButton.styleFrom(
minimumSize:
const Size(
double.infinity,
52,
),
),

child: Text(
currentQuestionIndex ==
currentQuestions.length -
1
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
hintText:
'Enter your answer here...',

border: OutlineInputBorder(
borderRadius:
BorderRadius.circular(16),
),
),
);
}

final List<String> options =
List<String>.from(
question['options'],
);

return Column(
children: options.map((option) {
final bool isSelected =
selectedAnswer == option;

return Padding(
padding:
const EdgeInsets.only(
bottom: 12,
),

child: InkWell(
borderRadius:
BorderRadius.circular(16),

onTap: () {
setState(() {
selectedAnswer = option;
});
},

child: AnimatedContainer(
duration:
const Duration(
milliseconds: 200,
),

width: double.infinity,

padding:
const EdgeInsets.all(18),

decoration: BoxDecoration(
color: isSelected
? theme
    .colorScheme
    .primaryContainer
    : theme
    .colorScheme
    .surface,

borderRadius:
BorderRadius.circular(16),

border: Border.all(
color: isSelected
? theme
    .colorScheme
    .primary
    : theme
    .colorScheme
    .outlineVariant,

width:
isSelected ? 2 : 1,
),
),

child: Row(
children: [

Expanded(
child: Text(
option,
style: theme
    .textTheme
    .titleMedium
    ?.copyWith(
fontWeight:
isSelected
? FontWeight.bold
    : FontWeight.normal,
),
),
),

if (isSelected)
Icon(
Icons.check_circle,
color: theme
    .colorScheme
    .primary,
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

