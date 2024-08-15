part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSuccess extends ChatState {
  final List<dynamic> messages;
  ChatSuccess({required this.messages});
}

final class ChatError extends ChatState {
  final String err;
  ChatError({required this.err});
}
