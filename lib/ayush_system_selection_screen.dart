
import 'package:flutter/material.dart';

import 'ayush_questions_screen.dart';

class AyushSystemSelectionScreen extends StatefulWidget {
const AyushSystemSelectionScreen({super.key});

@override
State<AyushSystemSelectionScreen> createState() =>
_AyushSystemSelectionScreenState();
}

class _AyushSystemSelectionScreenState
extends State<AyushSystemSelectionScreen> {
String? selectedAyushSystem;

final List<Map<String, dynamic>> ayushSystems = [
{
'name': 'Ayurveda',
'description':
'Traditional Indian system of healthcare focused on balance and overall wellbeing.',
'icon': Icons.spa_outlined,
},
{
'name': 'Yoga & Naturopathy',
'description':
'Focuses on natural healing, healthy lifestyle, yoga, and overall wellbeing.',
'icon': Icons.self_improvement_outlined,
},
{
'name': 'Unani',
'description':
'A traditional system of healthcare focused on maintaining balance in the body.',
'icon': Icons.local_hospital_outlined,
},
{
'name': 'Siddha',
'description':
'A traditional Indian healthcare system focused on maintaining health and wellbeing.',
'icon': Icons.health_and_safety_outlined,
},
{
'name': 'Homoeopathy',
'description':
'A system of healthcare that uses an individualized approach to patient care.',
'icon': Icons.medical_services_outlined,
},
{
'name': 'Sowa-Rigpa',
'description':
'A traditional healthcare system focused on maintaining balance and wellbeing.',
'icon': Icons.nature_people_outlined,
},
];

void _continueToQuestions() {
if (selectedAyushSystem == null) return;

Navigator.push(
context,
MaterialPageRoute(
builder: (context) => AyushQuestionsScreen(
selectedAyushSystem: selectedAyushSystem!,
),
),
);
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);
final primaryColor = theme.colorScheme.primary;

return Scaffold(
appBar: AppBar(
title: const Text('Select AYUSH System'),
),

body: SafeArea(
child: Column(
children: [
Expanded(
child: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
'Select AYUSH System',
style: theme.textTheme.headlineSmall?.copyWith(
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 8),

Text(
'Choose the healthcare system for your consultation.',
style: theme.textTheme.bodyLarge?.copyWith(
color: theme.colorScheme.onSurfaceVariant,
),
),

const SizedBox(height: 24),

...ayushSystems.map((system) {
final bool isSelected =
selectedAyushSystem == system['name'];

return Padding(
padding: const EdgeInsets.only(bottom: 12),
child: InkWell(
borderRadius: BorderRadius.circular(16),
onTap: () {
setState(() {
selectedAyushSystem = system['name'];
});
},
child: AnimatedContainer(
duration: const Duration(milliseconds: 200),
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: isSelected
? primaryColor.withValues(alpha: 0.10)
    : theme.colorScheme.surface,
borderRadius: BorderRadius.circular(16),
border: Border.all(
color: isSelected
? primaryColor
    : theme.colorScheme.outlineVariant,
width: isSelected ? 2 : 1,
),
),
child: Row(
children: [
Container(
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
color: isSelected
? primaryColor.withValues(alpha: 0.15)
    : theme.colorScheme.surfaceContainerHighest,
borderRadius: BorderRadius.circular(12),
),
child: Icon(
system['icon'],
color: isSelected
? primaryColor
    : theme.colorScheme.onSurfaceVariant,
size: 28,
),
),

const SizedBox(width: 16),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Text(
system['name'],
style: theme.textTheme.titleMedium
    ?.copyWith(
fontWeight: FontWeight.bold,
color: isSelected
? primaryColor
    : null,
),
),

const SizedBox(height: 6),

Text(
system['description'],
style: theme.textTheme.bodyMedium?.copyWith(
color: theme
    .colorScheme.onSurfaceVariant,
),
),
],
),
),

if (isSelected)
Container(
padding: const EdgeInsets.all(6),
decoration: BoxDecoration(
color: primaryColor,
shape: BoxShape.circle,
),
child: Icon(
Icons.check,
color:
theme.colorScheme.onPrimary,
size: 20,
),
),
],
),
),
),
);
}),
],
),
),
),

Padding(
padding: const EdgeInsets.all(16),
child: SizedBox(
width: double.infinity,
height: 52,
child: FilledButton(
onPressed: selectedAyushSystem == null
? null
    : _continueToQuestions,
child: const Text(
'CONTINUE',
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
}
