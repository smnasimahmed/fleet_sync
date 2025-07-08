import 'dart:async';

/// Represents a single chat message between two users.
class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });
}

Future<List<ChatMessage>> fetchChatMessages() async {
  await Future.delayed(const Duration(milliseconds: 200)); // simulate loading

  List<ChatMessage> messages = [
    ChatMessage(
      id: 'chat1',
      senderId: 'user123',
      receiverId: 'user456',
      message: 'Hi there! How are you doing today?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    ChatMessage(
      id: 'chat2',
      senderId: 'user456',
      receiverId: 'user123',
      message: 'I\'m doing great, thanks for asking! And you?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    ChatMessage(
      id: 'chat3',
      senderId: 'user123',
      receiverId: 'user456',
      message: 'All good here! Just finishing up some work.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
  ];

  return messages;
}
