import 'dart:io';

import 'package:chat/core/models/chat_message.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.belongsToCurrentUser,
  });

  static const _defaultImage = 'assets/images/avatar.png';
  final ChatMessage message;
  final bool belongsToCurrentUser;

  Widget _showUserImage(String imageUrl) {
    ImageProvider? provider;

    final uri = Uri.parse(imageUrl);

    if (uri.path.contains(_defaultImage)) {
      provider = const AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: belongsToCurrentUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: belongsToCurrentUser ? Colors.grey.shade300 : Colors.amber,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(12),
              topRight: const Radius.circular(12),
              bottomLeft: belongsToCurrentUser
                  ? const Radius.circular(12)
                  : const Radius.circular(0),
              bottomRight: belongsToCurrentUser
                  ? const Radius.circular(0)
                  : const Radius.circular(12),
            ),
          ),
          width: 280,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: ListTile(
            leading: _showUserImage(message.userImageUrl),
            title: Text(
              message.userName,
              textAlign:
                  belongsToCurrentUser ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                color: belongsToCurrentUser ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(message.text,
                textAlign:
                    belongsToCurrentUser ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  color: belongsToCurrentUser ? Colors.black : Colors.white,
                )),
          ),
        ),
      ],
    );
  }
}
