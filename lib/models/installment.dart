import 'package:json_annotation/json_annotation.dart';

part 'installment.g.dart';

@JsonSerializable()
class Installment {
    Installment();

    num id;
    num amount;
    String date;
    bool approved;
    
    factory Installment.fromJson(Map<String,dynamic> json) => _$InstallmentFromJson(json);
    Map<String, dynamic> toJson() => _$InstallmentToJson(this);
}
