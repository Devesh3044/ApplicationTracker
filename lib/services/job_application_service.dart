import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/job_application.dart';

class JobApplicationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addApplication(JobApplication application)async{
    await _firestore.collection("job_applications").doc(application.id).set({
      'companyName': application.companyName,
      'jobTitle': application.jobTitle,
      'salary': application.salary,
      'applicationDate': Timestamp.fromDate(
        application.applicationDate,
      ),
      'status': application.status,
      'notes': application.notes,
    });
  }

  Future<void> updateApplication(JobApplication application)async{
    await _firestore.collection("job_applications").doc(application.id).update({
      'companyName': application.companyName,
      'jobTitle': application.jobTitle,
      'salary': application.salary,
      'applicationDate': Timestamp.fromDate(
        application.applicationDate,
      ),
      'status': application.status,
      'notes': application.notes,
    });
  }

  Future<List<JobApplication>> getApplications() async {
    final snapshot = await _firestore
        .collection('job_applications')
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return JobApplication(
        id: doc.id,
        companyName: data['companyName'] ?? '',
        jobTitle: data['jobTitle'] ?? '',
        salary: data['salary'] ?? '',
        applicationDate:
        (data['applicationDate'] as Timestamp).toDate(),
        status: data['status'] ?? '',
        notes: data['notes'] ?? '',
      );
    }).toList();
  }


  Future<void> deleteApplication(String id)async{
    await  _firestore.collection("job_applications").doc(id).delete();
  }


  // final List<JobApplication> _applications = [
  //   JobApplication(
  //     id: '1',
  //     companyName: 'Google',
  //     jobTitle: 'Flutter Developer',
  //     salary: '15 LPA',
  //     applicationDate: DateTime(2026, 8, 25),
  //     status: 'Applied',
  //     notes: 'Applied through LinkedIn',
  //   ),
  //   JobApplication(
  //     id: '2',
  //     companyName: 'Microsoft',
  //     jobTitle: 'Senior Flutter Developer',
  //     salary: '20 LPA',
  //     applicationDate: DateTime(2026, 8, 20),
  //     status: 'Interview',
  //     notes: 'Technical interview scheduled',
  //   ),
  //   JobApplication(
  //     id: '3',
  //     companyName: 'Amazon',
  //     jobTitle: 'Mobile Developer',
  //     salary: '18 LPA',
  //     applicationDate: DateTime(2026, 8, 15),
  //     status: 'Rejected',
  //     notes: 'Application rejected',
  //   ),
  //   JobApplication(
  //     id: '4',
  //     companyName: 'Meta',
  //     jobTitle: 'Flutter Developer',
  //     salary: '22 LPA',
  //     applicationDate: DateTime.now(),
  //     status: 'Applied',
  //     notes: 'Applied through company website',
  //   ),
  // ];

  // Read
  // List<JobApplication> getApplications() {
  //   return List.unmodifiable(_applications);
  // }

   // Create
  // void addApplication(JobApplication application) {
  //   _applications.add(application);
  // }

  // Update
  // void updateApplication(JobApplication application) {
  //   final index = _applications.indexWhere(
  //     (element) => element.id == application.id,
  //   );
  //   if (index == -1) {
  //     return;
  //   }
  //   _applications[index] = application;
  // }

  // Delete
  // void deleteApplication(String id) {
  //   _applications.removeWhere((application) => application.id == id);
  // }
}
