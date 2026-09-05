import 'package:flutter/material.dart';
import 'consent_screen.dart';

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key});

  @override
  State<PatientRegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState
    extends State<PatientRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController abhaController = TextEditingController();

  String? selectedGender;

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    mobileController.dispose();
    abhaController.dispose();
    super.dispose();
  }
  void continueRegistration() {
    bool isGenderSelected = selectedGender != null;

    if (_formKey.currentState!.validate() && isGenderSelected) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ConsentScreen(),
        ),
      );
    } else {
      if (!isGenderSelected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select your gender.'),
          ),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Information'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Progress Indicator
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: LinearProgressIndicator(
                  value: 0.3,
                  minHeight: 8,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please enter your details',
                        style:
                        Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Full Name
                      TextFormField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Enter your full name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                        style: const TextStyle(fontSize: 18),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Age
                      TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                          hintText: 'Enter your age',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.cake_outlined),
                        ),
                        style: const TextStyle(fontSize: 18),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your age';
                          }

                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid age';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      // Gender
                      Text(
                        'Gender',
                        style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: _GenderCard(
                              label: 'Male',
                              icon: Icons.male,
                              isSelected: selectedGender == 'Male',
                              onTap: () {
                                setState(() {
                                  selectedGender = 'Male';
                                });
                              },
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: _GenderCard(
                              label: 'Female',
                              icon: Icons.female,
                              isSelected: selectedGender == 'Female',
                              onTap: () {
                                setState(() {
                                  selectedGender = 'Female';
                                });
                              },
                            ),
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: _GenderCard(
                              label: 'Other',
                              icon: Icons.person_outline,
                              isSelected: selectedGender == 'Other',
                              onTap: () {
                                setState(() {
                                  selectedGender = 'Other';
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Mobile Number
                      TextFormField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Mobile Number',
                          hintText: 'Enter your mobile number',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone_outlined),
                        ),
                        style: const TextStyle(fontSize: 18),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your mobile number';
                          }

                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid mobile number';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // ABHA ID
                      TextFormField(
                        controller: abhaController,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: 'ABHA ID (Optional)',
                          hintText: 'Enter your ABHA ID',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.badge_outlined),
                        ),
                        style: const TextStyle(fontSize: 18),
                      ),

                      const SizedBox(height: 16),

                      // Guest Option
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Don't have an ABHA ID?",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),

                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'You can continue as a guest.',
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'Continue as Guest',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
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
                    onPressed: continueRegistration,
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
      ),
    );
  }
}

class _GenderCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderCard({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primaryContainer
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurface,
            ),

            const SizedBox(height: 8),

            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}