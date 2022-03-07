import 'package:json_annotation/json_annotation.dart';

part 'loan.g.dart';

@JsonSerializable()
class Loan {
    Loan();

    num id;
    num loanAmount;
    num interestRate;
    num installmentAmount;
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
    
    factory Loan.fromJson(Map<String,dynamic> json) => _$LoanFromJson(json);
    Map<String, dynamic> toJson() => _$LoanToJson(this);
}
