
import 'package:flutter/material.dart';

import 'ayush_case_summary_screen.dart';

class AyushSubmissionScreen extends StatelessWidget {
final String selectedAyushSystem;
final String mainHealthConcern;
final String referralStatus;

// Data required to reopen the case summary
final Map<String, dynamic> commonAnswers;
final Map<String, dynamic> specificAnswers;
final Map<String, dynamic> treatmentAnswers;
final Map<String, bool> documentSelections;

const AyushSubmissionScreen({
super.key,
required this.selectedAyushSystem,
required this.mainHealthConcern,
required this.referralStatus,
required this.commonAnswers,
required this.specificAnswers,
required this.treatmentAnswers,
required this.documentSelections,
});

void _viewCaseSummary(BuildContext context) {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => AyushCaseSummaryScreen(
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

void _returnToHome(BuildContext context) {
Navigator.popUntil(
context,
(route) => route.isFirst,
);
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

Color statusColor;

if (referralStatus == 'Urgent Referral') {
statusColor = theme.colorScheme.error;
} else {
statusColor = theme.colorScheme.primary;
}

return Scaffold(
appBar: AppBar(
title: const Text('AYUSH Case Submitted'),
automaticallyImplyLeading: false,
),

body: SafeArea(
child: Center(
child: SingleChildScrollView(
padding: const EdgeInsets.all(24),

child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [

const SizedBox(height: 20),

Icon(
Icons.check_circle_outline,
size: 110,
color: theme.colorScheme.primary,
),

const SizedBox(height: 24),

Text(
'AYUSH Case Submitted',
textAlign: TextAlign.center,
style: theme.textTheme.headlineSmall?.copyWith(
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 12),

Text(
'Your case information has been recorded for '
'AYUSH practitioner review.',
textAlign: TextAlign.center,
style: theme.textTheme.bodyLarge?.copyWith(
color: theme.colorScheme.onSurfaceVariant,
height: 1.5,
),
),

const SizedBox(height: 32),

Card(
elevation: 0,

shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),

side: BorderSide(
color: theme.colorScheme.outlineVariant,
),
),

child: Padding(
padding: const EdgeInsets.all(20),

child: Column(
children: [

_buildSummaryRow(
context,
Icons.spa_outlined,
'Selected AYUSH System',
selectedAyushSystem,
),

const Divider(height: 28),

_buildSummaryRow(
context,
Icons.health_and_safety_outlined,
'Main Health Concern',
mainHealthConcern,
),

const Divider(height: 28),

_buildSummaryRow(
context,
Icons.info_outline,
'Referral Status',
referralStatus,
valueColor: statusColor,
),
],
),
),
),

const SizedBox(height: 24),

Container(
width: double.infinity,

padding: const EdgeInsets.all(16),

decoration: BoxDecoration(
color: theme.colorScheme.surfaceContainerHighest,

borderRadius: BorderRadius.circular(16),
),

child: Row(
crossAxisAlignment: CrossAxisAlignment.start,

children: [

Icon(
Icons.info_outline,
color: theme.colorScheme.primary,
),

const SizedBox(width: 12),

Expanded(
child: Text(
'The application does not provide a diagnosis '
'or treatment recommendation.',
style: theme.textTheme.bodyMedium,
),
),
],
),
),

const SizedBox(height: 32),

SizedBox(
width: double.infinity,
height: 54,

child: OutlinedButton.icon(
onPressed: () =>
_viewCaseSummary(context),

icon: const Icon(
Icons.description_outlined,
),

label: const Text(
'VIEW CASE SUMMARY',
style: TextStyle(
fontWeight: FontWeight.bold,
letterSpacing: 1,
),
),
),
),

const SizedBox(height: 14),

SizedBox(
width: double.infinity,
height: 54,

child: FilledButton.icon(
onPressed: () =>
_returnToHome(context),

icon: const Icon(Icons.home_outlined),

label: const Text(
'RETURN TO HOME',
style: TextStyle(
fontWeight: FontWeight.bold,
letterSpacing: 1,
),
),
),
),

const SizedBox(height: 20),
],
),
),
),
),
);
}

Widget _buildSummaryRow(
BuildContext context,
IconData icon,
String label,
String value, {
Color? valueColor,
}) {
final theme = Theme.of(context);

return Row(
crossAxisAlignment: CrossAxisAlignment.start,

children: [

Icon(
icon,
color: theme.colorScheme.primary,
),

const SizedBox(width: 12),

Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,

children: [

Text(
label,
style: theme.textTheme.bodyMedium?.copyWith(
color: theme.colorScheme.onSurfaceVariant,
),
),

const SizedBox(height: 4),

Text(
value,
style: theme.textTheme.titleMedium?.copyWith(
fontWeight: FontWeight.bold,
color: valueColor,
),
),
],
),
),
],
);
}
}

