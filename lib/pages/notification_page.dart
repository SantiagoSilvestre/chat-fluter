import 'package:chat/core/services/notifications/chat_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
      ),
      body: ListView.builder(
          itemCount: service.itemsCout,
          itemBuilder: (ctx, index) => ListTile(
                title: Text(items[index].title),
                subtitle: Text(items[index].body),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    service.remove(index);
                  },
                ),
              )),
    );
  }
}
