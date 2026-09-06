
import 'package:flutter/material.dart';

class DoctorPatientDetailScreen extends StatelessWidget {
final String name;
final String age;
final String priority;
final String complaint;

const DoctorPatientDetailScreen({
super.key,
required this.name,
required this.age,
required this.priority,
required this.complaint,
});

@override
Widget build(BuildContext context) {
final bool isHighPriority = priority == 'HIGH';
final colorScheme = Theme.of(context).colorScheme;

// Dummy patient data.
// Later, this data can come from the actual patient submission.

const gender = 'Male';

final historyOfPresentIllness = {
'Pain Location': 'Chest',
'Duration': '2 days',
'Pain Type': 'Pressure',
'Pain Severity': '7 / 10',
'Pain Spread': 'No',
};

final pastHistory = [
'Diabetes',
'Hypertension',
];

final medications = [
'Metformin 500mg',
];

const allergies = 'No known allergies';

final familyHistory = [
'Diabetes',
'Heart Disease',
];

final personalHistory = {
'Smoking': 'No',
'Alcohol': 'No',
'Diet': 'Mixed',
};

final ayushHistory = {
'Prakriti Response': 'Medium build',
'Agni': 'Irregular',
'Koshtha': 'Regular',
'Ahara': '3 meals per day',
'Vihara': 'Moderate',
'Sleep': 'Good',
};

final documents = [
{
'type': 'Prescription',
'file': 'Prescription_Jan_2025.pdf',
},
{
'type': 'Laboratory Report',
'file': 'Blood_Test_March_2025.pdf',
},
];

final timeline = [
{
'date': 'January 2025',
'type': 'Prescription',
'details': 'Metformin 500mg',
},
{
'date': 'March 2025',
'type': 'Laboratory Report',
'details': 'Blood Sugar: 180 mg/dL',
},
{
'date': 'August 2026',
'type': 'Prescription',
'details': 'Metformin 500mg',
},
];

return Scaffold(
appBar: AppBar(
title: const Text('Patient Clinical Summary'),
centerTitle: true,
),
body: SafeArea(
child: Column(
children: [
Expanded(
child: SingleChildScrollView(
padding: const EdgeInsets.all(20),
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
// HIGH PRIORITY BANNER

if (isHighPriority)
Container(
padding: const EdgeInsets.all(18),
margin: const EdgeInsets.only(bottom: 20),
decoration: BoxDecoration(
color: colorScheme.errorContainer,
borderRadius: BorderRadius.circular(18),
border: Border.all(
color: colorScheme.error,
width: 2,
),
),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Icon(
Icons.warning_amber_rounded,
size: 42,
color: colorScheme.error,
),

const SizedBox(width: 14),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Text(
'🚨 HIGH PRIORITY',
style: Theme.of(context)
    .textTheme
    .titleLarge
    ?.copyWith(
fontWeight: FontWeight.bold,
color: colorScheme.error,
),
),

const SizedBox(height: 8),

Text(
'Potential emergency symptoms detected.',
style: Theme.of(context)
    .textTheme
    .bodyLarge,
),
],
),
),
],
),
),

// PATIENT INFORMATION

_DetailSection(
title: 'PATIENT INFORMATION',
icon: Icons.person_outline,
child: Column(
children: [
_InfoRow(
label: 'Name',
value: name,
),
_InfoRow(
label: 'Age',
value: age,
),
const _InfoRow(
label: 'Gender',
value: gender,
),
],
),
),

// CHIEF COMPLAINT

_DetailSection(
title: 'CHIEF COMPLAINT',
icon: Icons.medical_services_outlined,
child: Text(
complaint,
style: Theme.of(context)
    .textTheme
    .titleMedium
    ?.copyWith(
fontWeight: FontWeight.w600,
),
),
),

// HISTORY OF PRESENT ILLNESS

_DetailSection(
title: 'HISTORY OF PRESENT ILLNESS',
icon: Icons.assignment_outlined,
child: Column(
children: historyOfPresentIllness.entries
    .map(
(entry) => _InfoRow(
label: entry.key,
value: entry.value,
),
)
    .toList(),
),
),

// PAST HISTORY

_DetailSection(
title: 'PAST HISTORY',
icon: Icons.health_and_safety_outlined,
child: _BulletList(
items: pastHistory,
),
),

// MEDICATIONS

_DetailSection(
title: 'MEDICATIONS',
icon: Icons.medication_outlined,
child: _BulletList(
items: medications,
),
),

// ALLERGIES

_DetailSection(
title: 'ALLERGIES',
icon: Icons.warning_amber_outlined,
child: Text(
allergies,
style:
Theme.of(context).textTheme.bodyLarge,
),
),

// FAMILY HISTORY

_DetailSection(
title: 'FAMILY HISTORY',
icon: Icons.family_restroom_outlined,
child: _BulletList(
items: familyHistory,
),
),

// PERSONAL HISTORY

_DetailSection(
title: 'PERSONAL HISTORY',
icon: Icons.person_outline,
child: Column(
children: personalHistory.entries
    .map(
(entry) => _InfoRow(
label: entry.key,
value: entry.value,
),
)
    .toList(),
),
),

// AYUSH HISTORY

_DetailSection(
title: 'AYUSH HISTORY',
icon: Icons.spa_outlined,
child: Column(
children: ayushHistory.entries
    .map(
(entry) => _InfoRow(
label: entry.key,
value: entry.value,
),
)
    .toList(),
),
),

// DOCUMENTS

_DetailSection(
title: 'DOCUMENTS',
icon: Icons.folder_outlined,
child: Column(
children: documents.map(
(document) {
return _DocumentItem(
documentType: document['type']!,
fileName: document['file']!,
);
},
).toList(),
),
),

// MEDICAL TIMELINE

_DetailSection(
title: 'MEDICAL TIMELINE',
icon: Icons.timeline_outlined,
child: Column(
children: timeline.map(
(event) {
return _TimelineItem(
date: event['date']!,
type: event['type']!,
details: event['details']!,
);
},
).toList(),
),
),

const SizedBox(height: 10),
],
),
),
),

// BOTTOM BUTTONS

Padding(
padding: const EdgeInsets.all(20),
child: Column(
children: [
SizedBox(
width: double.infinity,
height: 54,
child: OutlinedButton.icon(
onPressed: () {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'Editing summary will be added later.',
),
),
);
},
icon: const Icon(Icons.edit_outlined),
label: const Text(
'EDIT SUMMARY',
style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
),
),

const SizedBox(height: 12),

SizedBox(
width: double.infinity,
height: 58,
child: FilledButton.icon(
onPressed: () {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text(
'Patient history confirmed.',
),
),
);
},
icon: const Icon(Icons.check_circle_outline),
label: const Text(
'CONFIRM HISTORY',
style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
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
// REUSABLE DETAIL SECTION
// --------------------------------------------------

class _DetailSection extends StatelessWidget {
final String title;
final IconData icon;
final Widget child;

const _DetailSection({
required this.title,
required this.icon,
required this.child,
});

@override
Widget build(BuildContext context) {
final colorScheme = Theme.of(context).colorScheme;

return Container(
margin: const EdgeInsets.only(bottom: 16),
padding: const EdgeInsets.all(18),
decoration: BoxDecoration(
color: colorScheme.surface,
borderRadius: BorderRadius.circular(18),
border: Border.all(
color: colorScheme.outlineVariant,
),
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Row(
children: [
Icon(
icon,
color: colorScheme.primary,
),

const SizedBox(width: 10),

Expanded(
child: Text(
title,
style: Theme.of(context)
    .textTheme
    .titleMedium
    ?.copyWith(
fontWeight: FontWeight.bold,
color: colorScheme.primary,
),
),
),
],
),

const SizedBox(height: 16),

child,
],
),
);
}
}


// --------------------------------------------------
// INFORMATION ROW
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
padding: const EdgeInsets.only(bottom: 12),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Expanded(
child: Text(
label,
style: Theme.of(context)
    .textTheme
    .bodyMedium
    ?.copyWith(
fontWeight: FontWeight.w600,
),
),
),

Expanded(
child: Text(
value,
style: Theme.of(context).textTheme.bodyMedium,
),
),
],
),
);
}
}


// --------------------------------------------------
// BULLET LIST
// --------------------------------------------------

class _BulletList extends StatelessWidget {
final List<String> items;

const _BulletList({
required this.items,
});

@override
Widget build(BuildContext context) {
return Column(
children: items.map(
(item) {
return Padding(
padding: const EdgeInsets.only(bottom: 10),
child: Row(
children: [
Icon(
Icons.check_circle_outline,
size: 20,
color: Theme.of(context).colorScheme.primary,
),

const SizedBox(width: 10),

Expanded(
child: Text(
item,
style: Theme.of(context).textTheme.bodyLarge,
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
// DOCUMENT ITEM
// --------------------------------------------------

class _DocumentItem extends StatelessWidget {
final String documentType;
final String fileName;

const _DocumentItem({
required this.documentType,
required this.fileName,
});

@override
Widget build(BuildContext context) {
return Container(
margin: const EdgeInsets.only(bottom: 10),
padding: const EdgeInsets.all(14),
decoration: BoxDecoration(
color: Theme.of(context).colorScheme.surfaceContainerHighest,
borderRadius: BorderRadius.circular(14),
),
child: Row(
children: [
const Icon(Icons.description_outlined),

const SizedBox(width: 12),

Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
documentType,
style: Theme.of(context)
    .textTheme
    .titleSmall
    ?.copyWith(
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 4),

Text(fileName),
],
),
),
],
),
);
}
}


// --------------------------------------------------
// TIMELINE ITEM
// --------------------------------------------------

class _TimelineItem extends StatelessWidget {
final String date;
final String type;
final String details;

const _TimelineItem({
required this.date,
required this.type,
required this.details,
});

@override
Widget build(BuildContext context) {
return Padding(
padding: const EdgeInsets.only(bottom: 16),
child: Row(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Column(
children: [
Icon(
Icons.circle,
size: 16,
color: Theme.of(context).colorScheme.primary,
),
Container(
width: 2,
height: 55,
color: Theme.of(context).colorScheme.outlineVariant,
),
],
),

const SizedBox(width: 14),

Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
date,
style: Theme.of(context)
    .textTheme
    .titleSmall
    ?.copyWith(
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 4),

Text(
type,
style: Theme.of(context).textTheme.bodyMedium,
),

const SizedBox(height: 4),

Text(
details,
style: Theme.of(context).textTheme.bodyMedium,
),
],
),
),
],
),
);
}
}

