class Bid {
  int driverId;
  String amount;
  String driverName;

  Bid({this.driverId, this.amount, this.driverName});

  Bid.fromJson(Map<String, dynamic> json) {
    driverId = json['driver_id'];
    driverName = json['driver_name'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_id'] = this.driverId;
    data['amount'] = this.amount;
    data['driver_name'] = this.driverName;
    return data;
  }
}