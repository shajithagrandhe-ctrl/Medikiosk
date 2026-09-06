
import 'package:flutter/material.dart';
import 'doctor_patient_detail_screen.dart';

class DoctorDashboardScreen extends StatefulWidget {
const DoctorDashboardScreen({super.key});

@override
State<DoctorDashboardScreen> createState() =>
_DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
String searchQuery = '';
String selectedPriority = 'ALL';

final List<Map<String, String>> patients = [
{
'name': 'Ravi Kumar',
'age': '52',
'priority': 'HIGH',
'complaint': 'Chest Pain',
},
{
'name': 'Sita Devi',
'age': '40',
'priority': 'NORMAL',
'complaint': 'Fever',
},
{
'name': 'Ahmed Khan',
'age': '31',
'priority': 'NORMAL',
'complaint': 'Cough',
},
];

List<Map<String, String>> get filteredPatients {
return patients.where((patient) {
final name = patient['name']!.toLowerCase();
final priority = patient['priority']!.toLowerCase();

final matchesSearch =
name.contains(searchQuery.toLowerCase());

final matchesPriority =
selectedPriority == 'ALL' ||
priority == selectedPriority.toLowerCase();

return matchesSearch && matchesPriority;
}).toList();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Doctor Dashboard'),
centerTitle: true,
),
body: SafeArea(
child: Padding(
padding: const EdgeInsets.all(20),
child: Column(
children: [
// Search Patient
TextField(
onChanged: (value) {
setState(() {
searchQuery = value;
});
},
decoration: InputDecoration(
hintText: 'Search Patient',
prefixIcon: const Icon(Icons.search),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(16),
),
),
),

const SizedBox(height: 20),

// Filter Title
Align(
alignment: Alignment.centerLeft,
child: Text(
'Filter Priority',
style: Theme.of(context)
    .textTheme
    .titleMedium
    ?.copyWith(
fontWeight: FontWeight.bold,
),
),
),

const SizedBox(height: 12),

// Priority Filters
SingleChildScrollView(
scrollDirection: Axis.horizontal,
child: Row(
children: [
_buildFilterChip('ALL'),
const SizedBox(width: 8),
_buildFilterChip('HIGH'),
const SizedBox(width: 8),
_buildFilterChip('MEDIUM'),
const SizedBox(width: 8),
_buildFilterChip('NORMAL'),
],
),
),

const SizedBox(height: 24),

// Patient Count
Align(
alignment: Alignment.centerLeft,
child: Text(
'${filteredPatients.length} Patients',
style: Theme.of(context)
    .textTheme
    .titleMedium
    ?.copyWith(
fontWeight: FontWeight.bold,
),
),
),

const SizedBox(height: 12),

// Patient List
Expanded(
child: filteredPatients.isEmpty
? Center(
child: Text(
'No patients found.',
style: Theme.of(context)
    .textTheme
    .bodyLarge,
),
)
    : ListView.builder(
itemCount: filteredPatients.length,
itemBuilder: (context, index) {
final patient =
filteredPatients[index];

return _PatientCard(
name: patient['name']!,
age: patient['age']!,
priority:
patient['priority']!,
complaint:
patient['complaint']!,
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DoctorPatientDetailScreen(
        name: patient['name']!,
        age: patient['age']!,
        priority: patient['priority']!,
        complaint: patient['complaint']!,
      ),
    ),
  );
},
);
},
),
),
],
),
),
),
);
}

// Reusable Filter Chip
Widget _buildFilterChip(String priority) {
return ChoiceChip(
label: Text(priority),
selected: selectedPriority == priority,
onSelected: (selected) {
if (selected) {
setState(() {
selectedPriority = priority;
});
}
},
);
}
}


// --------------------------------------------------
// PATIENT CARD
// --------------------------------------------------

class _PatientCard extends StatelessWidget {
final String name;
final String age;
final String priority;
final String complaint;
final VoidCallback onTap;

const _PatientCard({
required this.name,
required this.age,
required this.priority,
required this.complaint,
required this.onTap,
});

@override
Widget build(BuildContext context) {
final colorScheme = Theme.of(context).colorScheme;

final bool isHighPriority = priority == 'HIGH';

return Card(
margin: const EdgeInsets.only(bottom: 14),

elevation: isHighPriority ? 3 : 1,

shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18),

side: BorderSide(
color: isHighPriority
? colorScheme.error
    : Colors.transparent,

width: isHighPriority ? 2 : 0,
),
),

child: InkWell(
borderRadius: BorderRadius.circular(18),

onTap: onTap,

child: Padding(
padding: const EdgeInsets.all(18),

child: Row(
children: [
// Patient Icon
CircleAvatar(
radius: 28,

child: Icon(
Icons.person,
size: 30,
color: colorScheme.onPrimary,
),
),

const SizedBox(width: 16),

// Patient Information
Expanded(
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,

children: [
Text(
name,

style: Theme.of(context)
    .textTheme
    .titleMedium
    ?.copyWith(
fontWeight:
FontWeight.bold,
),
),

const SizedBox(height: 5),

Text(
'Age: $age',

style: Theme.of(context)
    .textTheme
    .bodyMedium,
),

const SizedBox(height: 5),

Text(
complaint,

style: Theme.of(context)
    .textTheme
    .bodyMedium
    ?.copyWith(
color: colorScheme
    .onSurfaceVariant,
),
),
],
),
),

const SizedBox(width: 10),

// Priority Chip
_PriorityChip(
priority: priority,
),
],
),
),
),
);
}
}


// --------------------------------------------------
// PRIORITY CHIP
// --------------------------------------------------

class _PriorityChip extends StatelessWidget {
final String priority;

const _PriorityChip({
required this.priority,
});

@override
Widget build(BuildContext context) {
final colorScheme = Theme.of(context).colorScheme;

Color backgroundColor;
Color textColor;

if (priority == 'HIGH') {
backgroundColor = colorScheme.errorContainer;
textColor = colorScheme.onErrorContainer;
} else if (priority == 'MEDIUM') {
backgroundColor = colorScheme.tertiaryContainer;
textColor = colorScheme.onTertiaryContainer;
} else {
backgroundColor = colorScheme.primaryContainer;
textColor = colorScheme.onPrimaryContainer;
}

return Container(
padding: const EdgeInsets.symmetric(
horizontal: 10,
vertical: 7,
),

decoration: BoxDecoration(
color: backgroundColor,
borderRadius: BorderRadius.circular(20),
),

child: Text(
priority,

style: TextStyle(
fontSize: 12,
fontWeight: FontWeight.bold,
color: textColor,
),
),
);
}
}
