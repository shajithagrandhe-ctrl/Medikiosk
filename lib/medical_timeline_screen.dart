import 'package:flutter/material.dart';

class MedicalTimelineScreen extends StatelessWidget {
  const MedicalTimelineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TimelineEvent> events = [
      TimelineEvent(
        date: 'January 2025',
        documentType: 'Prescription',
        icon: Icons.medication_outlined,
        information: [
          'Diagnosis: Diabetes',
          'Medication: Metformin 500mg',
        ],
      ),
      TimelineEvent(
        date: 'March 2025',
        documentType: 'Laboratory Report',
        icon: Icons.science_outlined,
        information: [
          'Blood Sugar: 180 mg/dL',
        ],
      ),
      TimelineEvent(
        date: 'August 2026',
        documentType: 'Prescription',
        icon: Icons.medication_outlined,
        information: [
          'Medication: Metformin 500mg',
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Timeline'),
        centerTitle: true,
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Your Medical History',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'A timeline of your previous medical records.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Timeline
                    ...List.generate(events.length, (index) {
                      final bool isLast =
                          index == events.length - 1;

                      return _TimelineItem(
                        event: events[index],
                        isLast: isLast,
                      );
                    }),

                    const SizedBox(height: 16),

                    // AI Information Note
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.auto_awesome_outlined,
                            color: Theme.of(context)
                                .colorScheme
                                .primary,
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              'AI-powered document extraction will be integrated later.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
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
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Patient Summary coming next.',
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


// Model for Timeline Events

class TimelineEvent {
  final String date;
  final String documentType;
  final IconData icon;
  final List<String> information;

  TimelineEvent({
    required this.date,
    required this.documentType,
    required this.icon,
    required this.information,
  });
}


// Reusable Timeline Item

class _TimelineItem extends StatelessWidget {
  final TimelineEvent event;
  final bool isLast;

  const _TimelineItem({
    required this.event,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline Line and Circle
          SizedBox(
            width: 50,
            child: Column(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    event.icon,
                    color: colorScheme.primary,
                  ),
                ),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 3,
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      color: colorScheme.primaryContainer,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Event Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : 24,
              ),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: colorScheme.outlineVariant,
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    // Date
                    Text(
                      event.date,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Document Type
                    Text(
                      event.documentType,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Medical Information
                    ...event.information.map(
                          (item) {
                        return Padding(
                          padding:
                          const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: colorScheme.primary,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  item,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}