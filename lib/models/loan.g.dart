// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loan _$LoanFromJson(Map<String, dynamic> json) {
  return Loan()
    ..id = json['id'] as num
    ..loanAmount = json['loanAmount'] as num
    ..interestRate = json['interestRate'] as num
    ..installmentAmount = json['installmentAmount'] as num
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

Map<String, dynamic> _$LoanToJson(Loan instance) => <String, dynamic>{
      'id': instance.id,
      'loanAmount': instance.loanAmount,
      'interestRate': instance.interestRate,
      'installmentAmount': instance.installmentAmount,
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
