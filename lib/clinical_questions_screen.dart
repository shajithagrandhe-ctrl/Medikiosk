import 'package:flutter/material.dart';
import 'symptom_question_screen.dart';

class ChiefComplaintScreen extends StatefulWidget {
  const ChiefComplaintScreen({super.key});

  @override
  State<ChiefComplaintScreen> createState() => _ChiefComplaintScreenState();
}

class _ChiefComplaintScreenState extends State<ChiefComplaintScreen> {
  String? selectedComplaint;
  String? typedComplaint;

  final TextEditingController complaintController =
  TextEditingController();

  final List<String> complaints = [
    'Pain',
    'Fever',
    'Cough',
    'Breathing Problem',
    'Stomach Problem',
    'Other',
  ];

  @override
  void dispose() {
    complaintController.dispose();
    super.dispose();
  }

  void selectComplaint(String complaint) {
    setState(() {
      selectedComplaint = complaint;
    });
  }

  void showComplaintDialog() {
    complaintController.text = typedComplaint ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Describe Your Problem'),
          content: TextField(
            controller: complaintController,
            maxLines: 3,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Example: I have chest pain.',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL'),
            ),
            FilledButton(
              onPressed: () {
                final enteredComplaint =
                complaintController.text.trim();

                if (enteredComplaint.isNotEmpty) {
                  setState(() {
                    typedComplaint = enteredComplaint;
                    selectedComplaint = enteredComplaint;
                  });

                  Navigator.pop(context);
                }
              },
              child: const Text('CONFIRM'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: LinearProgressIndicator(
                value: 0.5,
                minHeight: 8,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),

                    // Title
                    Text(
                      'What brings you to the hospital today?',
                      textAlign: TextAlign.center,
                      style:
                      Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Subtitle
                    Text(
                      'Select your main health concern.',
                      textAlign: TextAlign.center,
                      style:
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                        color:
                        Theme.of(context).colorScheme.outline,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Complaint Options
                    ...complaints.map(
                          (complaint) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: _ComplaintCard(
                            complaint: complaint,
                            isSelected:
                            selectedComplaint == complaint,
                            onTap: () {
                              selectComplaint(complaint);
                            },
                          ),
                        );
                      },
                    ),

                    // Display typed complaint
                    if (typedComplaint != null) ...[
                      const SizedBox(height: 8),

                      Text(
                        'Your entered complaint:',
                        style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                          Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          typedComplaint!,
                          style: const TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),

                    // OR
                    const Center(
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Speak Your Problem Button
                    SizedBox(
                      height: 58,
                      child: OutlinedButton.icon(
                        onPressed: showComplaintDialog,
                        icon: const Icon(
                          Icons.mic_none,
                          size: 26,
                        ),
                        label: const Text(
                          'Speak Your Problem',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Continue Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: FilledButton(
                  onPressed: selectedComplaint == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SymptomQuestionScreen(
                          chiefComplaint: selectedComplaint!,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'CONTINUE',
                    style: TextStyle(
                      fontSize: 18,
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

class _ComplaintCard extends StatelessWidget {
  final String complaint;
  final bool isSelected;
  final VoidCallback onTap;

  const _ComplaintCard({
    required this.complaint,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: isSelected
          ? colorScheme.primaryContainer
          : colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  complaint,
                  style:
                  Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: colorScheme.primary,
                  size: 28,
                ),
            ],
          ),
        ),
      ),
    );
  }
}