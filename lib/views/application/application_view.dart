import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_app/providers/job_application_providers.dart';
import '../../models/job_application.dart';
import '../add_application/add_application.dart';

class ApplicationsView extends ConsumerWidget {
  const ApplicationsView({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationsAsync = ref.watch(
      jobApplicationViewModelProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Applications'),
      ),

      body: applicationsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, stackTrace) => Center(
          child: Text(
            'Something went wrong:\n$error',
            textAlign: TextAlign.center,
          ),
        ),

        data: (applications) {
          if (applications.isEmpty) {
            return const Center(
              child: Text('No applications found'),
            );
          }

          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              final application = applications[index];

              return _JobApplicationCard(
                application: application,
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddApplicationView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _JobApplicationCard extends ConsumerWidget {
  final JobApplication application;

  const _JobApplicationCard({
    required this.application,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: ListTile(
        title: Text(application.jobTitle),
        subtitle: Text(
          '${application.companyName}\n${application.salary}',
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'edit') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddApplicationView(
                    application: application,
                  ),
                ),
              );
            }

            if (value == 'delete')  {
              try {
                await ref
                    .read(jobApplicationViewModelProvider.notifier)
                    .deleteApplication(application.id);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Application deleted'),
                    ),
                  );
                }
              } catch (error) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete application: $error'),
                    ),
                  );
                }
              }
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'edit',
              child: Text('Edit'),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}