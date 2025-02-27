import 'dart:math';

import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/models/chat_user.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'dart:async';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    ChatMessage(
      id: '1',
      text: 'bom dia',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Ana',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '2',
      text: 'bom dia, termos reunião hoje?',
      createdAt: DateTime.now(),
      userId: '456',
      userName: 'Bia',
      userImageUrl: 'assets/images/avatar.png',
    ),
    ChatMessage(
      id: '1',
      text: 'sim pode ser agora',
      createdAt: DateTime.now(),
      userId: '123',
      userName: 'Ana',
      userImageUrl: 'assets/images/avatar.png',
    )
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgsStream =
      Stream<List<ChatMessage>>.multi((controller) async {
    _controller = controller;
    controller.add(_msgs);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final _newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    _msgs.add(_newMessage);
    _controller?.add(_msgs.reversed.toList());
    return _newMessage;
  }
}
