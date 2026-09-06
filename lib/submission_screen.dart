
import 'package:flutter/material.dart';
import 'patient_summary_screen.dart';
import 'welcome_screen.dart';

class SubmissionScreen extends StatelessWidget {
const SubmissionScreen({super.key});

@override
Widget build(BuildContext context) {
// Dummy values for now.
// Later these will come from the patient's actual data.
const String patientToken = 'A-102';
const String patientPriority = 'NORMAL';

final bool isHighPriority = patientPriority == 'HIGH';

final colorScheme = Theme.of(context).colorScheme;

return Scaffold(
appBar: AppBar(
automaticallyImplyLeading: false,
title: const Text('Submission Complete'),
centerTitle: true,
),
body: SafeArea(
child: Padding(
padding: const EdgeInsets.all(24),
child: Column(
children: [
const SizedBox(height: 30),

// Success Icon
Container(
width: 110,
height: 110,
decoration: BoxDecoration(
color: colorScheme.primaryContainer,
shape: BoxShape.circle,
),
child: Icon(
Icons.check_circle_outline,
size: 70,
color: colorScheme.primary,
),
),

const SizedBox(height: 28),

// Title
Text(
'History Submitted Successfully',
textAlign: TextAlign.center,
style: Theme.of(context).textTheme.headlineSmall?.copyWith(
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 14),

// Message
Text(
'Your medical history has been prepared for your doctor.',
textAlign: TextAlign.center,
style: Theme.of(context).textTheme.bodyLarge?.copyWith(
height: 1.5,
color: colorScheme.onSurfaceVariant,
),
),

const SizedBox(height: 32),

// Patient Token Card
Container(
width: double.infinity,
padding: const EdgeInsets.all(22),
decoration: BoxDecoration(
color: colorScheme.primaryContainer,
borderRadius: BorderRadius.circular(20),
),
child: Column(
children: [
Icon(
Icons.confirmation_number_outlined,
size: 38,
color: colorScheme.primary,
),

const SizedBox(height: 10),

Text(
'Patient Token Number',
style: Theme.of(context).textTheme.titleMedium,
),

const SizedBox(height: 8),

Text(
patientToken,
style: Theme.of(context).textTheme.headlineMedium?.copyWith(
fontWeight: FontWeight.bold,
color: colorScheme.primary,
),
),
],
),
),

const SizedBox(height: 18),

// Priority Card
Container(
width: double.infinity,
padding: const EdgeInsets.all(20),
decoration: BoxDecoration(
color: isHighPriority
? colorScheme.errorContainer
    : colorScheme.secondaryContainer,
borderRadius: BorderRadius.circular(20),
border: Border.all(
color: isHighPriority
? colorScheme.error
    : colorScheme.secondary,
width: 1.5,
),
),
child: Row(
children: [
Icon(
isHighPriority
? Icons.warning_amber_rounded
    : Icons.verified_outlined,
size: 45,
color: isHighPriority
? colorScheme.error
    : colorScheme.secondary,
),

const SizedBox(width: 16),

Expanded(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Patient Priority',
style: Theme.of(context).textTheme.titleMedium,
),

const SizedBox(height: 5),

Text(
patientPriority,
style: Theme.of(context).textTheme.titleLarge?.copyWith(
fontWeight: FontWeight.bold,
color: isHighPriority
? colorScheme.error
    : colorScheme.secondary,
),
),
],
),
),
],
),
),

const Spacer(),

// View Summary Button
SizedBox(
width: double.infinity,
height: 55,
child: OutlinedButton.icon(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const PatientSummaryScreen(),
),
);
},
icon: const Icon(Icons.visibility_outlined),
label: const Text(
'VIEW SUMMARY',
style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
),
),
),
),

const SizedBox(height: 12),

// Finish Button
SizedBox(
width: double.infinity,
height: 58,
child: FilledButton(
onPressed: () {
Navigator.pushAndRemoveUntil(
context,
MaterialPageRoute(
builder: (context) => const WelcomeScreen(),
),
(route) => false,
);
},
child: const Text(
'FINISH',
style: TextStyle(
fontSize: 17,
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

