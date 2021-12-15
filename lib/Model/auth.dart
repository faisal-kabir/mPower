class Auth {
  Auth({
      this.token, 
      this.user,});

  Auth.fromJson(dynamic json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  String? token;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      this.pk, 
      this.username, 
      this.email, 
      this.firstName, 
      this.lastName,});

  User.fromJson(dynamic json) {
    pk = json['pk'];
    username = json['username'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }
  int? pk;
  String? username;
  String? email;
  String? firstName;
  String? lastName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pk'] = pk;
    map['username'] = username;
    map['email'] = email;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    return map;
  }

}