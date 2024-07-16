import 'dart:math';

import 'package:chat/components/messages.dart';
import 'package:chat/components/new_message.dart';
import 'package:chat/core/models/chat_notification.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/notifications/chat_notification_service.dart';
import 'package:chat/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cod3r chat'),
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                items: const [
                  DropdownMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Sair",
                          style: TextStyle(color: Colors.amber),
                        )
                      ],
                    ),
                  ),
                ],
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.amber,
                ),
                onChanged: (value) {
                  if (value == 'logout') {
                    AuthService().logout();
                  }
                },
              ),
            ),
            Stack(children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.amber,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) {
                        return const NotificationPage();
                      },
                    ),
                  );
                },
              ),
              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    "${Provider.of<ChatNotificationService>(context).itemsCout}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
        body: const SafeArea(
          child: Column(
            children: [
              Expanded(child: Messages()),
              NewMessage(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<ChatNotificationService>(context, listen: false).add(
              ChatNotification(
                body: Random().nextDouble().toString(),
                title: 'Main uma notificação',
              ),
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}
