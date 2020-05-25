class LoginReq {
  String username;
  String password;

  LoginReq(this.username, this.password);

  LoginReq.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        password = json["password"];

  Map<String, dynamic> toJson() {
    return {
      "username": this.username,
      "password": this.password,
    };
  }
}

class RegisterReq {
  String username;
  String password;
  String repassword;

  RegisterReq(this.username, this.password, this.repassword);

  RegisterReq.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        password = json["password"],
        repassword = json["repassword"];


  Map<String, dynamic> toJson() {
    return {
      "username": this.username,
      "password": this.password,
      "repassword": this.repassword,
    };
  }
}

//用户信息
class UserModel {
  String username;
  String password;
  String email;
  String icon;
  int id;

  UserModel.fromJson(Map<String, dynamic> json)
      : username = json["username"],
        password = json["password"],
        email = json["email"],
        icon = json["icon"],
        id = json["id"];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'email': email,
        'icon': icon,
        'id': id
      };

  @override
  String toString() {
    return 'UserModel{username: $username, password: $password, email: $email, icon: $icon, id: $id}';
  }
}
