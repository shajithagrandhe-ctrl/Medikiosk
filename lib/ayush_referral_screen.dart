
import 'package:flutter/material.dart';

import 'ayush_document_upload_screen.dart';

class AyushReferralScreen extends StatefulWidget {
final String selectedAyushSystem;
final Map<String, dynamic> commonAnswers;
final Map<String, dynamic> specificAnswers;
final Map<String, dynamic> treatmentAnswers;
final String mainHealthConcern;

const AyushReferralScreen({
super.key,
required this.selectedAyushSystem,
required this.commonAnswers,
required this.specificAnswers,
required this.treatmentAnswers,
required this.mainHealthConcern,
});

@override
State<AyushReferralScreen> createState() =>
_AyushReferralScreenState();
}

class _AyushReferralScreenState
extends State<AyushReferralScreen> {

late String referralStatus;
late String statusMessage;
late IconData statusIcon;

@override
void initState() {
super.initState();
_evaluateSafety();
}

void _evaluateSafety() {
final allPatientText = [
widget.mainHealthConcern,
...widget.commonAnswers.values.map(
(value) => value.toString(),
),
...widget.specificAnswers.values.map(
(value) => value.toString(),
),
...widget.treatmentAnswers.values.map(
(value) => value.toString(),
),
].join(' ').toLowerCase();

// Urgent warning indicators.
final urgentIndicators = [
'severe chest pain',
'severe difficulty breathing',
'difficulty breathing',
'loss of consciousness',
'unconscious',
'severe bleeding',
'sudden weakness',
'difficulty speaking',
'severe allergic reaction',
'rapidly worsening',
];

final priorityIndicators = [
'severe',
'worsening',
'high stress',
'very high',
'very low',
'poor',
'frequently uncomfortable',
];

final hasUrgentWarning = urgentIndicators.any(
(indicator) => allPatientText.contains(indicator),
);

final hasPriorityWarning = priorityIndicators.any(
(indicator) => allPatientText.contains(indicator),
);

if (hasUrgentWarning) {
referralStatus = 'Urgent Referral';

statusMessage =
'Potential urgent warning indicators were detected. '
'Immediate medical assessment may be required.';

statusIcon = Icons.warning_amber_rounded;
} else if (hasPriorityWarning) {
referralStatus = 'Priority Review';

statusMessage =
'Additional practitioner assessment is recommended.';

statusIcon = Icons.priority_high_rounded;
} else {
referralStatus = 'Normal';

statusMessage =
'No immediate urgent warning indicators were detected.';

statusIcon = Icons.check_circle_outline;
}
}

void _continueToDocumentUpload() {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
AyushDocumentUploadScreen(
selectedAyushSystem: widget.selectedAyushSystem,
commonAnswers: widget.commonAnswers,
specificAnswers: widget.specificAnswers,
treatmentAnswers: widget.treatmentAnswers,
mainHealthConcern: widget.mainHealthConcern,
referralStatus: referralStatus,
),
),
);
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

final bool isUrgent =
referralStatus == 'Urgent Referral';

final bool isPriority =
referralStatus == 'Priority Review';

final Color statusColor;

if (isUrgent) {
statusColor = theme.colorScheme.error;
} else if (isPriority) {
statusColor = theme.colorScheme.primary;
} else {
statusColor = theme.colorScheme.primary;
}

return Scaffold(
appBar: AppBar(
title: const Text(
'Safety and Referral Assessment',
),
),

body: SafeArea(
child: Padding(
padding: const EdgeInsets.all(20),

child: Column(
children: [

const SizedBox(height: 30),

Icon(
statusIcon,
size: 100,
color: statusColor,
),

const SizedBox(height: 24),

Text(
'Selected System: '
'${widget.selectedAyushSystem}',
style: theme.textTheme.titleMedium?.copyWith(
color: theme.colorScheme.onSurfaceVariant,
),
textAlign: TextAlign.center,
),

const SizedBox(height: 30),

Container(
width: double.infinity,
padding: const EdgeInsets.all(24),

decoration: BoxDecoration(
color: isUrgent
? theme.colorScheme.errorContainer
    : theme.colorScheme.primaryContainer,

borderRadius:
BorderRadius.circular(20),

border: Border.all(
color: statusColor,
width: 2,
),
),

child: Column(
children: [

Text(
referralStatus,
style: theme.textTheme.headlineSmall
    ?.copyWith(
fontWeight: FontWeight.bold,
color: statusColor,
),
textAlign: TextAlign.center,
),

const SizedBox(height: 16),

Text(
statusMessage,
style: theme.textTheme.bodyLarge,
textAlign: TextAlign.center,
),
],
),
),

const SizedBox(height: 28),

Container(
width: double.infinity,
padding: const EdgeInsets.all(18),

decoration: BoxDecoration(
color:
theme.colorScheme.surfaceContainerHighest,
borderRadius:
BorderRadius.circular(16),
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
'This application does not provide a diagnosis. '
'This screening is intended only to support '
'appropriate practitioner assessment and referral.',
style: theme.textTheme.bodyMedium,
),
),
],
),
),

const Spacer(),

SizedBox(
width: double.infinity,
height: 54,

child: FilledButton(
onPressed:
_continueToDocumentUpload,

child: const Text(
'CONTINUE',
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
),
);
}
}
