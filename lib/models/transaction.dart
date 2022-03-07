import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
    Transaction();

    num id;
    num amount;
    String date;
    bool approved;
    
    factory Transaction.fromJson(Map<String,dynamic> json) => _$TransactionFromJson(json);
    Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
