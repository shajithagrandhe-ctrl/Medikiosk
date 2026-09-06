
import 'package:flutter/material.dart';

import 'ayush_case_summary_screen.dart';

class AyushDocumentUploadScreen extends StatefulWidget {
final String selectedAyushSystem;
final Map<String, dynamic> commonAnswers;
final Map<String, dynamic> specificAnswers;
final Map<String, dynamic> treatmentAnswers;
final String mainHealthConcern;
final String referralStatus;

const AyushDocumentUploadScreen({
super.key,
required this.selectedAyushSystem,
required this.commonAnswers,
required this.specificAnswers,
required this.treatmentAnswers,
required this.mainHealthConcern,
required this.referralStatus,
});

@override
State<AyushDocumentUploadScreen> createState() =>
_AyushDocumentUploadScreenState();
}

class _AyushDocumentUploadScreenState
extends State<AyushDocumentUploadScreen> {
final Map<String, bool> selectedDocuments = {
'Previous AYUSH Prescription': false,
'Previous Medical Prescription': false,
'Laboratory Reports': false,
'Medical Reports': false,
'Other Relevant Documents': false,
};

final List<Map<String, dynamic>> documentCategories = [
{
'name': 'Previous AYUSH Prescription',
'description':
'Upload a previous prescription from an AYUSH practitioner.',
'icon': Icons.description_outlined,
},
{
'name': 'Previous Medical Prescription',
'description':
'Upload a prescription from a doctor or healthcare provider.',
'icon': Icons.receipt_long_outlined,
},
{
'name': 'Laboratory Reports',
'description':
'Upload relevant blood tests or other laboratory reports.',
'icon': Icons.science_outlined,
},
{
'name': 'Medical Reports',
'description':
'Upload relevant medical examination or diagnostic reports.',
'icon': Icons.folder_open_outlined,
},
{
'name': 'Other Relevant Documents',
'description':
'Upload any other healthcare documents that may be helpful.',
'icon': Icons.attach_file_outlined,
},
];

void _mockUpload(String categoryName) {
setState(() {
selectedDocuments[categoryName] = true;
});

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text('$categoryName selected for prototype.'),
),
);
}

void _continueToSummary() {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => AyushCaseSummaryScreen(
selectedAyushSystem: widget.selectedAyushSystem,
commonAnswers: widget.commonAnswers,
specificAnswers: widget.specificAnswers,
treatmentAnswers: widget.treatmentAnswers,
mainHealthConcern: widget.mainHealthConcern,
referralStatus: widget.referralStatus,
documentSelections: selectedDocuments,
),
),
);
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

return Scaffold(
appBar: AppBar(
title: const Text('AYUSH Documents'),
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
'Upload Relevant Documents',
style: theme.textTheme.headlineSmall?.copyWith(
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 8),

Text(
'You may upload healthcare documents that could help '
'the practitioner understand your case.',
style: theme.textTheme.bodyLarge?.copyWith(
color: theme.colorScheme.onSurfaceVariant,
),
),

const SizedBox(height: 24),

...documentCategories.map((document) {
final String name = document['name'];
final bool isSelected =
selectedDocuments[name] ?? false;

return Padding(
padding: const EdgeInsets.only(bottom: 14),
child: Card(
elevation: 0,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),
side: BorderSide(
color: isSelected
? theme.colorScheme.primary
    : theme.colorScheme.outlineVariant,
width: isSelected ? 2 : 1,
),
),
child: Padding(
padding: const EdgeInsets.all(16),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Row(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Container(
padding:
const EdgeInsets.all(12),
decoration: BoxDecoration(
color: isSelected
? theme.colorScheme
    .primaryContainer
    : theme.colorScheme
    .surfaceContainerHighest,
borderRadius:
BorderRadius.circular(12),
),
child: Icon(
document['icon'],
color:
theme.colorScheme.primary,
size: 28,
),
),

const SizedBox(width: 14),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [
Text(
name,
style: theme
    .textTheme.titleMedium
    ?.copyWith(
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 6),

Text(
document['description'],
style:
theme.textTheme.bodyMedium,
),
],
),
),
],
),

const SizedBox(height: 16),

if (isSelected)
Container(
width: double.infinity,
padding:
const EdgeInsets.all(12),
decoration: BoxDecoration(
color: theme.colorScheme
    .primaryContainer,
borderRadius:
BorderRadius.circular(12),
),
child: Row(
children: [
Icon(
Icons.check_circle,
color:
theme.colorScheme.primary,
),

const SizedBox(width: 8),

const Text(
'Document Selected',
),
],
),
)
else
SizedBox(
width: double.infinity,
child: OutlinedButton.icon(
onPressed: () =>
_mockUpload(name),
icon: const Icon(
Icons.upload_file,
),
label: const Text('UPLOAD'),
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
child: Column(
children: [
SizedBox(
width: double.infinity,
height: 52,
child: FilledButton(
onPressed: _continueToSummary,
child: const Text(
'CONTINUE',
style: TextStyle(
fontWeight: FontWeight.bold,
letterSpacing: 1,
),
),
),
),

const SizedBox(height: 10),

TextButton(
onPressed: _continueToSummary,
child: const Text('SKIP'),
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

