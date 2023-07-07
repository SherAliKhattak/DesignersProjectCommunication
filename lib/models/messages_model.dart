

import 'package:elabd_project/utils/chat_screen_utils.dart';

import '../components/enums.dart';

class Messages {
  String? senderId;
  String? receiverId;
  String? message;
  MessageEnum? type;
  DateTime? date;
  String? isSentByme;
  String? messageId;
  bool? isSeen;

  Messages(
      {this.message,
      this.date,
      this.isSentByme,
      this.isSeen,
      this.messageId,
      this.senderId,
      this.receiverId,
      this.type});

  Messages.fromJson(map) {
    senderId = map['senderId'] ?? '';
    receiverId = map['receiverId'] ?? '';
    date = ChatScreenUtils().toDateTime(map['date']);
    isSentByme = map['isSentByme'] ?? '';
    isSeen = map['isSeen'] ?? '';
    message = map['message'] ?? '';
    type = (map['type'] as String).toEnum();
    messageId = map['messageId'] ?? '';
  }

  toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'date': date,
      'isSentByme': isSentByme,
      'isSeen': isSeen,
      'message': message,
      'type': type!.type,
      'messageId': messageId
    };
  }
}

