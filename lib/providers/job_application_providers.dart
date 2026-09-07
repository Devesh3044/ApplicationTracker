

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_app/repositories/job_application_repository.dart';
import 'package:new_app/services/job_application_service.dart';
import 'package:new_app/view_models/job_application_view_model.dart';
import '../models/job_application.dart';
final jobApplicationServiceProvider = Provider<JobApplicationService>((ref){
  return JobApplicationService();
});

final jobApplicationRepositoryProvider = Provider<JobApplicationRepository>((ref){
  final service = ref.watch(jobApplicationServiceProvider);
  return JobApplicationRepository(service);
});

final jobApplicationViewModelProvider = AsyncNotifierProvider<JobApplicationViewModel, List<JobApplication>>(
  JobApplicationViewModel.new
);