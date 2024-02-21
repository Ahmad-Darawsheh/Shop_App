class RegisterModel {
  late bool status;
  late dynamic message;
  late UserData data;

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = UserData.fromJson(json['data']);
  }
}

class UserData {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;

  late String token;

  UserData.fromJson(var json) {
    if (json == null) {
      id = 0;
      name = '';
      email = '';
      phone = '';
      image = '';
      token = '';
    } else {
      id = json['id'];
      name = json['name'];
      email = json['email'];
      phone = json['phone'];
      image = json['image'];
      token = json['token'];
    }
  }
}
