class DayStatus {
  final int year;
  final int startMonth;
  final int startDay;
  final List days;
  DayStatus({this.year, this.startMonth, this.startDay, this.days});

  factory DayStatus.fromJSON(Map<String, dynamic> json) {
    return DayStatus(
      year: json['year'],
      startMonth: json['month'],
      startDay: json['startDay'],
      days: json['days']
    );
  }
}