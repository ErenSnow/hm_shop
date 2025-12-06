import 'package:get/get.dart';

class UserController extends GetxController {
  var user = UserInfo.fromJson({}).obs;

  updateUser(UserInfo user) {
    this.user.value = user;
  }
}

class UserInfo {
  final String? id;
  final String? name;
  final String? avatar;
  final String? phone;
  final String? email;
  final String? token;
  UserInfo({this.id, this.name, this.avatar, this.phone, this.email, this.token});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(id: json['id'], name: json['name'], avatar: json['avatar'], phone: json['phone'], email: json['email'], token: json['token']);
  }
}
