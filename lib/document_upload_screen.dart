import 'package:flutter/material.dart';
import 'medical_timeline_screen.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  State<DocumentUploadScreen> createState() =>
      _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  final List<MedicalDocument> uploadedDocuments = [];

  void showUploadDialog(String documentType) {
    final TextEditingController fileNameController =
    TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Upload $documentType'),
          content: TextField(
            controller: fileNameController,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Dummy File Name',
              hintText: 'Example: Prescription_2026.pdf',
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
                final fileName = fileNameController.text.trim();

                if (fileName.isEmpty) {
                  return;
                }

                setState(() {
                  uploadedDocuments.add(
                    MedicalDocument(
                      documentType: documentType,
                      fileName: fileName,
                      date: DateTime.now(),
                    ),
                  );
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Uploaded Successfully ✓'),
                  ),
                );
              },
              child: const Text('CONFIRM'),
            ),
          ],
        );
      },
    );
  }

  void deleteDocument(int index) {
    setState(() {
      uploadedDocuments.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document deleted'),
      ),
    );
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Previous Medical Documents'),
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
                      'Upload or scan any previous medical records.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // OCR Information
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primaryContainer,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color:
                            Theme.of(context).colorScheme.primary,
                          ),

                          const SizedBox(width: 10),

                          const Expanded(
                            child: Text(
                              'Document OCR will be integrated later.',
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Upload Actions
                    _UploadActionCard(
                      icon: Icons.document_scanner_outlined,
                      title: 'Scan Prescription',
                      subtitle:
                      'Add a previous prescription document.',
                      onTap: () {
                        showUploadDialog('Prescription');
                      },
                    ),

                    const SizedBox(height: 14),

                    _UploadActionCard(
                      icon: Icons.science_outlined,
                      title: 'Upload Lab Report',
                      subtitle:
                      'Add a previous laboratory report.',
                      onTap: () {
                        showUploadDialog('Lab Report');
                      },
                    ),

                    const SizedBox(height: 14),

                    _UploadActionCard(
                      icon: Icons.local_hospital_outlined,
                      title: 'Upload Discharge Summary',
                      subtitle:
                      'Add a hospital discharge summary.',
                      onTap: () {
                        showUploadDialog('Discharge Summary');
                      },
                    ),

                    const SizedBox(height: 14),

                    _UploadActionCard(
                      icon: Icons.upload_file_outlined,
                      title: 'Upload Other Document',
                      subtitle:
                      'Add any other medical document.',
                      onTap: () {
                        showUploadDialog('Other Document');
                      },
                    ),

                    const SizedBox(height: 32),

                    // Uploaded Documents Title
                    Text(
                      'Uploaded Documents',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Empty State
                    if (uploadedDocuments.isEmpty)
                      _EmptyDocumentsCard(),

                    // Uploaded Document List
                    if (uploadedDocuments.isNotEmpty)
                      ...uploadedDocuments.asMap().entries.map(
                            (entry) {
                          final index = entry.key;
                          final document = entry.value;

                          return Padding(
                            padding:
                            const EdgeInsets.only(bottom: 12),
                            child: _DocumentCard(
                              document: document,
                              formattedDate:
                              formatDate(document.date),
                              onDelete: () {
                                deleteDocument(index);
                              },
                            ),
                          );
                        },
                      ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const MedicalTimelineScreen(),
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


// Medical Document Model

class MedicalDocument {
  final String documentType;
  final String fileName;
  final DateTime date;

  MedicalDocument({
    required this.documentType,
    required this.fileName,
    required this.date,
  });
}


// Upload Action Card

class _UploadActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _UploadActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 88,
          ),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: colorScheme.outlineVariant,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: colorScheme.primary,
                  size: 28,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Empty Documents Card

class _EmptyDocumentsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            Icons.folder_open_outlined,
            size: 50,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(height: 12),

          const Text(
            'No documents uploaded yet',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}


// Uploaded Document Card

class _DocumentCard extends StatelessWidget {
  final MedicalDocument document;
  final String formattedDate;
  final VoidCallback onDelete;

  const _DocumentCard({
    required this.document,
    required this.formattedDate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.description_outlined,
            size: 34,
            color: colorScheme.primary,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  document.documentType,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  document.fileName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 4),

                Text(
                  'Date: $formattedDate',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onDelete,
            tooltip: 'Delete document',
            icon: Icon(
              Icons.delete_outline,
              color: colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}