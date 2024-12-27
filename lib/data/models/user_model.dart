// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String? email;
  final String? fullName;
  final String? password;
  final String? uID;
  final String? compneyName;
  final String? jobStartTime;
  final String? jobEndTime;
  final String? monthlySalary;
  final String photoUrl;
  const UserModel({
    this.email,
    this.fullName,
    this.password,
    this.uID,
    this.compneyName,
    this.jobStartTime,
    this.jobEndTime,
    this.monthlySalary,
    this.photoUrl = "",
  });
  // const UserModel(
  //     {this.email,
  //     this.fullName,
  //     this.password,
  //     this.compneyName,
  //     this.jobStartTime,
  //     this.jobEndTime,
  //     this.monthlySalary,
  //     this.uID,
  //     this.photoUrl = ""});

  // UserModel copyWith({
  //   String? email,
  //   String? fullName,
  //   String? password,
  //   String? compneyName,
  //   String? jobStartTime,
  //   String? jobEndTime,
  //   String? monthlySalary,
  //   String? uID,
  //   String? photoUrl,
  // }) {
  //   return UserModel(
  //     email: email ?? this.email,
  //     fullName: fullName ?? this.fullName,
  //     password: password ?? this.password,
  //     compneyName: compneyName ?? this.compneyName,
  //     jobStartTime: jobStartTime ?? this.jobStartTime,
  //     jobEndTime: jobEndTime ?? this.jobEndTime,
  //     monthlySalary: monthlySalary ?? this.monthlySalary,
  //     uID: uID ?? this.uID,
  //     photoUrl: photoUrl ?? this.photoUrl,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'email': email,
  //     'fullName': fullName,
  //     'password': password,
  //     'compneyName': compneyName,
  //     'jobStartTime': jobStartTime,
  //     'jobEndTime': jobEndTime,
  //     'monthlySalary': monthlySalary,
  //     'uID': uID,
  //     'photoUrl': photoUrl,
  //   };
  // }

  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     email: map['email'] != null ? map['email'] as String : null,
  //     fullName: map['fullName'] != null ? map['fullName'] as String : null,
  //     password: map['password'] != null ? map['password'] as String : null,
  //     compneyName:
  //         map['compneyName'] != null ? map['compneyName'] as String : null,
  //     jobStartTime:
  //         map['jobStartTime'] != null ? map['jobStartTime'] as String : null,
  //     jobEndTime:
  //         map['jobEndTime'] != null ? map['jobEndTime'] as String : null,
  //     monthlySalary:
  //         map['monthlySalary'] != null ? map['monthlySalary'] as String : null,
  //     uID: map['uID'] != null ? map['uID'] as String : null,
  //     photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) =>
  //     UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // List<Object> get props {
  //   return [
  //     email!,
  //     fullName!,
  //     password!,
  //     compneyName!,
  //     jobStartTime!,
  //     jobEndTime!,
  //     monthlySalary!,
  //     uID!,
  //     photoUrl!,
  //   ];
  // }

  UserModel copyWith({
    String? email,
    String? fullName,
    String? password,
    String? uID,
    String? compneyName,
    String? jobStartTime,
    String? jobEndTime,
    String? monthlySalary,
    String? photoUrl,
  }) {
    return UserModel(
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      uID: uID ?? this.uID,
      compneyName: compneyName ?? this.compneyName,
      jobStartTime: jobStartTime ?? this.jobStartTime,
      jobEndTime: jobEndTime ?? this.jobEndTime,
      monthlySalary: monthlySalary ?? this.monthlySalary,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'fullName': fullName,
      'password': password,
      'uID': uID,
      'compneyName': compneyName,
      'jobStartTime': jobStartTime,
      'jobEndTime': jobEndTime,
      'monthlySalary': monthlySalary,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] != null ? map['email'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      uID: map['uID'] != null ? map['uID'] as String : null,
      compneyName:
          map['compneyName'] != null ? map['compneyName'] as String : null,
      jobStartTime:
          map['jobStartTime'] != null ? map['jobStartTime'] as String : null,
      jobEndTime:
          map['jobEndTime'] != null ? map['jobEndTime'] as String : null,
      monthlySalary:
          map['monthlySalary'] != null ? map['monthlySalary'] as String : null,
      photoUrl: map['photoUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      email!,
      fullName!,
      password!,
      uID!,
      compneyName!,
      jobStartTime!,
      jobEndTime!,
      monthlySalary!,
      photoUrl,
    ];
  }
}
