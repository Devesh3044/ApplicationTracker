import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/job_application.dart';
import '../providers/job_application_providers.dart';
import '../repositories/job_application_repository.dart';

class JobApplicationViewModel extends AsyncNotifier<List<JobApplication>> {
  late final JobApplicationRepository _repository;

  // List<JobApplication> applications = [];

  // JobApplicationViewModel(this._repository);
  // Read
  @override
  Future<List<JobApplication>> build() async {
    _repository = ref.read(jobApplicationRepositoryProvider);
    return await _repository.getApplications();
  }

  // void loadApplications() {
  //   applications = _repository.getApplications();
  // }
  // create
  Future<void> addApplication(JobApplication application) async {
    await _repository.addApplication(application);
    state = AsyncData([...state.value ?? [], application]);
  }

  // update
  Future<void> updateApplication(JobApplication application) async {
    await _repository.updateApplication(application);
    final currentApplication = state.value ?? [];
    state = AsyncData(
      currentApplication.map((item) {
        if (item.id == application.id) {
          return application;
        }
        return item;
      }).toList(),
    );
  }

  // delete
  Future<void> deleteApplication(String id) async {
    await _repository.deleteApplication(id);
    final currentApplication = state.value ?? [];
    state = AsyncData(
      currentApplication.where((application) => application.id != id).toList(),
    );
  }
}
