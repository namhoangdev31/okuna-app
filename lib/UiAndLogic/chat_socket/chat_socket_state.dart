part of 'chat_socket_bloc.dart';

abstract class ChatSocketState extends Equatable {
  const ChatSocketState();
  @override
  List<Object?> get props => [];
}

class ChatSocketInitial extends ChatSocketState {}

// class NewMessageState extends ChatSocketState {
//   final ChatMessage message;
//   const NewMessageState(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class NewMemberState extends ChatSocketState {
//   final InfoMemberChat newMember;
//   const NewMemberState(this.newMember);

//   @override
//   List<Object> get props => [newMember];
// }

// class UpdateGroupState extends ChatSocketState {
//   final UpdateGroupModel updateGroup;
//   const UpdateGroupState(this.updateGroup);

//   @override
//   List<Object> get props => [updateGroup];
// }

class ViewedMessageState extends ChatSocketState {
  final Map? data;
  const ViewedMessageState(this.data);

  @override
  List<Object?> get props => [data];
}
