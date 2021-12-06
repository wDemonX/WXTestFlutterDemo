/// address : ""
/// logo : ""
/// name : "Ethereum"
/// symbol : "ETH"
/// type : "ETH"
class TokenItem {
  TokenItem({
    this.address,
    this.logo,
    this.name,
    this.symbol,
    this.type,});

  TokenItem.fromJson(dynamic json) {
    address = json['address'];
    logo = json['logo'];
    name = json['name'];
    symbol = json['symbol'];
    type = json['type'];
  }
  String? address;
  String? logo;
  String? name;
  String? symbol;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['logo'] = logo;
    map['name'] = name;
    map['symbol'] = symbol;
    map['type'] = type;
    return map;
  }

}