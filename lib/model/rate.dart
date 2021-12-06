/// name : "BTC"
/// displayClose : "1.31432425425"

class Rate {
  Rate({
      this.name, 
      this.displayClose,});

  Rate.fromJson(dynamic json) {
    name = json['name'];
    displayClose = json['display_close'];
  }
  String? name;
  String? displayClose;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['display_close'] = displayClose;
    return map;
  }

}