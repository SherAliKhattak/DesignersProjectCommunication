
import 'package:elabd_project/utils/chat_screen_utils.dart';
class DesignersModel{
  String? uid;
  String? email;
  String? name;
  String? image;
  String? bio;
  DateTime? createdAt;
  String? experience;
  

  DesignersModel({
    this.name, this.image,this.bio, this.experience, this.uid,this.createdAt, this.email
  });

   factory DesignersModel.fromJson(map) {
    return DesignersModel(
        email: map['email'] ?? '',
        name: map['name'] ?? '',
        bio: map['bio'] ?? '',
        image: map['image'] ?? '',
        createdAt: ChatScreenUtils().toDateTime(map['createdAt']), 
        experience: map['experience'],
        uid: map['uid'] ?? '');
  }
  toFirebase() {
    return {
      "uid": uid,
      "name": name,
      "image": image,
      "createdAt": createdAt,
      "bio": bio,
      "experience": experience,
      "email": email
    };
  }
}

