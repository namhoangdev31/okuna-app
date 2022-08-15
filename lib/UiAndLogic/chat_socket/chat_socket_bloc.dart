// import 'package:Okuna/data/network/api/user.dart';
// import 'package:Okuro/models/auth/token.dart';
// import 'package:Okuro/models/chat/chat_info_member.dart';
// import 'package:Okuro/models/chat/chat_message.dart';
// import 'package:Okuro/models/chat/chat_update_group.dart';
// import 'package:Okuro/models/chat/reponse_socket.dart';
import 'package:Okuna/UiAndLogic/model/token.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../coin_service/log/reponse_socket.dart';
import '../../services/user.dart';

part 'chat_socket_event.dart';
part 'chat_socket_state.dart';

class ChatSocketBloc extends Bloc<ChatSocketEvent, ChatSocketState> {
  IO.Socket? socket;
  UserService? userService;
  ChatSocketBloc({this.userService}) : super(ChatSocketInitial()) {
    // on<ConnectWebSocketEvent>(_handleConnectWebSocketEvent);
    on<DisconnectWebSocketEvent>(_handleDisconnectWebSocketEvent);
    // on<NewMessageEvent>(_handleNewMessageEvent);
    // on<NewMemberEvent>(_handleNewMemberEvent);
    // on<UpdateGroupEvent>(_handleUpdateGroupEvent);
    on<ViewedMessageEvent>(_handleViewedMessageEvent);
  }

  // A tricker variable to determine if the chat page is visible or not
  bool isChatPageVisible = false;

  get getIsChatPageVisible => this.isChatPageVisible;

  set setIsChatPageVisible(bool isChatPageVisible) =>
      this.isChatPageVisible = isChatPageVisible;

  void setUserService(UserService? userService) {
    this.userService ??= userService;
  }

  // void connectAndListen() async {
  //   if (userService!.isLoggedIn()) {
  //     var token = await userService!.getStoredAuthToken();
  //     TokenModel tokenModel = TokenModel.fromString(token!);
  //     if (tokenModel.isExpired()) {
  //       token = await userService!.refreshToken();
  //       print("new token - WebSocketIO: $token");
  //     }

  //     final apiUrl = userService!.getApiUrlChat();
  //     if (apiUrl == null) {
  //       return;
  //     }
  //     socket ??= IO.io(
  //       apiUrl,
  //       IO.OptionBuilder().setQuery({
  //         'jwt_token': '$token',
  //         'autoConnect': false,
  //       }).setTransports(['websocket']).build(),
  //     );

  //     socket!.connect();

  //     socket!.onConnect((_) {
  //       print('socket connected');
  //     });
  //     socket!.on('Unauthorization', (data) {
  //       print('Unauthorization');
  //     });
  //     socket!.on('NewConnection', (data) {
  //       ResponseSocket response = ResponseSocket();
  //       response = ResponseSocket.fromJson(data);
  //       if (!response.success!) reconnectSocket();
  //     });
  //     // socket!.on('NewMessage', (data) {
  //     //   print('New message received: ${data['content']}');
  //     //   this.add(NewMessageEvent(ChatMessage.fromJson(data)));
  //     // });
  //     // socket!.on('NewMember', (data) {
  //     //   this.add(NewMemberEvent(InfoMemberChat.fromJson(data)));
  //     // });
  //     // socket!.on('UpdatedGroup', (data) {
  //     //   this.add(UpdateGroupEvent(UpdateGroupModel.fromJson(data)));
  //     // });
  //     socket!.on('ViewedMessage', (data) {
  //       print('ViewedMessage');
  //       this.add(ViewedMessageEvent(data));
  //     });
  //     socket!.onDisconnect((_) {
  //       print('socket disconnected');
  //     });
  //   }
  // }

  // void _handleNewMessageEvent(
  //     NewMessageEvent event, Emitter<ChatSocketState> emit) async {
  //   emit(NewMessageState(event.chatMessage));
  // }

  // void _handleNewMemberEvent(
  //     NewMemberEvent event, Emitter<ChatSocketState> emit) async {
  //   emit(NewMemberState(event.newMember));
  // }

  // void _handleUpdateGroupEvent(
  //     UpdateGroupEvent event, Emitter<ChatSocketState> emit) async {
  //   emit(UpdateGroupState(event.updateGroup));
  // }

  void _handleViewedMessageEvent(
      ViewedMessageEvent event, Emitter<ChatSocketState> emit) async {
    emit(ViewedMessageState(event.data));
  }

  // void reconnectSocket() {
  //   userService!.refreshToken();
  //   connectAndListen();
  // }

  void disconnectSocket() {
    print('disconnectSocket');
    if (socket != null) {
      socket!.dispose();
      socket = null;
    }
  }

  void _handleDisconnectWebSocketEvent(
      DisconnectWebSocketEvent event, Emitter<ChatSocketState> emit) {
    try {
      disconnectSocket();
    } catch (_) {}
  }

  // void _handleConnectWebSocketEvent(
  //     ConnectWebSocketEvent event, Emitter<ChatSocketState> emit) {
  //   try {
  //     connectAndListen();
  //   } catch (_) {}
  // }
}
