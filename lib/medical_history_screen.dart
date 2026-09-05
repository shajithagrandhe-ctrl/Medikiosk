import 'package:flutter/material.dart';
import 'red_flag_screen.dart';

class MedicalHistoryScreen extends StatefulWidget {
  final String consultationType;

  const MedicalHistoryScreen({
    super.key,
    this.consultationType = 'General Clinical History',
  });

  @override
  State<MedicalHistoryScreen> createState() =>
      _MedicalHistoryScreenState();
}

class _MedicalHistoryScreenState extends State<MedicalHistoryScreen> {
  // Existing medical conditions
  final List<String> medicalConditions = [
    'Diabetes',
    'Hypertension',
    'Asthma',
    'Heart Disease',
    'Kidney Disease',
    'None',
  ];

  final Set<String> selectedConditions = {};

  // Family history
  final List<String> familyHistoryOptions = [
    'Diabetes',
    'Hypertension',
    'Heart Disease',
    'Cancer',
  ];

  final Set<String> selectedFamilyHistory = {};

  // Surgery
  bool? hadSurgery;
  final TextEditingController surgeryController =
  TextEditingController();

  // Allergies
  bool? hasAllergies;
  final TextEditingController allergyController =
  TextEditingController();

  // Medication
  bool? takingMedication;
  final TextEditingController medicationController =
  TextEditingController();

  // Personal history
  bool? smoking;
  bool? alcohol;

  String? selectedDiet;

  @override
  void dispose() {
    surgeryController.dispose();
    allergyController.dispose();
    medicationController.dispose();
    super.dispose();
  }

  void toggleCondition(String condition) {
    setState(() {
      if (condition == 'None') {
        selectedConditions.clear();
        selectedConditions.add('None');
      } else {
        selectedConditions.remove('None');

        if (selectedConditions.contains(condition)) {
          selectedConditions.remove(condition);
        } else {
          selectedConditions.add(condition);
        }
      }
    });
  }

  void toggleFamilyHistory(String condition) {
    setState(() {
      if (selectedFamilyHistory.contains(condition)) {
        selectedFamilyHistory.remove(condition);
      } else {
        selectedFamilyHistory.add(condition);
      }
    });
  }

  void continueToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RedFlagScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical History'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              child: LinearProgressIndicator(
                value: 0.7,
                minHeight: 8,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.stretch,
                  children: [

                    // SECTION 1
                    _SectionTitle(
                      title: 'Existing Medical Conditions',
                    ),

                    const SizedBox(height: 12),

                    _MultiSelectSection(
                      options: medicalConditions,
                      selectedOptions: selectedConditions,
                      onTap: toggleCondition,
                    ),

                    const SizedBox(height: 32),

                    // SECTION 2
                    _SectionTitle(
                      title: 'Previous Surgery',
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Have you had any surgery?',
                      style: TextStyle(fontSize: 17),
                    ),

                    const SizedBox(height: 12),

                    _YesNoSelector(
                      value: hadSurgery,
                      onChanged: (value) {
                        setState(() {
                          hadSurgery = value;
                        });
                      },
                    ),

                    if (hadSurgery == true) ...[
                      const SizedBox(height: 16),

                      TextField(
                        controller: surgeryController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Please describe the surgery',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],

                    const SizedBox(height: 32),

                    // SECTION 3
                    _SectionTitle(
                      title: 'Allergies',
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Do you have any allergies?',
                      style: TextStyle(fontSize: 17),
                    ),

                    const SizedBox(height: 12),

                    _YesNoSelector(
                      value: hasAllergies,
                      onChanged: (value) {
                        setState(() {
                          hasAllergies = value;
                        });
                      },
                    ),

                    if (hasAllergies == true) ...[
                      const SizedBox(height: 16),

                      TextField(
                        controller: allergyController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Please describe your allergies',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],

                    const SizedBox(height: 32),

                    // SECTION 4
                    _SectionTitle(
                      title: 'Current Medication',
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Are you currently taking medication?',
                      style: TextStyle(fontSize: 17),
                    ),

                    const SizedBox(height: 12),

                    _YesNoSelector(
                      value: takingMedication,
                      onChanged: (value) {
                        setState(() {
                          takingMedication = value;
                        });
                      },
                    ),

                    if (takingMedication == true) ...[
                      const SizedBox(height: 16),

                      TextField(
                        controller: medicationController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Enter your current medication',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],

                    const SizedBox(height: 32),

                    // SECTION 5
                    _SectionTitle(
                      title: 'Family History',
                    ),

                    const SizedBox(height: 12),

                    _MultiSelectSection(
                      options: familyHistoryOptions,
                      selectedOptions: selectedFamilyHistory,
                      onTap: toggleFamilyHistory,
                    ),

                    const SizedBox(height: 32),

                    // SECTION 6
                    _SectionTitle(
                      title: 'Personal History',
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Smoking',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    _YesNoSelector(
                      value: smoking,
                      onChanged: (value) {
                        setState(() {
                          smoking = value;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Alcohol',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    _YesNoSelector(
                      value: alcohol,
                      onChanged: (value) {
                        setState(() {
                          alcohol = value;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Diet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    _DietSelector(
                      selectedDiet: selectedDiet,
                      onSelected: (diet) {
                        setState(() {
                          selectedDiet = diet;
                        });
                      },
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: FilledButton(
                  onPressed: continueToNextScreen,
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


// Reusable Section Title

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}


// Reusable Multi Select Section

class _MultiSelectSection extends StatelessWidget {
  final List<String> options;
  final Set<String> selectedOptions;
  final ValueChanged<String> onTap;

  const _MultiSelectSection({
    required this.options,
    required this.selectedOptions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((option) {
        final bool isSelected =
        selectedOptions.contains(option);

        return ChoiceChip(
          label: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            child: Text(
              option,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          selected: isSelected,
          onSelected: (_) {
            onTap(option);
          },
        );
      }).toList(),
    );
  }
}


// Reusable Yes / No Selector

class _YesNoSelector extends StatelessWidget {
  final bool? value;
  final ValueChanged<bool> onChanged;

  const _YesNoSelector({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SelectionButton(
            text: 'YES',
            isSelected: value == true,
            onTap: () {
              onChanged(true);
            },
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _SelectionButton(
            text: 'NO',
            isSelected: value == false,
            onTap: () {
              onChanged(false);
            },
          ),
        ),
      ],
    );
  }
}


// Reusable Selection Button

class _SelectionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionButton({
    required this.text,
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
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// Diet Selector

class _DietSelector extends StatelessWidget {
  final String? selectedDiet;
  final ValueChanged<String> onSelected;

  const _DietSelector({
    required this.selectedDiet,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> diets = [
      'Vegetarian',
      'Non-Vegetarian',
      'Mixed',
    ];

    return Column(
      children: diets.map((diet) {
        final bool isSelected =
            selectedDiet == diet;

        return Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: Material(
            color: isSelected
                ? Theme.of(context)
                .colorScheme
                .primaryContainer
                : Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: () {
                onSelected(diet);
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                height: 58,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context)
                        .colorScheme
                        .primary
                        : Theme.of(context)
                        .colorScheme
                        .outlineVariant,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        diet,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}