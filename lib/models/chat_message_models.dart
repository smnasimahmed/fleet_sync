import 'dart:async'; // Required for Future

class ChatMessage {
  // Properties of the ChatMessage class
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;

  // Constructor for the ChatMessage class
  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });
}

/// A function that simulates fetching a list of ChatMessage objects asynchronously.
///
/// Returns a Future that completes with a List of ChatMessage objects.
Future<List<ChatMessage>> fetchChatMessages() async {
  // Simulate a network delay or database query
  await Future.delayed(const Duration(seconds: 2));

  // Manually create a list of ChatMessage objects
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
    ChatMessage(
      id: 'chat4',
      senderId: 'user789',
      receiverId: 'user123',
      message: 'Hey, did you get my email about the project?',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    ChatMessage(
      id: 'chat5',
      senderId: 'user123',
      receiverId: 'user789',
      message: 'Yes, just saw it. I\'ll get back to you shortly.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 5)),
    ),
    ChatMessage(
      id: 'chat6',
      senderId: 'user456',
      receiverId: 'user789',
      message: 'The new feature is live!',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ChatMessage(
      id: 'chat7',
      senderId: 'user101',
      receiverId: 'user202',
      message: 'Can we schedule a call for next week?',
      timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
    ),
    ChatMessage(
      id: 'chat8',
      senderId: 'user202',
      receiverId: 'user101',
      message: 'Sure, what time works best for you?',
      timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 2)),
    ),
    ChatMessage(
      id: 'chat9',
      senderId: 'user303',
      receiverId: 'user123',
      message: 'Remember to submit your report by Friday.',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ChatMessage(
      id: 'chat10',
      senderId: 'user123',
      receiverId: 'user303',
      message: 'Will do! Thanks for the reminder.',
      timestamp: DateTime.now().subtract(const Duration(days: 3, minutes: 10)),
    ),
    ChatMessage(
      id: 'chat11',
      senderId: 'user404',
      receiverId: 'user456',
      message: 'I\'ve sent you the revised proposal.',
      timestamp: DateTime.now().subtract(const Duration(days: 4)),
    ),
    ChatMessage(
      id: 'chat12',
      senderId: 'user456',
      receiverId: 'user404',
      message: 'Received, I\'ll take a look.',
      timestamp: DateTime.now().subtract(const Duration(days: 4, minutes: 15)),
    ),
  ];

  return messages;
}

// Example of how to use the Future<List<ChatMessage>>
// void main() async {
//   print("Fetching chat messages...");

//   // Await the future to get the list of messages
//   List<ChatMessage> chatMessages = await fetchChatMessages();

//   print("\nChat Messages Fetched (${chatMessages.length} total):\n");
//   for (var message in chatMessages) {
//     message.displayInfo();
//   }
// }
