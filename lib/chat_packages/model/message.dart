class Message {
  final String userId;
  final String userName;
  final String message;
  final DateTime createdAt;

  const Message({
    required this.userId,
    required this.userName,
    required this.message,
    required this.createdAt,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        userId: json['userId'],
        userName: json['userName'],
        message: json['message'],
        createdAt: json['createdAt']?.toDate(),
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userName': userName,
        'message': message,
        'createdAt': createdAt.toUtc(),
      };
}
