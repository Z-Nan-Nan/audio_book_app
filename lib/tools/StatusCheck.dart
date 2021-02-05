class StatusCheck {
  final int status;
  final String desc;
  final String rId;
  StatusCheck({ this.status, this.desc, this.rId });

  factory StatusCheck.fromJSON(Map<String, dynamic> json) {
    return StatusCheck(
        status: json['status'],
        desc: json['desc'],
        rId: json['r_id']
    );
  }
}