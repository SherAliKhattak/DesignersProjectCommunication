
import '../components/images.dart';
import '../utils/chat_screen_utils.dart';

class ChatContact {
  final String? name;
  final String? profilePic;
  final String? contactId;
  final DateTime? timeSent;
  final String? lastMessage;

  ChatContact({
    this.name,
    this.profilePic,
    this.contactId,
    this.timeSent,
    this.lastMessage,
  });

  toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent,
      'lastMessage': lastMessage
    };
  }

  factory ChatContact.fromJson({map}) {
    return ChatContact(
        name: map['name'],
        profilePic: map['profilePic'],
        contactId: map['contactId'],
        timeSent: ChatScreenUtils().toDateTime(map['timeSent']),
        lastMessage: map['lastMessage']);
  }
}

List<ChatContact> chats = [
  ChatContact(
    name: 'Abdul Shakoor',
    profilePic: Images.man,
    contactId: '10213',
    timeSent: DateTime(2023,5,16,11,12),
    lastMessage: 'I am availabe'
  ),ChatContact(
    name: 'Sher Ali',
    profilePic: Images.man,
    contactId: '10213',
    timeSent: DateTime(2023,5,17,13,21),
    lastMessage: 'Nice to meet you buddy'
  ),
  ChatContact(
    name: ' Ali Khan',
    profilePic: Images.man,
    contactId: '10213',
    timeSent: DateTime(2023,5,20,8,25),
    lastMessage: 'Pleasure'
  ),ChatContact(
    name: 'Yasir',
    profilePic: Images.man,
    contactId: '10213',
    timeSent: DateTime(2023,5,21,15,16),
    lastMessage: 'Pleasure to meet you'
  ),
  ChatContact(
    name: 'Mehran Ali',
    profilePic: Images.man,
    contactId: '10213',
    timeSent: DateTime(2023,5,13,9,12),
    lastMessage: 'Nice work'
  ),ChatContact(
    name: 'Flutter dev',
    profilePic: Images.man,
    contactId: '10213',
    timeSent: DateTime(2023,5,15,12,40),
    lastMessage: 'Not here'
  ),
];