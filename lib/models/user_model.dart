// import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  bool? isCR;

  UserModel(
      {this.userId, this.email, this.firstName, this.lastName, this.isCR});

  // Fetch data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
      userId: map['userId'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      isCR: map['isCR'],
    );
  }

  // Send data to the server
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'isCR': isCR,
    };
  }
}
