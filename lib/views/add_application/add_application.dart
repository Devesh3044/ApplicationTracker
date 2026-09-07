import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_app/providers/job_application_providers.dart';
import '../../models/job_application.dart';

class AddApplicationView extends ConsumerStatefulWidget {
  final JobApplication? application;

  const AddApplicationView({super.key, this.application});

  @override
  ConsumerState<AddApplicationView> createState() => _AddApplicationViewState();
}

class _AddApplicationViewState extends ConsumerState<AddApplicationView> {
  // late final JobApplicationViewModel _viewModel;

  final _formKey = GlobalKey<FormState>();

  final _companyController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _salaryController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedStatus = 'Applied';

  @override
  void initState() {
    super.initState();
    final application = widget.application;
    if (application != null) {
      _companyController.text = application.companyName;
      _jobTitleController.text = application.jobTitle;
      _salaryController.text = application.salary;
      _selectedStatus = application.status;
      _notesController.text = application.notes;
    }
  }

  @override
  void dispose() {
    _companyController.dispose();
    _jobTitleController.dispose();
    _salaryController.dispose();
    _notesController.dispose();

    super.dispose();
  }

  void _saveApplication() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final existingApplication = widget.application;
    final application = JobApplication(
      id:
          existingApplication?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      companyName: _companyController.text.trim(),
      jobTitle: _jobTitleController.text.trim(),
      salary: _salaryController.text.trim(),
      applicationDate: DateTime.now(),
      status: _selectedStatus,
      notes: _notesController.text.trim(),
    );
    if (existingApplication == null) {
      ref
          .read(jobApplicationViewModelProvider.notifier)
          .addApplication(application);
    } else {
      ref
          .read(jobApplicationViewModelProvider.notifier)
          .updateApplication(application);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.application == null
            ? Text('Add Application')
            : Text('Edit Application'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _companyController,
              decoration: const InputDecoration(
                labelText: 'Company Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter company name';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _jobTitleController,
              decoration: const InputDecoration(
                labelText: 'Job Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Enter job title';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _salaryController,
              decoration: const InputDecoration(
                labelText: 'Salary',
                hintText: 'Example: 15 LPA',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              initialValue: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Applied', child: Text('Applied')),
                DropdownMenuItem(value: 'Interview', child: Text('Interview')),
                DropdownMenuItem(value: 'Offer', child: Text('Offer')),
                DropdownMenuItem(value: 'Rejected', child: Text('Rejected')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedStatus = value;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _notesController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _saveApplication,
                child: widget.application ==null? const Text('Add Application') : const Text('Update Application'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
