import 'package:flutter/material.dart';
import 'document_upload_screen.dart';

class RedFlagScreen extends StatefulWidget {
  final String chiefComplaint;
  final Map<String, dynamic> symptomAnswers;

  const RedFlagScreen({
    super.key,
    this.chiefComplaint = '',
    this.symptomAnswers = const {},
  });

  @override
  State<RedFlagScreen> createState() => _RedFlagScreenState();
}

class _RedFlagScreenState extends State<RedFlagScreen> {
  bool get isHighPriority {
    return checkRedFlag();
  }

  bool checkRedFlag() {
    // Rule 1:
    // Chief Complaint = Pain
    // AND pain location indicates chest pain
    // AND breathing difficulty is present

    if (widget.chiefComplaint == 'Pain') {
      final painLocation =
          widget.symptomAnswers['Where is the pain located?']
              ?.toString()
              .toLowerCase() ??
              '';

      final breathingDifficulty =
      widget.symptomAnswers[
      'Is breathing difficult while resting?']
          ?.toString()
          .toLowerCase();

      final hasChestPain =
      painLocation.contains('chest');

      final hasBreathingDifficulty =
          breathingDifficulty == 'yes';

      if (hasChestPain && hasBreathingDifficulty) {
        return true;
      }
    }

    // Rule 2:
    // Chief Complaint = Breathing Problem
    // AND chest pain = Yes

    if (widget.chiefComplaint == 'Breathing Problem') {
      final chestPain =
          widget.symptomAnswers['Do you have chest pain?']
              ?.toString()
              .toLowerCase() ??
              '';

      if (chestPain == 'yes') {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final bool highPriority = isHighPriority;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Priority'),
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Icon(
                highPriority
                    ? Icons.warning_amber_rounded
                    : Icons.check_circle_outline,
                size: 90,
                color: highPriority
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 24),

              Text(
                'Patient Priority',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 32),

              // Priority Card
              _PriorityCard(
                isHighPriority: highPriority,
              ),

              const SizedBox(height: 28),

              // Important disclaimer
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        'This application does not provide a diagnosis. '
                            'This alert is intended to notify hospital staff '
                            'for further assessment.',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 58,
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DocumentUploadScreen(),
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
            ],
          ),
        ),
      ),
    );
  }
}


// Reusable Priority Card

class _PriorityCard extends StatelessWidget {
  final bool isHighPriority;

  const _PriorityCard({
    required this.isHighPriority,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final Color cardColor = isHighPriority
        ? colorScheme.errorContainer
        : colorScheme.primaryContainer;

    final Color textColor = isHighPriority
        ? colorScheme.onErrorContainer
        : colorScheme.onPrimaryContainer;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighPriority
              ? colorScheme.error
              : colorScheme.primary,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          if (isHighPriority) ...[
            Text(
              '🚨 PRIORITY ALERT',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Potential emergency symptoms detected.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'Please contact hospital staff immediately.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                color: textColor,
              ),
            ),

            const SizedBox(height: 24),

            _PriorityLabel(
              text: 'HIGH',
              isHighPriority: true,
            ),
          ] else ...[
            Icon(
              Icons.verified_outlined,
              size: 48,
              color: colorScheme.primary,
            ),

            const SizedBox(height: 16),

            Text(
              'No immediate emergency indicators detected.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            _PriorityLabel(
              text: 'NORMAL',
              isHighPriority: false,
            ),
          ],
        ],
      ),
    );
  }
}


// Priority Label

class _PriorityLabel extends StatelessWidget {
  final String text;
  final bool isHighPriority;

  const _PriorityLabel({
    required this.text,
    required this.isHighPriority,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: isHighPriority
            ? colorScheme.error
            : colorScheme.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isHighPriority
              ? colorScheme.onError
              : colorScheme.onPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}