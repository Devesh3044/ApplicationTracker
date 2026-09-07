import '../models/job_application.dart';
import '../services/job_application_service.dart';

class JobApplicationRepository {
  final JobApplicationService _service;

  JobApplicationRepository(this._service);

  Future<List<JobApplication>> getApplications() async{
    return await _service.getApplications();
  }

  Future<void> addApplication(JobApplication application)async{
   await _service.addApplication(application);
  }

  Future<void> updateApplication(JobApplication application)async{
   await _service.updateApplication(application);
  }
 Future<void> deleteApplication(String id)async{
    await _service.deleteApplication(id);
  }
}