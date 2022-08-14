class SocialUserModel
{
  String? uId;
  String? name;
  String? bio;
  String? email;
  String? phone;
  String? image;
  String? cover;
  bool? isEmailVerified;
  SocialUserModel({
   this.uId,
   this.email,
   this.name,
   this.bio,
   this.phone,
   this.image,
   this.cover,
   this.isEmailVerified
  });



  SocialUserModel.fromJson(Map<String,dynamic>json)
  {
    uId = json['uId'];
    name = json['name'];
    bio = json['bio'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'uId' : uId,
        'name' : name,
        'bio' : bio,
        'email' : email,
        'phone' : phone,
        'image' : image,
        'cover' : cover,
        'isEmailVerified' : isEmailVerified,

      };
  }
/*  Map<String,dynamic> toMapCover()
  {
    return
      {
        'cover' : cover,
      };
  }
  Map<String,dynamic> toMapProfile()
  {
    return
      {
        'cover' : cover,
      };
  }*/

}