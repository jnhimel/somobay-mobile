import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    num userId;
    String firstName;
    String lastName;
    String email;
    String phoneNumber;
    String dateOfBirth;
    num age;
    String createDate;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}
