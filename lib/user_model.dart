import 'dart:convert';

class UserModel {
  final String? firstName;
  final String? lastName;
  final String? gender;

  UserModel(
    this.firstName,
    this.lastName,
    this.gender,
  );

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? gender,
  }) {
    return UserModel(
      firstName ?? this.firstName,
      lastName ?? this.lastName,
      gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['firstName'] != null ? map['firstName'] as String : null,
      map['lastName'] != null ? map['lastName'] as String : null,
      map['gender'] != null ? map['gender'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'UserModel(firstName: $firstName, lastName: $lastName, gender: $gender)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.gender == gender;
  }

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode ^ gender.hashCode;
}
