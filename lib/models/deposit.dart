import 'package:json_annotation/json_annotation.dart';

part 'deposit.g.dart';

@JsonSerializable()
class Deposit {
    Deposit();

    num id;
    num depositAmount;
    num interestRate;
    num period;
    num duration;
    num targetAmount;
    num totalAmount;
    String startDate;
    bool approved;
    bool active;
    bool delayed;
    bool complete;
    String endDate;
    
    factory Deposit.fromJson(Map<String,dynamic> json) => _$DepositFromJson(json);
    Map<String, dynamic> toJson() => _$DepositToJson(this);
}
