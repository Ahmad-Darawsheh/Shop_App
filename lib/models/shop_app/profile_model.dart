class ProfileModel{
  late bool status;
  late String message;
  late ProfileData data;

  ProfileModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
    data=ProfileData.fromJson(json['data']);
  }

}


class ProfileData{
  late String name;
  late String email;
  late String phone;
  late String image;


  ProfileData.fromJson(Map<String,dynamic> json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
  }

}