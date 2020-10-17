import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:messio/models/Chat.dart';
import 'package:messio/models/Message.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChatEvent extends Equatable {
  ChatEvent([List props = const <dynamic>[]]);
}

//triggered to fetch list of chats
class FetchChatListEvent extends ChatEvent {
  @override
  String toString() => 'FetchChatListEvent';

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

//triggered when stream containing list of chats has new data
class ReceivedChatsEvent extends ChatEvent {
  final List<Chat> chatList;

  ReceivedChatsEvent(this.chatList);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  String toString() => 'ReceivedChatsEvent';
}

//triggered to get details of currently open conversation
class FetchConversationDetailsEvent extends ChatEvent {
  final Chat chat;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  FetchConversationDetailsEvent(this.chat) : super([chat]);

  @override
  String toString() => 'FetchConversationDetailsEvent';
}

//triggered to fetch messages of chat, this will also keep a subscription for new messages
class FetchMessagesEvent extends ChatEvent {
  final Chat chat;
  FetchMessagesEvent(
    this.chat,
  ) : super([chat]);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  String toString() => 'FetchMessagesEvent';
}

//triggered to fetch messages of chat
class FetchPreviousMessagesEvent extends ChatEvent {
  final Chat chat;
  final Message lastMessage;
  FetchPreviousMessagesEvent(this.chat, this.lastMessage)
      : super([chat, lastMessage]);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  String toString() => 'FetchPreviousMessagesEvent';
}

//triggered when messages stream has new data
class ReceivedMessagesEvent extends ChatEvent {
  final List<Message> messages;
  final String username;
  ReceivedMessagesEvent(this.messages, this.username)
      : super([messages, username]);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  String toString() => 'ReceivedMessagesEvent';
}

//triggered to send new text message
class SendTextMessageEvent extends ChatEvent {
  final String message;

  SendTextMessageEvent(this.message) : super([message]);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  String toString() => 'SendTextMessageEvent {message: $message}';
}

//triggered to send attachment
class SendAttachmentEvent extends ChatEvent {
  final String chatId;
  final File file;
  final FileType fileType;

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  SendAttachmentEvent(this.chatId, this.file, this.fileType)
      : super([chatId, file, fileType]);

  @override
  String toString() => 'SendAttachmentEvent';
}

//triggered on page change
class PageChangedEvent extends ChatEvent {
  final int index;
  final Chat activeChat;
  PageChangedEvent(this.index, this.activeChat) : super([index, activeChat]);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  @override
  String toString() =>
      'PageChangedEvent {index: $index, activeChat: $activeChat}';
}

class RegisterActiveChatEvent extends ChatEvent {
  final String activeChatId;
  RegisterActiveChatEvent(this.activeChatId);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  String toString() =>
      'RegisterActiveChatEvent { activeChatId : $activeChatId }';
}

// hide/show emojikeyboard
class ToggleEmojiKeyboardEvent extends ChatEvent {
  final bool showEmojiKeyboard;

  ToggleEmojiKeyboardEvent(this.showEmojiKeyboard);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  @override
  String toString() => 'ToggleEmojiKeyboardEvent';
}
