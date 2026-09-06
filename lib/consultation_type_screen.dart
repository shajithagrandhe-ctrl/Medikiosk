import 'package:flutter/material.dart';
import 'clinical_questions_screen.dart';
import 'ayush_system_selection_screen.dart';

class ConsultationTypeScreen extends StatefulWidget {
  const ConsultationTypeScreen({super.key});

  @override
  State<ConsultationTypeScreen> createState() =>
      _ConsultationTypeScreenState();
}

class _ConsultationTypeScreenState extends State<ConsultationTypeScreen> {
  String? selectedConsultationType;

  void selectConsultationType(String type) {
    setState(() {
      selectedConsultationType = type;
    });
  }
  void continueToNextScreen() {
    if (selectedConsultationType == 'General Clinical History') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ChiefComplaintScreen(),
        ),
      );
    } else if (selectedConsultationType == 'AYUSH / Ayurvedic History') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AyushSystemSelectionScreen(),
        ),
      );
    }
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              Text(
                'Select Consultation Type',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              _ConsultationCard(
                title: 'General Clinical History',
                description: 'Complete your general medical history.',
                icon: Icons.medical_services_outlined,
                isSelected:
                selectedConsultationType == 'General Clinical History',
                onTap: () {
                  selectConsultationType('General Clinical History');
                },
              ),

              const SizedBox(height: 20),

              _ConsultationCard(
                title: 'AYUSH / Ayurvedic History',
                description:
                'Provide additional Ayurvedic health information.',
                icon: Icons.eco_outlined,
                isSelected:
                selectedConsultationType == 'AYUSH / Ayurvedic History',
                onTap: () {
                  selectConsultationType('AYUSH / Ayurvedic History');
                },
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: FilledButton(
                  onPressed: selectedConsultationType == null
                      ? null
                      : continueToNextScreen,
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

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConsultationCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ConsultationCard({
    required this.title,
    required this.description,
    required this.icon,
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
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: isSelected
                      ? colorScheme.onPrimary
                      : colorScheme.primary,
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                      Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      description,
                      style:
                      Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.4,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: colorScheme.primary,
                  size: 30,
                ),
            ],
          ),
        ),
      ),
    );
  }
}