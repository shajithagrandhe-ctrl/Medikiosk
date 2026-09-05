import 'package:flutter/material.dart';

class AyushHistoryScreen extends StatefulWidget {
  const AyushHistoryScreen({super.key});

  @override
  State<AyushHistoryScreen> createState() => _AyushHistoryScreenState();
}

class _AyushHistoryScreenState extends State<AyushHistoryScreen> {
  String? selectedPrakriti;
  String? selectedAgni;
  String? selectedKoshtha;
  String? selectedMeals;
  String? selectedActivity;
  String? selectedSleep;

  void continueToNextScreen() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Red Flag Detection coming next.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AYUSH Case History'),
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
                    // Subtitle
                    Text(
                      'Please answer the following questions based on your '
                          'general health and lifestyle.',
                      textAlign: TextAlign.center,
                      style:
                      Theme.of(context).textTheme.titleMedium?.copyWith(
                        height: 1.5,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Important information message
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              'These responses are collected for practitioner assessment.',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // SECTION 1
                    const _SectionTitle(
                      title: 'Prakriti Assessment',
                    ),

                    const SizedBox(height: 16),

                    _SelectionCard(
                      text: 'Thin and active',
                      isSelected:
                      selectedPrakriti == 'Thin and active',
                      onTap: () {
                        setState(() {
                          selectedPrakriti = 'Thin and active';
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    _SelectionCard(
                      text: 'Medium build',
                      isSelected:
                      selectedPrakriti == 'Medium build',
                      onTap: () {
                        setState(() {
                          selectedPrakriti = 'Medium build';
                        });
                      },
                    ),

                    const SizedBox(height: 12),

                    _SelectionCard(
                      text: 'Broad/heavy build',
                      isSelected:
                      selectedPrakriti == 'Broad/heavy build',
                      onTap: () {
                        setState(() {
                          selectedPrakriti = 'Broad/heavy build';
                        });
                      },
                    ),

                    const SizedBox(height: 32),

                    // SECTION 2
                    const _SectionTitle(
                      title: 'Agni',
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'How is your digestion?',
                      style: TextStyle(fontSize: 17),
                    ),

                    const SizedBox(height: 16),

                    _OptionGroup(
                      options: const [
                        'Strong',
                        'Irregular',
                        'Slow',
                        'Weak',
                      ],
                      selectedValue: selectedAgni,
                      onSelected: (value) {
                        setState(() {
                          selectedAgni = value;
                        });
                      },
                    ),

                    const SizedBox(height: 32),

                    // SECTION 3
                    const _SectionTitle(
                      title: 'Koshtha',
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'How are your bowel habits?',
                      style: TextStyle(fontSize: 17),
                    ),

                    const SizedBox(height: 16),

                    _OptionGroup(
                      options: const [
                        'Regular',
                        'Constipation',
                        'Loose stools',
                        'Irregular',
                      ],
                      selectedValue: selectedKoshtha,
                      onSelected: (value) {
                        setState(() {
                          selectedKoshtha = value;
                        });
                      },
                    ),

                    const SizedBox(height: 32),

                    // SECTION 4
                    const _SectionTitle(
                      title: 'Ahara',
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Meals per day',
                      style: TextStyle(fontSize: 17),
                    ),

                    const SizedBox(height: 16),

                    _OptionGroup(
                      options: const [
                        '2',
                        '3',
                        'More than 3',
                      ],
                      selectedValue: selectedMeals,
                      onSelected: (value) {
                        setState(() {
                          selectedMeals = value;
                        });
                      },
                    ),

                    const SizedBox(height: 32),

                    // SECTION 5
                    const _SectionTitle(
                      title: 'Vihara',
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Physical activity',
                      style: TextStyle(fontSize: 17),
                    ),

                    const SizedBox(height: 16),

                    _OptionGroup(
                      options: const [
                        'Low',
                        'Moderate',
                        'High',
                      ],
                      selectedValue: selectedActivity,
                      onSelected: (value) {
                        setState(() {
                          selectedActivity = value;
                        });
                      },
                    ),

                    const SizedBox(height: 32),

                    // SECTION 6
                    const _SectionTitle(
                      title: 'Sleep',
                    ),

                    const SizedBox(height: 16),

                    _OptionGroup(
                      options: const [
                        'Good',
                        'Irregular',
                        'Poor',
                      ],
                      selectedValue: selectedSleep,
                      onSelected: (value) {
                        setState(() {
                          selectedSleep = value;
                        });
                      },
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // Bottom buttons
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'BACK',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: SizedBox(
                      height: 58,
                      child: FilledButton(
                        onPressed: continueToNextScreen,
                        child: const Text(
                          'CONTINUE',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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


// Reusable section title

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}


// Reusable selection card

class _SelectionCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionCard({
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
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 64,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
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
                  text,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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


// Reusable option group

class _OptionGroup extends StatelessWidget {
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String> onSelected;

  const _OptionGroup({
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options.map((option) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _SelectionCard(
            text: option,
            isSelected: selectedValue == option,
            onTap: () {
              onSelected(option);
            },
          ),
        );
      }).toList(),
    );
  }
}