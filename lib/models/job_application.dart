class JobApplication {
  final String id;
  final String companyName;
  final String jobTitle;
  final String salary;
  final DateTime applicationDate;
  final String status;
  final String notes;

  JobApplication({
    required this.id,
    required this.companyName,
    required this.jobTitle,
    required this.salary,
    required this.applicationDate,
    required this.status,
    required this.notes,
  });
}