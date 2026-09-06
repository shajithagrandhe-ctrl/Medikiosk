
import 'package:flutter/material.dart';

import 'ayush_patient_detail_screen.dart';

class AyushPractitionerDashboardScreen extends StatefulWidget {
const AyushPractitionerDashboardScreen({super.key});

@override
State<AyushPractitionerDashboardScreen> createState() =>
_AyushPractitionerDashboardScreenState();
}

class _AyushPractitionerDashboardScreenState
extends State<AyushPractitionerDashboardScreen> {
String searchQuery = '';

String selectedSystem = 'All';

String selectedStatus = 'All';

final List<Map<String, dynamic>> patients = [
{
'name': 'Rahul',
'age': 42,
'gender': 'Male',
'ayushSystem': 'Ayurveda',
'mainHealthConcern': 'Joint Pain',
'referralStatus': 'Priority Review',
},
{
'name': 'Anjali',
'age': 28,
'gender': 'Female',
'ayushSystem': 'Yoga & Naturopathy',
'mainHealthConcern': 'Stress and Poor Sleep',
'referralStatus': 'Normal Review',
},
{
'name': 'Suresh',
'age': 55,
'gender': 'Male',
'ayushSystem': 'Unani',
'mainHealthConcern': 'Digestive Discomfort',
'referralStatus': 'Priority Review',
},
{
'name': 'Meena',
'age': 36,
'gender': 'Female',
'ayushSystem': 'Homoeopathy',
'mainHealthConcern': 'Recurring Headache',
'referralStatus': 'Normal Review',
},
{
'name': 'Kiran',
'age': 48,
'gender': 'Male',
'ayushSystem': 'Siddha',
'mainHealthConcern': 'General Weakness',
'referralStatus': 'Urgent Referral',
},
{
'name': 'Tashi',
'age': 31,
'gender': 'Female',
'ayushSystem': 'Sowa-Rigpa',
'mainHealthConcern': 'Sleep Disturbance',
'referralStatus': 'Normal Review',
},
];

List<Map<String, dynamic>> get filteredPatients {
return patients.where((patient) {
final nameMatches = patient['name']
    .toString()
    .toLowerCase()
    .contains(searchQuery.toLowerCase());

final systemMatches =
selectedSystem == 'All' ||
patient['ayushSystem'] == selectedSystem;

final statusMatches =
selectedStatus == 'All' ||
patient['referralStatus'] == selectedStatus;

return nameMatches && systemMatches && statusMatches;
}).toList();
}

Color _getStatusColor(
BuildContext context,
String status,
) {
final colorScheme = Theme.of(context).colorScheme;

if (status == 'Urgent Referral') {
return colorScheme.error;
}

if (status == 'Priority Review') {
return colorScheme.primary;
}

return colorScheme.secondary;
}

IconData _getStatusIcon(String status) {
if (status == 'Urgent Referral') {
return Icons.warning_amber_rounded;
}

if (status == 'Priority Review') {
return Icons.priority_high;
}

return Icons.check_circle_outline;
}

void _openPatientDetails(
BuildContext context,
Map<String, dynamic> patient,
) {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => AyushPatientDetailScreen(
patientData: patient,
),
),
);
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);

return Scaffold(
appBar: AppBar(
title: const Text(
'AYUSH Practitioner Dashboard',
),
),

body: SafeArea(
child: Column(
children: [
Padding(
padding: const EdgeInsets.fromLTRB(
16,
16,
16,
8,
),
child: TextField(
onChanged: (value) {
setState(() {
searchQuery = value;
});
},
decoration: InputDecoration(
hintText: 'Search patient name',

prefixIcon: const Icon(
Icons.search,
),

border: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
),
),
),
),

Padding(
padding: const EdgeInsets.symmetric(
horizontal: 16,
vertical: 8,
),
child: Row(
children: [
Expanded(
child: DropdownButtonFormField<String>(
value: selectedSystem,

decoration: InputDecoration(
labelText: 'AYUSH System',

border: OutlineInputBorder(
borderRadius: BorderRadius.circular(14),
),
),

items: const [
DropdownMenuItem(
value: 'All',
child: Text('All Systems'),
),
DropdownMenuItem(
value: 'Ayurveda',
child: Text('Ayurveda'),
),
DropdownMenuItem(
value: 'Yoga & Naturopathy',
child: Text(
'Yoga & Naturopathy',
),
),
DropdownMenuItem(
value: 'Unani',
child: Text('Unani'),
),
DropdownMenuItem(
value: 'Siddha',
child: Text('Siddha'),
),
DropdownMenuItem(
value: 'Homoeopathy',
child: Text('Homoeopathy'),
),
DropdownMenuItem(
value: 'Sowa-Rigpa',
child: Text('Sowa-Rigpa'),
),
],

onChanged: (value) {
if (value == null) return;

setState(() {
selectedSystem = value;
});
},
),
),

const SizedBox(width: 12),

Expanded(
child: DropdownButtonFormField<String>(
value: selectedStatus,

decoration: InputDecoration(
labelText: 'Status',

border: OutlineInputBorder(
borderRadius: BorderRadius.circular(14),
),
),

items: const [
DropdownMenuItem(
value: 'All',
child: Text('All Status'),
),
DropdownMenuItem(
value: 'Normal Review',
child: Text('Normal'),
),
DropdownMenuItem(
value: 'Priority Review',
child: Text('Priority'),
),
DropdownMenuItem(
value: 'Urgent Referral',
child: Text('Urgent'),
),
],

onChanged: (value) {
if (value == null) return;

setState(() {
selectedStatus = value;
});
},
),
),
],
),
),

Padding(
padding: const EdgeInsets.all(16),
child: Row(
children: [
Icon(
Icons.people_outline,
color: theme.colorScheme.primary,
),

const SizedBox(width: 8),

Text(
'${filteredPatients.length} Patient Cases',
style: theme.textTheme.titleMedium?.copyWith(
fontWeight: FontWeight.bold,
),
),
],
),
),

Expanded(
child: filteredPatients.isEmpty
? Center(
child: Text(
'No patient cases found.',
style: theme.textTheme.bodyLarge,
),
)
    : ListView.builder(
padding: const EdgeInsets.fromLTRB(
16,
0,
16,
16,
),

itemCount: filteredPatients.length,

itemBuilder: (context, index) {
final patient =
filteredPatients[index];

final status =
patient['referralStatus'];

final statusColor =
_getStatusColor(
context,
status,
);

return Padding(
padding: const EdgeInsets.only(
bottom: 12,
),

child: Card(
elevation: 0,

shape: RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(18),

side: BorderSide(
color: theme
    .colorScheme.outlineVariant,
),
),

child: InkWell(
borderRadius:
BorderRadius.circular(18),

onTap: () =>
_openPatientDetails(
context,
patient,
),

child: Padding(
padding:
const EdgeInsets.all(16),

child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [
Row(
children: [
CircleAvatar(
child: Text(
patient['name']
    .toString()[0],
),
),

const SizedBox(
width: 12,
),

Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment
    .start,

children: [
Text(
patient['name'],
style: theme
    .textTheme
    .titleMedium
    ?.copyWith(
fontWeight:
FontWeight.bold,
),
),

const SizedBox(
height: 4,
),

Text(
'Age: ${patient['age']}',
style: theme
    .textTheme
    .bodyMedium,
),
],
),
),

Icon(
Icons.chevron_right,
color: theme
    .colorScheme
    .onSurfaceVariant,
),
],
),

const SizedBox(height: 16),

_buildPatientInfoRow(
context,
Icons.spa_outlined,
'System',
patient['ayushSystem'],
),

const SizedBox(height: 10),

_buildPatientInfoRow(
context,
Icons.health_and_safety_outlined,
'Concern',
patient[
'mainHealthConcern'],
),

const SizedBox(height: 14),

Container(
padding:
const EdgeInsets.symmetric(
horizontal: 12,
vertical: 8,
),

decoration: BoxDecoration(
color: statusColor
    .withValues(
alpha: 0.12,
),

borderRadius:
BorderRadius.circular(
20,
),
),

child: Row(
mainAxisSize:
MainAxisSize.min,

children: [
Icon(
_getStatusIcon(
status,
),
size: 18,
color: statusColor,
),

const SizedBox(width: 6),

Text(
status,
style: TextStyle(
color: statusColor,
fontWeight:
FontWeight.bold,
),
),
],
),
),
],
),
),
),
),
);
},
),
),
],
),
),
);
}

Widget _buildPatientInfoRow(
BuildContext context,
IconData icon,
String label,
String value,
) {
final theme = Theme.of(context);

return Row(
crossAxisAlignment: CrossAxisAlignment.start,

children: [
Icon(
icon,
size: 20,
color: theme.colorScheme.primary,
),

const SizedBox(width: 10),

Text(
'$label: ',
style: const TextStyle(
fontWeight: FontWeight.bold,
),
),

Expanded(
child: Text(value),
),
],
);
}
}

