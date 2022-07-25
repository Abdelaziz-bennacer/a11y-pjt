class UserResources {
  String? id;
  String? name;
  //String? firstName;
  //final String description;
  //String? email;
  String? imageAvatar;
  //final String calendar;
  //String? fonction;

  UserResources({
    this.id,
    this.name,
    //this.firstName,
    //required this.description,
    //this.email,
    this.imageAvatar,
    //this.tasks,
    //required this.calendar,
    //this.fonction,
  });

  UserResources.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['username'];
    //firstName = json['firstname'];
    //email = json['email'];
    //fonction = json['fonction'];
    imageAvatar = json['avatar'] == null ? null : json['avatar']['formats']['small']['url'];
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": name,
    //"email": email,
    //"fonction": fonction,
    //"firstname": firstName,
    "avatar": imageAvatar,
  };

  @override
  String toString() {
    return 'User{id: $id, name: $name}';
  }
}