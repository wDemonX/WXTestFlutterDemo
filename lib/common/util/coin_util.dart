import 'package:intl/intl.dart';
import 'package:viawallet_flutter/model/token_item.dart';


/// 是否token.
bool isToken(TokenItem? tokenItem) {

  var type = tokenItem?.type ?? "";
  var symbol = tokenItem?.symbol ?? "";
  var address = tokenItem?.address ?? "";

  if ('SLP' == type) {
    return true;
  }

  if (address.isEmpty) {
    //主要用于CET Token的判断

    return type.toLowerCase() != symbol.toLowerCase();
  } else {
    return true;
  }

}

bool isTrxToken(TokenItem tokenItem) {
  String type = tokenItem.type ?? "";
  String address = tokenItem.address ?? "";
  return 'TRX' == type.toUpperCase() && address.isNotEmpty;
}


String getChain(TokenItem tokenItem) {
  String type = tokenItem.type ?? "";

  if ('SLP' == type) {
    return 'BCH';
  } else if (isTrxToken(tokenItem)) {
    return 'TRX';
  } else {
    return type;
  }
}