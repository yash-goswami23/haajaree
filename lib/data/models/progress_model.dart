// ignore_for_file: public_member_api_docs, sort_constructors_first
//old app
//  val totalPresent:Int = 0,//totalDays - totalAbsent
//     val totalAbsent:Int= 0,//totalDays - totalPresent
//     val totalHolyDays:Int= 0,//totalDays - totalPresent - totalAbsent
//     val totalDays:Int= 0,//totalPresent + totalAbsent + totalHolyDays
//     val totalOverTimeHours: Int= 0,//
//     val totalOverTimeSalary:Int= 0,//monthlySalary / month = dailySalary / jobTimeHour = HourSalary * overTimeHour = ots
//     val totalSalary:Int = 0,//totalPresent * dailySalary
//     val totalIncome:Int= 0

// new app
//total hour,overtime
//total days
//total Present
//total absent
//total holy day
//overtime salary
//total salary
//total income
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProgressModel extends Equatable {
  final int totalDays;
  final int totalPresents;
  final int totalAbsents;
  final int totalHolydays;
  final int totalHour;
  final int totalHourMoney;
  final int totalSalary;
  final int totalIncome;
  final int totalHalfDays;
  const ProgressModel({
    this.totalDays = 0,
    this.totalPresents = 0,
    this.totalAbsents = 0,
    this.totalHolydays = 0,
    this.totalHour = 0,
    this.totalHourMoney = 0,
    this.totalSalary = 0,
    this.totalIncome = 0,
    this.totalHalfDays = 0,
  });
  ProgressModel copyWith({
    int? totalDays,
    int? totalPresents,
    int? totalAbsents,
    int? totalHolydays,
    int? totalHour,
    int? totalHourMoney,
    int? totalSalary,
    int? totalIncome,
    int? totalHalfDays,
  }) {
    return ProgressModel(
      totalDays: totalDays ?? this.totalDays,
      totalPresents: totalPresents ?? this.totalPresents,
      totalAbsents: totalAbsents ?? this.totalAbsents,
      totalHolydays: totalHolydays ?? this.totalHolydays,
      totalHour: totalHour ?? this.totalHour,
      totalHourMoney: totalHourMoney ?? this.totalHourMoney,
      totalSalary: totalSalary ?? this.totalSalary,
      totalIncome: totalIncome ?? this.totalIncome,
      totalHalfDays: totalHalfDays ?? this.totalHalfDays,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalDays': totalDays,
      'totalPresents': totalPresents,
      'totalAbsents': totalAbsents,
      'totalHolydays': totalHolydays,
      'totalHour': totalHour,
      'totalHourMoney': totalHourMoney,
      'totalSalary': totalSalary,
      'totalIncome': totalIncome,
      'totalHalfDays': totalHalfDays,
    };
  }

  List<Map<String, String>> listOnTitleWithValue() {
    return [
      {'title': 'Total Days', 'value': '$totalDays'},
      {'title': 'Total Presents', 'value': '$totalPresents'},
      {'title': 'Total Absents', 'value': '$totalAbsents'},
      {'title': 'Total Holidays', 'value': '$totalHolydays'},
      {'title': 'Total Half Days', 'value': '$totalHalfDays'},
      {'title': 'Total Hours', 'value': '$totalHour'},
      {'title': 'Total Hour Money', 'value': '$totalHourMoney'},
      {'title': 'Total Salary', 'value': '$totalSalary'},
      {'title': 'Total Income', 'value': '$totalIncome'},
    ];
  }

  factory ProgressModel.fromMap(Map<String, dynamic> map) {
    return ProgressModel(
      totalDays: map['totalDays'] as int,
      totalPresents: map['totalPresents'] as int,
      totalAbsents: map['totalAbsents'] as int,
      totalHolydays: map['totalHolydays'] as int,
      totalHour: map['totalHour'] as int,
      totalHourMoney: map['totalHourMoney'] as int,
      totalSalary: map['totalSalary'] as int,
      totalIncome: map['totalIncome'] as int,
      totalHalfDays: map['totalHalfDays'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProgressModel.fromJson(String source) =>
      ProgressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      totalDays,
      totalPresents,
      totalAbsents,
      totalHolydays,
      totalHour,
      totalHourMoney,
      totalSalary,
      totalIncome,
      totalHalfDays,
    ];
  }
}
