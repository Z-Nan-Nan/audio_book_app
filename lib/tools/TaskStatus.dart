class TaskStatus {
  final List status;
  TaskStatus({this.status});

  factory TaskStatus.fromJSON(Map<String, dynamic> json) {
    return TaskStatus(
      status: json['status']
    );
  }
}