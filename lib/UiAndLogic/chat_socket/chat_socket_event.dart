part of 'chat_socket_bloc.dart';

abstract class ChatSocketEvent extends Equatable {
  const ChatSocketEvent();

  @override
  List<Object?> get props => [];
}

class ConnectWebSocketEvent extends ChatSocketEvent {
  const ConnectWebSocketEvent();

  @override
  List<Object> get props => [];
}

class DisconnectWebSocketEvent extends ChatSocketEvent {
  const DisconnectWebSocketEvent();

  @override
  List<Object> get props => [];
}

// class NewMessageEvent extends ChatSocketEvent {
//   final ChatMessage chatMessage;
//   const NewMessageEvent(this.chatMessage);

//   @override
//   List<Object> get props => [chatMessage];
// }

// class NewMemberEvent extends ChatSocketEvent {
//   final InfoMemberChat newMember;
//   const NewMemberEvent(this.newMember);

//   @override
//   List<Object> get props => [newMember];
// }

// class UpdateGroupEvent extends ChatSocketEvent {
//   final UpdateGroupModel updateGroup;
//   const UpdateGroupEvent(this.updateGroup);

//   @override
//   List<Object> get props => [updateGroup];
// }

class ViewedMessageEvent extends ChatSocketEvent {
  final Map? data;
  const ViewedMessageEvent(this.data);

  @override
  List<Object?> get props => [data];
}
