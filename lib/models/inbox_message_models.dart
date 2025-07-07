import 'dart:async'; // Required for Future

enum RequestStatus { pending, accepted, declined }

class InboxMessage {
  final String id;
  final String senderId; // Added senderId as per your definition
  final String senderName;
  final String lastMessage;
  final String time;
  final String profileImageUrl;
  final int unreadCount;

  final bool isRequest; // true if this is a request needing action
  final RequestStatus? requestStatus; // null if isRequest == false

  // Constructor for the InboxMessage class
  InboxMessage({
    required this.id,
    required this.senderId, // Required in constructor
    required this.senderName,
    required this.lastMessage,
    required this.time,
    required this.profileImageUrl,
    required this.unreadCount,
    this.isRequest = false, // Default value
    this.requestStatus, // Nullable
  });
}

Future<List<InboxMessage>> fetchInboxMessages() async {
  // Simulate a network delay or database query
  await Future.delayed(const Duration(milliseconds: 200));

  // Manually create a list of InboxMessage objects with mixed request types
  List<InboxMessage> messages = [
    InboxMessage(
      id: 'msg1',
      senderId: 'user_alice',
      senderName: 'Alice',
      lastMessage: 'Hey, are you free for a call tomorrow?',
      time: '10:30 AM',
      profileImageUrl: 'assets/profile_pics/person_alice.jpeg',
      unreadCount: 2,
      isRequest: false, // Not a request
    ),
    InboxMessage(
      id: 'msg2',
      senderId: 'user_bob',
      senderName: 'Bob',
      lastMessage: 'Don\'t forget about the meeting at 2 PM.',
      time: 'Yesterday',
      profileImageUrl: 'assets/profile_pics/person_bob.jpeg',
      unreadCount: 0,
      isRequest: false,
    ),
    InboxMessage(
      id: 'msg3',
      senderId: 'user_charlie',
      senderName: 'Charlie',
      lastMessage: 'Connection request from Charlie.',
      time: 'Mon',
      profileImageUrl: 'assets/profile_pics/person_charlie.jpeg',
      unreadCount: 1,
      isRequest: true, // This is a request
      requestStatus: RequestStatus.pending, // Pending status
    ),
    InboxMessage(
      id: 'msg4',
      senderId: 'user_david',
      senderName: 'David',
      lastMessage: 'Your request has been accepted!',
      time: 'Sun',
      profileImageUrl: 'assets/profile_pics/person_david.jpeg',
      unreadCount: 0,
      isRequest: true, // This is a request
      requestStatus: RequestStatus.accepted, // Accepted status
    ),
    InboxMessage(
      id: 'msg5',
      senderId: 'user_eve',
      senderName: 'Eve',
      lastMessage: 'Happy Birthday!',
      time: 'Last Week',
      profileImageUrl: 'assets/profile_pics/person_eve.jpeg',
      unreadCount: 0,
      isRequest: false,
    ),
    InboxMessage(
      id: 'msg6',
      senderId: 'user_frank',
      senderName: 'Frank',
      lastMessage: 'Got it, thanks!',
      time: '09:15 AM',
      profileImageUrl: 'assets/profile_pics/person_frank.jpeg',
      unreadCount: 3,
      isRequest: false,
    ),
    InboxMessage(
      id: 'msg7',
      senderId: 'user_grace',
      senderName: 'Grace',
      lastMessage: 'Invitation to join group "Project Alpha".',
      time: '11:00 AM',
      profileImageUrl: 'assets/profile_pics/person_grace.jpeg',
      unreadCount: 0,
      isRequest: true, // Another request
      requestStatus: RequestStatus.pending,
    ),
    InboxMessage(
      id: 'msg8',
      senderId: 'user_heidi',
      senderName: 'Heidi',
      lastMessage: 'Your previous request was declined.',
      time: 'Yesterday',
      profileImageUrl: 'assets/profile_pics/person_heidi.jpeg',
      unreadCount: 0,
      isRequest: true, // A declined request
      requestStatus: RequestStatus.declined,
    ),
    InboxMessage(
      id: 'msg9',
      senderId: 'user_ivan',
      senderName: 'Ivan',
      lastMessage: 'New update available.',
      time: 'Tue',
      profileImageUrl: 'assets/profile_pics/person_ivan.jpeg',
      unreadCount: 1,
      isRequest: false,
    ),
    InboxMessage(
      id: 'msg10',
      senderId: 'user_judy',
      senderName: 'Judy',
      lastMessage: 'Can you approve the timesheet?',
      time: 'Sat',
      profileImageUrl: 'assets/profile_pics/person_judy.jpeg',
      unreadCount: 0,
      isRequest: true, // Another request
      requestStatus: RequestStatus.pending,
    ),
    InboxMessage(
      id: 'msg11',
      senderId: 'user_kyle',
      senderName: 'Kyle',
      lastMessage: 'Your package has arrived.',
      time: 'Fri',
      profileImageUrl: 'assets/profile_pics/person_kyle.jpeg',
      unreadCount: 0,
      isRequest: false,
    ),
    InboxMessage(
      id: 'msg12',
      senderId: 'user_liam',
      senderName: 'Liam',
      lastMessage: 'Confirming our appointment.',
      time: '08:00 AM',
      profileImageUrl: 'assets/profile_pics/person_liam.jpeg',
      unreadCount: 5,
      isRequest: false,
    ),
  ];

  return messages;
}
