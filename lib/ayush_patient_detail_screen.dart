
import 'package:flutter/material.dart';

class AyushPatientDetailScreen extends StatefulWidget {
final Map<String, dynamic> patientData;

const AyushPatientDetailScreen({
super.key,
required this.patientData,
});

@override
State<AyushPatientDetailScreen> createState() =>
_AyushPatientDetailScreenState();
}

class _AyushPatientDetailScreenState
extends State<AyushPatientDetailScreen> {
bool isReviewed = false;

String _getValue(String key) {
final value = widget.patientData[key];

if (value == null || value.toString().isEmpty) {
return 'Not provided';
}

return value.toString();
}

Map<String, dynamic> _getMap(String key) {
final value = widget.patientData[key];

if (value is Map<String, dynamic>) {
return value;
}

return {};
}

void _markAsReviewed() {
setState(() {
isReviewed = true;
});

ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(
content: Text('Patient case marked as reviewed.'),
),
);
}

String _formatKey(String key) {
String result = key.replaceAllMapped(
RegExp(r'([A-Z])'),
(Match match) => ' ${match.group(0)}',
);

if (result.isEmpty) {
return result;
}

return result[0].toUpperCase() + result.substring(1);
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

final commonAnswers = _getMap('commonAnswers');
final specificAnswers = _getMap('specificAnswers');
final treatmentAnswers = _getMap('treatmentAnswers');

final documents = widget.patientData['documentSelections'];

return Scaffold(
appBar: AppBar(
title: const Text('AYUSH Patient Case'),
),

body: SafeArea(
child: Column(
children: [
Expanded(
child: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Column(
children: [

// REVIEW STATUS

if (isReviewed)
Container(
width: double.infinity,
padding: const EdgeInsets.all(14),
margin: const EdgeInsets.only(
bottom: 16,
),
decoration: BoxDecoration(
color: theme.colorScheme.primaryContainer,
borderRadius:
BorderRadius.circular(16),
),
child: Row(
children: [
Icon(
Icons.check_circle,
color:
theme.colorScheme.primary,
),

const SizedBox(width: 10),

const Expanded(
child: Text(
'This patient case has been reviewed.',
),
),
],
),
),

// PATIENT INFORMATION

_buildSectionCard(
context: context,
icon: Icons.person_outline,
title: 'Patient Information',
children: [
_buildInfoRow(
'Name',
_getValue('name'),
),

_buildInfoRow(
'Age',
_getValue('age'),
),

_buildInfoRow(
'Gender',
_getValue('gender'),
),
],
),

const SizedBox(height: 14),

// AYUSH SYSTEM

_buildSectionCard(
context: context,
icon: Icons.spa_outlined,
title: 'Selected AYUSH System',
children: [
_buildInfoRow(
'System',
_getValue('ayushSystem'),
),
],
),

const SizedBox(height: 14),

// MAIN HEALTH CONCERN

_buildSectionCard(
context: context,
icon:
Icons.health_and_safety_outlined,
title: 'Main Health Concern',
children: [
_buildInfoRow(
'Patient Concern',
_getValue(
'mainHealthConcern',
),
),
],
),

const SizedBox(height: 14),

// COMMON AYUSH INFORMATION

_buildAnswersSection(
context: context,
title: 'Common AYUSH Case Information',
icon: Icons.self_improvement_outlined,
answers: commonAnswers,
),

const SizedBox(height: 14),

// SYSTEM-SPECIFIC QUESTIONS

_buildAnswersSection(
context: context,
title: 'System-Specific Questions',
icon: Icons.assignment_outlined,
answers: specificAnswers,
),

const SizedBox(height: 14),

// TREATMENT HISTORY

_buildAnswersSection(
context: context,
title: 'Treatment History',
icon: Icons.medication_outlined,
answers: treatmentAnswers,
),

const SizedBox(height: 14),

// SAFETY STATUS

_buildSafetySection(
context,
),

const SizedBox(height: 14),

// DOCUMENTS

_buildDocumentsSection(
context,
documents,
),

const SizedBox(height: 24),
],
),
),
),

// BOTTOM BUTTONS

Padding(
padding: const EdgeInsets.all(16),
child: Column(
children: [

SizedBox(
width: double.infinity,
height: 54,
child: FilledButton.icon(
onPressed:
isReviewed ? null : _markAsReviewed,
icon: Icon(
isReviewed
? Icons.check_circle
    : Icons.done,
),
label: Text(
isReviewed
? 'REVIEWED'
    : 'MARK AS REVIEWED',
style: const TextStyle(
fontWeight: FontWeight.bold,
letterSpacing: 1,
),
),
),
),

const SizedBox(height: 12),

SizedBox(
width: double.infinity,
height: 54,
child: OutlinedButton.icon(
onPressed: () {
Navigator.pop(context);
},
icon: const Icon(
Icons.arrow_back,
),
label: const Text(
'BACK TO DASHBOARD',
style: TextStyle(
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

Widget _buildSectionCard({
required BuildContext context,
required IconData icon,
required String title,
required List<Widget> children,
}) {
final theme = Theme.of(context);

return Card(
elevation: 0,

shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),

side: BorderSide(
color: theme.colorScheme.outlineVariant,
),
),

child: ExpansionTile(
initiallyExpanded: true,

leading: Icon(
icon,
color: theme.colorScheme.primary,
),

title: Text(
title,
style: theme.textTheme.titleMedium?.copyWith(
fontWeight: FontWeight.bold,
),
),

childrenPadding: const EdgeInsets.fromLTRB(
20,
0,
20,
16,
),

children: children,
),
);
}

Widget _buildInfoRow(
String label,
String value,
) {
return Padding(
padding: const EdgeInsets.only(top: 10),

child: Column(
crossAxisAlignment: CrossAxisAlignment.start,

children: [
Text(
label,
style: const TextStyle(
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 4),

Text(value),

const Divider(),
],
),
);
}

Widget _buildAnswersSection({
required BuildContext context,
required String title,
required IconData icon,
required Map<String, dynamic> answers,
}) {
final List<Widget> rows = [];

answers.forEach((key, value) {
rows.add(
_buildInfoRow(
_formatKey(key),
value.toString(),
),
);
});

if (rows.isEmpty) {
rows.add(
const Padding(
padding: EdgeInsets.all(12),
child: Text(
'No information available.',
),
),
);
}

return _buildSectionCard(
context: context,
icon: icon,
title: title,
children: rows,
);
}

Widget _buildSafetySection(
BuildContext context,
) {
final theme = Theme.of(context);

final status = _getValue('referralStatus');

Color statusColor;
IconData statusIcon;

if (status == 'Urgent Referral') {
statusColor = theme.colorScheme.error;
statusIcon = Icons.warning_amber_rounded;
} else if (status == 'Priority Review') {
statusColor = theme.colorScheme.primary;
statusIcon = Icons.priority_high;
} else {
statusColor = theme.colorScheme.primary;
statusIcon = Icons.check_circle_outline;
}

return _buildSectionCard(
context: context,
icon: statusIcon,
title: 'Safety and Referral Status',
children: [
Container(
width: double.infinity,
padding: const EdgeInsets.all(16),

decoration: BoxDecoration(
color: statusColor.withValues(
alpha: 0.10,
),

borderRadius:
BorderRadius.circular(14),

border: Border.all(
color: statusColor,
),
),

child: Text(
status,
textAlign: TextAlign.center,

style: theme.textTheme.titleMedium?.copyWith(
color: statusColor,
fontWeight: FontWeight.bold,
),
),
),
],
);
}

Widget _buildDocumentsSection(
BuildContext context,
dynamic documents,
) {
final List<Widget> documentRows = [];

if (documents is Map) {
documents.forEach((key, value) {
if (value == true) {
documentRows.add(
_buildInfoRow(
key.toString(),
'Document Selected',
),
);
}
});
}

if (documentRows.isEmpty) {
documentRows.add(
const Padding(
padding: EdgeInsets.all(12),
child: Text(
'No documents uploaded.',
),
),
);
}

return _buildSectionCard(
context: context,
icon: Icons.folder_outlined,
title: 'Uploaded Documents',
children: documentRows,
);
}
}

