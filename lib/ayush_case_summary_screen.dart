
import 'package:flutter/material.dart';

import 'ayush_submission_screen.dart';

class AyushCaseSummaryScreen extends StatelessWidget {
final String selectedAyushSystem;
final Map<String, dynamic> commonAnswers;
final Map<String, dynamic> specificAnswers;
final Map<String, dynamic> treatmentAnswers;
final String mainHealthConcern;
final String referralStatus;
final Map<String, bool> documentSelections;

const AyushCaseSummaryScreen({
super.key,
required this.selectedAyushSystem,
required this.commonAnswers,
required this.specificAnswers,
required this.treatmentAnswers,
required this.mainHealthConcern,
required this.referralStatus,
required this.documentSelections,
});

void _submitCase(BuildContext context) {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => AyushSubmissionScreen(
selectedAyushSystem: selectedAyushSystem,
commonAnswers: commonAnswers,
specificAnswers: specificAnswers,
treatmentAnswers: treatmentAnswers,
mainHealthConcern: mainHealthConcern,
referralStatus: referralStatus,
documentSelections: documentSelections,
),
),
);
}

String _getAnswer(
Map<String, dynamic> answers,
String key,
) {
final value = answers[key];

if (value == null || value.toString().trim().isEmpty) {
return 'Not provided';
}

return value.toString();
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

return Scaffold(
appBar: AppBar(
title: const Text('AYUSH Case Summary'),
),

body: SafeArea(
child: Column(
children: [
Expanded(
child: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Column(
children: [
_buildInfoCard(
context: context,
icon: Icons.person_outline,
title: 'Patient Information',
children: [
_buildInfoRow(
'Name',
_getAnswer(commonAnswers, 'name'),
),
_buildInfoRow(
'Age',
_getAnswer(commonAnswers, 'age'),
),
_buildInfoRow(
'Gender',
_getAnswer(commonAnswers, 'gender'),
),
],
),

const SizedBox(height: 16),

_buildInfoCard(
context: context,
icon: Icons.health_and_safety_outlined,
title: 'AYUSH Consultation',
children: [
_buildInfoRow(
'Selected AYUSH System',
selectedAyushSystem,
),
_buildInfoRow(
'Main Health Concern',
mainHealthConcern,
),
_buildInfoRow(
'Duration of Problem',
_getAnswer(
commonAnswers,
'problemDuration',
),
),
],
),

const SizedBox(height: 16),

_buildInfoCard(
context: context,
icon: Icons.self_improvement_outlined,
title: 'Common AYUSH Information',
children: [
_buildInfoRow(
'Daily Routine (Dinacharya)',
_getAnswer(
commonAnswers,
'dailyRoutine',
),
),
_buildInfoRow(
'Diet (Ahara)',
_getAnswer(
commonAnswers,
'diet',
),
),
_buildInfoRow(
'Lifestyle (Vihara)',
_getAnswer(
commonAnswers,
'lifestyle',
),
),
_buildInfoRow(
'Sleep (Nidra)',
_getAnswer(
commonAnswers,
'sleep',
),
),
_buildInfoRow(
'Appetite',
_getAnswer(
commonAnswers,
'appetite',
),
),
_buildInfoRow(
'Digestion',
_getAnswer(
commonAnswers,
'digestion',
),
),
_buildInfoRow(
'Energy Level',
_getAnswer(
commonAnswers,
'energyLevel',
),
),
_buildInfoRow(
'Stress Level',
_getAnswer(
commonAnswers,
'stressLevel',
),
),
],
),

const SizedBox(height: 16),

_buildDynamicAnswersCard(
context: context,
icon: Icons.assignment_outlined,
title: 'System-Specific Assessment',
answers: specificAnswers,
),

const SizedBox(height: 16),

_buildTreatmentHistoryCard(context),

const SizedBox(height: 16),

_buildSafetyCard(context),

const SizedBox(height: 16),

_buildDocumentsCard(context),

const SizedBox(height: 20),

Container(
width: double.infinity,
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: theme.colorScheme.surfaceContainerHighest,
borderRadius: BorderRadius.circular(16),
),
child: Row(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Icon(
Icons.info_outline,
color: theme.colorScheme.primary,
),

const SizedBox(width: 12),

Expanded(
child: Text(
'This summary represents information '
'provided by the patient and is intended '
'for practitioner assessment.',
style: theme.textTheme.bodyMedium,
),
),
],
),
),

const SizedBox(height: 20),
],
),
),
),

Padding(
padding: const EdgeInsets.all(16),
child: SizedBox(
width: double.infinity,
height: 54,
child: FilledButton(
onPressed: () => _submitCase(context),
child: const Text(
'SUBMIT CASE',
style: TextStyle(
fontWeight: FontWeight.bold,
letterSpacing: 1,
),
),
),
),
),
],
),
),
);
}

Widget _buildInfoCard({
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

shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
),

collapsedShape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
),

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
padding: const EdgeInsets.only(top: 12),
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

Widget _buildDynamicAnswersCard({
required BuildContext context,
required IconData icon,
required String title,
required Map<String, dynamic> answers,
}) {
final List<Widget> answerRows = [];

answers.forEach((key, value) {
answerRows.add(
_buildInfoRow(
_formatKey(key),
value.toString(),
),
);
});

if (answerRows.isEmpty) {
answerRows.add(
const Padding(
padding: EdgeInsets.all(12),
child: Text('No information provided.'),
),
);
}

return _buildInfoCard(
context: context,
icon: icon,
title: title,
children: answerRows,
);
}

Widget _buildTreatmentHistoryCard(
BuildContext context,
) {
return _buildInfoCard(
context: context,
icon: Icons.medication_outlined,
title: 'Treatment History',
children: [
_buildInfoRow(
'Previous Treatment',
_getAnswer(
treatmentAnswers,
'previousTreatment',
),
),

_buildInfoRow(
'Previous AYUSH Treatment',
_getAnswer(
treatmentAnswers,
'previousAyushTreatment',
),
),

_buildInfoRow(
'Previous AYUSH System',
_getAnswer(
treatmentAnswers,
'previousAyushSystem',
),
),

_buildInfoRow(
'Current AYUSH Medicines',
_getAnswer(
treatmentAnswers,
'currentlyTakingAyushMedicine',
),
),

_buildInfoRow(
'AYUSH Medicine Details',
_getAnswer(
treatmentAnswers,
'ayushMedicineDetails',
),
),

_buildInfoRow(
'Improvement from Previous Treatment',
_getAnswer(
treatmentAnswers,
'improvementFromTreatment',
),
),

_buildInfoRow(
'Unwanted Effects',
_getAnswer(
treatmentAnswers,
'unwantedEffects',
),
),

_buildInfoRow(
'Previous Conventional Treatment',
_getAnswer(
treatmentAnswers,
'conventionalTreatment',
),
),

_buildInfoRow(
'Currently Taking Medicines',
_getAnswer(
treatmentAnswers,
'currentlyTakingMedicines',
),
),
],
);
}

Widget _buildSafetyCard(
BuildContext context,
) {
final theme = Theme.of(context);

Color statusColor;
IconData statusIcon;

if (referralStatus == 'Urgent Referral') {
statusColor = theme.colorScheme.error;
statusIcon = Icons.warning_amber_rounded;
} else if (referralStatus == 'Priority Review') {
statusColor = theme.colorScheme.primary;
statusIcon = Icons.priority_high;
} else {
statusColor = theme.colorScheme.primary;
statusIcon = Icons.check_circle_outline;
}

return _buildInfoCard(
context: context,
icon: statusIcon,
title: 'Safety and Referral Assessment',
children: [
Container(
width: double.infinity,
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: statusColor.withValues(alpha: 0.10),
borderRadius: BorderRadius.circular(14),
border: Border.all(
color: statusColor,
),
),
child: Text(
referralStatus,
style: Theme.of(context)
    .textTheme
    .titleMedium
    ?.copyWith(
color: statusColor,
fontWeight: FontWeight.bold,
),
textAlign: TextAlign.center,
),
),
],
);
}

Widget _buildDocumentsCard(
BuildContext context,
) {
final List<Widget> documentRows = [];

documentSelections.forEach((name, selected) {
if (selected) {
documentRows.add(
_buildInfoRow(
name,
'Document Selected',
),
);
}
});

if (documentRows.isEmpty) {
documentRows.add(
const Padding(
padding: EdgeInsets.all(12),
child: Text('No documents selected.'),
),
);
}

return _buildInfoCard(
context: context,
icon: Icons.folder_outlined,
title: 'Documents',
children: documentRows,
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
}}


