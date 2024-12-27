import 'dart:convert';

import 'package:equatable/equatable.dart';
// / holiday, absent, present, presents with overtime, only presents, only hour, halfday

class HomeModel extends Equatable {
  final String dutyStatus;
  final String? overTime;
  final String day;
  final String date;
  const HomeModel({
    required this.dutyStatus,
    this.overTime,
    required this.day,
    required this.date,
  });

  HomeModel copyWith({
    String? dutyStatus,
    String? overTime,
    String? day,
    String? date,
  }) {
    return HomeModel(
      dutyStatus: dutyStatus ?? this.dutyStatus,
      overTime: overTime ?? this.overTime,
      day: day ?? this.day,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dutyStatus': dutyStatus,
      'overTime': overTime,
      'day': day,
      'date': date,
    };
  }

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      dutyStatus: map['dutyStatus'] as String,
      overTime: map['overTime'] != null ? map['overTime'] as String : null,
      day: map['day'] as String,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeModel.fromJson(String source) =>
      HomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [dutyStatus, overTime!, day, date];
}
