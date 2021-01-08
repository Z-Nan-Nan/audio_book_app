class DataTransfer {
  final int status;
  final data;
  DataTransfer({ this.status, this.data });

  factory DataTransfer.fromJSON(Map<String, dynamic> json) {
    return DataTransfer(
        status: json['status'],
        data: json['data']
    );
  }
}