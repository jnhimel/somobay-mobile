// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deposit _$DepositFromJson(Map<String, dynamic> json) {
  return Deposit()
    ..id = json['id'] as num
    ..depositAmount = json['depositAmount'] as num
    ..interestRate = json['interestRate'] as num
    ..period = json['period'] as num
    ..duration = json['duration'] as num
    ..targetAmount = json['targetAmount'] as num
    ..totalAmount = json['totalAmount'] as num
    ..startDate = json['startDate'] as String
    ..approved = json['approved'] as bool
    ..active = json['active'] as bool
    ..delayed = json['delayed'] as bool
    ..complete = json['complete'] as bool
    ..endDate = json['endDate'] as String;
}

Map<String, dynamic> _$DepositToJson(Deposit instance) => <String, dynamic>{
      'id': instance.id,
      'depositAmount': instance.depositAmount,
      'interestRate': instance.interestRate,
      'period': instance.period,
      'duration': instance.duration,
      'targetAmount': instance.targetAmount,
      'totalAmount': instance.totalAmount,
      'startDate': instance.startDate,
      'approved': instance.approved,
      'active': instance.active,
      'delayed': instance.delayed,
      'complete': instance.complete,
      'endDate': instance.endDate
    };
