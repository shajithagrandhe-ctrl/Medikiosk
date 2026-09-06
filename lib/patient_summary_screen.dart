
import 'package:flutter/material.dart';
import 'submission_screen.dart';

class PatientSummaryScreen extends StatelessWidget {
const PatientSummaryScreen({super.key});

@override
Widget build(BuildContext context) {
// --------------------------------------------------
// DUMMY DATA
// Later, replace this with real patient data.
// --------------------------------------------------

final patientInformation = {
'Name': 'John Doe',
'Age': '45',
'Gender': 'Male',
};

final chiefComplaint = 'Pain';

final historyOfPresentIllness = {
'Where is the pain located?': 'Chest',
'How long have you had the pain?': '2 days',
'How would you describe the pain?': 'Pressure',
'How severe is the pain?': '6 / 10',
'Does the pain spread to another area?': 'No',
'Does anything make the pain worse?': 'Walking',
};

final medicalConditions = [
'Diabetes',
'Hypertension',
];

final currentMedication =
'Metformin 500mg';

final allergies =
'No known allergies';

final familyHistory = [
'Diabetes',
'Heart Disease',
];

final personalHistory = {
'Smoking': 'No',
'Alcohol': 'No',
'Diet': 'Mixed',
};

// Change this to true later when
// AYUSH consultation data is passed.
final bool isAyushMode = false;

final ayushHistory = {
'Prakriti Response': 'Medium build',
'Agni': 'Regular',
'Koshtha': 'Regular',
'Ahara': '3 meals per day',
'Vihara': 'Moderate',
'Sleep': 'Good',
};

final priorDocuments = [
{
'type': 'Prescription',
'fileName': 'Prescription_Jan_2025.pdf',
'date': 'January 2025',
},
{
'type': 'Laboratory Report',
'fileName': 'Blood_Test_March_2025.pdf',
'date': 'March 2025',
},
];

return Scaffold(
appBar: AppBar(
title: const Text(
'Medical Summary',
),
centerTitle: true,
leading: IconButton(
icon: const Icon(
Icons.arrow_back,
),
onPressed: () {
Navigator.pop(context);
},
),
),

body: SafeArea(
child: Column(
children: [
Expanded(
child: SingleChildScrollView(
padding: const EdgeInsets.all(20),

child: Column(
crossAxisAlignment:
CrossAxisAlignment.stretch,

children: [

// TITLE

Text(
'Your Medical History Summary',

style: Theme.of(context)
    .textTheme
    .headlineSmall
    ?.copyWith(
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 8),

Text(
'Please review the information below before submitting.',

style: Theme.of(context)
    .textTheme
    .bodyLarge
    ?.copyWith(
color: Theme.of(context)
    .colorScheme
    .onSurfaceVariant,
),
),

const SizedBox(height: 24),


// PATIENT INFORMATION

_SummarySection(
title: 'PATIENT INFORMATION',

icon:
Icons.person_outline,

child: Column(
children: patientInformation
    .entries
    .map(
(entry) =>
_InfoRow(
label: entry.key,
value:
entry.value,
),
)
    .toList(),
),
),


// CHIEF COMPLAINT

_SummarySection(
title: 'CHIEF COMPLAINT',

icon:
Icons.medical_services_outlined,

child: Text(
chiefComplaint,

style: Theme.of(context)
    .textTheme
    .titleMedium
    ?.copyWith(
fontWeight:
FontWeight.w600,
),
),
),


// HISTORY OF PRESENT ILLNESS

_SummarySection(
title:
'HISTORY OF PRESENT ILLNESS',

icon:
Icons.assignment_outlined,

child: Column(
children:
historyOfPresentIllness
    .entries
    .map(
(entry) =>
_QuestionAnswerRow(
question:
entry.key,
answer:
entry.value,
),
)
    .toList(),
),
),


// PAST MEDICAL HISTORY

_SummarySection(
title:
'PAST MEDICAL HISTORY',

icon:
Icons.health_and_safety_outlined,

child: _ListInformation(
items:
medicalConditions,
),
),


// CURRENT MEDICATION

_SummarySection(
title:
'CURRENT MEDICATION',

icon:
Icons.medication_outlined,

child: Text(
currentMedication,

style: Theme.of(context)
    .textTheme
    .bodyLarge,
),
),


// ALLERGIES

_SummarySection(
title:
'ALLERGIES',

icon:
Icons.warning_amber_outlined,

child: Text(
allergies,

style: Theme.of(context)
    .textTheme
    .bodyLarge,
),
),


// FAMILY HISTORY

_SummarySection(
title:
'FAMILY HISTORY',

icon:
Icons.family_restroom_outlined,

child: _ListInformation(
items:
familyHistory,
),
),


// PERSONAL HISTORY

_SummarySection(
title:
'PERSONAL HISTORY',

icon:
Icons.person_outline,

child: Column(
children:
personalHistory.entries
    .map(
(entry) =>
_InfoRow(
label:
entry.key,
value:
entry.value,
),
)
    .toList(),
),
),


// AYUSH HISTORY

if (isAyushMode)
_SummarySection(
title:
'AYUSH HISTORY',

icon:
Icons.spa_outlined,

child: Column(
children:
ayushHistory.entries
    .map(
(entry) =>
_InfoRow(
label:
entry.key,
value:
entry.value,
),
)
    .toList(),
),
),


// PRIOR DOCUMENTS

_SummarySection(
title:
'PRIOR DOCUMENTS',

icon:
Icons.folder_outlined,

child: Column(
children:
priorDocuments.map(
(document) {
return _DocumentCard(
documentType:
document['type']!,
fileName:
document['fileName']!,
date:
document['date']!,
);
},
).toList(),
),
),


const SizedBox(height: 8),


// DISCLAIMER

Container(
padding:
const EdgeInsets.all(18),

decoration:
BoxDecoration(
color: Theme.of(context)
    .colorScheme
    .primaryContainer,

borderRadius:
BorderRadius.circular(
16,
),
),

child: Row(
crossAxisAlignment:
CrossAxisAlignment
    .start,

children: [

Icon(
Icons.info_outline,

color:
Theme.of(context)
    .colorScheme
    .primary,
),

const SizedBox(
width: 12,
),

Expanded(
child: Text(
'This summary is generated from patient-provided information and is intended for physician review.',

style:
Theme.of(context)
    .textTheme
    .bodyMedium
    ?.copyWith(
height:
1.5,
),
),
),
],
),
),

const SizedBox(height: 24),
],
),
),
),


// BOTTOM BUTTONS

Padding(
padding:
const EdgeInsets.all(20),

child: Column(
children: [

// EDIT BUTTON

SizedBox(
width: double.infinity,
height: 55,

child:
OutlinedButton.icon(
onPressed: () {

ScaffoldMessenger.of(
context,
).showSnackBar(
const SnackBar(
content: Text(
'Editing previous information will be added later.',
),
),
);
},

icon: const Icon(
Icons.edit_outlined,
),

label: const Text(
'EDIT INFORMATION',

style: TextStyle(
fontSize: 16,
fontWeight:
FontWeight.bold,
),
),
),
),

const SizedBox(height: 12),


// SUBMIT BUTTON

SizedBox(
width: double.infinity,
height: 58,

child: FilledButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SubmissionScreen(),
      ),
    );
  },

child: const Text(
'SUBMIT HISTORY',

style: TextStyle(
fontSize: 17,
fontWeight:
FontWeight.bold,
letterSpacing: 1,
),
),
),
),
],
),
),
],
),
),
);
}
}


// --------------------------------------------------
// REUSABLE SUMMARY SECTION
// --------------------------------------------------

class _SummarySection extends StatelessWidget {
final String title;
final IconData icon;
final Widget child;

const _SummarySection({
required this.title,
required this.icon,
required this.child,
});

@override
Widget build(BuildContext context) {
final colorScheme =
Theme.of(context).colorScheme;

return Container(
margin:
const EdgeInsets.only(
bottom: 18,
),

padding:
const EdgeInsets.all(18),

decoration: BoxDecoration(
color: colorScheme.surface,

borderRadius:
BorderRadius.circular(18),

border: Border.all(
color:
colorScheme.outlineVariant,
),
),

child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [

Row(
children: [

Icon(
icon,

color:
colorScheme.primary,
),

const SizedBox(
width: 10,
),

Expanded(
child: Text(
title,

style: Theme.of(context)
    .textTheme
    .titleMedium
    ?.copyWith(
fontWeight:
FontWeight.bold,

color:
colorScheme.primary,
),
),
),
],
),

const SizedBox(height: 18),

child,
],
),
);
}
}


// --------------------------------------------------
// REUSABLE INFORMATION ROW
// --------------------------------------------------

class _InfoRow extends StatelessWidget {
final String label;
final String value;

const _InfoRow({
required this.label,
required this.value,
});

@override
Widget build(BuildContext context) {
return Padding(
padding:
const EdgeInsets.only(
bottom: 12,
),

child: Row(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [

Expanded(
flex: 2,

child: Text(
label,

style: Theme.of(context)
    .textTheme
    .bodyLarge
    ?.copyWith(
fontWeight:
FontWeight.w600,
),
),
),

Expanded(
flex: 2,

child: Text(
value,

style: Theme.of(context)
    .textTheme
    .bodyLarge,
),
),
],
),
);
}
}


// --------------------------------------------------
// QUESTION AND ANSWER ROW
// --------------------------------------------------

class _QuestionAnswerRow
extends StatelessWidget {

final String question;
final String answer;

const _QuestionAnswerRow({
required this.question,
required this.answer,
});

@override
Widget build(BuildContext context) {
return Padding(
padding:
const EdgeInsets.only(
bottom: 16,
),

child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [

Text(
question,

style: Theme.of(context)
    .textTheme
    .bodyMedium
    ?.copyWith(
fontWeight:
FontWeight.w600,
),
),

const SizedBox(height: 5),

Text(
answer,

style: Theme.of(context)
    .textTheme
    .bodyLarge,
),
],
),
);
}
}


// --------------------------------------------------
// LIST INFORMATION
// --------------------------------------------------

class _ListInformation
extends StatelessWidget {

final List<String> items;

const _ListInformation({
required this.items,
});

@override
Widget build(BuildContext context) {
return Column(
children: items.map(
(item) {

return Padding(
padding:
const EdgeInsets.only(
bottom: 10,
),

child: Row(
children: [

Icon(
Icons.check_circle_outline,

size: 20,

color:
Theme.of(context)
    .colorScheme
    .primary,
),

const SizedBox(
width: 10,
),

Expanded(
child: Text(
item,

style: Theme.of(context)
    .textTheme
    .bodyLarge,
),
),
],
),
);
},
).toList(),
);
}
}


// --------------------------------------------------
// DOCUMENT CARD
// --------------------------------------------------

class _DocumentCard
extends StatelessWidget {

final String documentType;
final String fileName;
final String date;

const _DocumentCard({
required this.documentType,
required this.fileName,
required this.date,
});

@override
Widget build(BuildContext context) {
return Container(
width: double.infinity,

margin:
const EdgeInsets.only(
bottom: 12,
),

padding:
const EdgeInsets.all(14),

decoration:
BoxDecoration(

color: Theme.of(context)
    .colorScheme
    .surfaceContainerHighest,

borderRadius:
BorderRadius.circular(14),
),

child: Row(
children: [

Icon(
Icons.description_outlined,

size: 35,

color:
Theme.of(context)
    .colorScheme
    .primary,
),

const SizedBox(width: 14),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [

Text(
documentType,

style: Theme.of(context)
    .textTheme
    .titleSmall
    ?.copyWith(
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 4),

Text(
fileName,

style: Theme.of(context)
    .textTheme
    .bodyMedium,
),

const SizedBox(height: 4),

Text(
date,

style: Theme.of(context)
    .textTheme
    .bodySmall,
),
],
),
),
],
),
);
}
}
