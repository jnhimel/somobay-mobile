// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Installment _$InstallmentFromJson(Map<String, dynamic> json) {
  return Installment()
    ..id = json['id'] as num
    ..amount = json['amount'] as num
    ..date = json['date'] as String
    ..approved = json['approved'] as bool;
}

Map<String, dynamic> _$InstallmentToJson(Installment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'date': instance.date,
      'approved': instance.approved
    };
