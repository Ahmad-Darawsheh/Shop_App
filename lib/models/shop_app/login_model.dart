class LoginModel {
  late bool status;
  late dynamic message;
  late UserData data;

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UserData.fromJson(json['data']);
  }
}

class UserData {
  int id = 0;
  String name = "";
  String email = "";
  String phone = "";
  String image = "";
  int points = 0;
  int credit = 0;
  String token = "";

  UserData.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      name = json['name'];
      email = json['email'];
      phone = json['phone'];
      image = json['image'];
      points = json['points'];
      credit = json['credit'];
      token = json['token'];
    }
  }
}
