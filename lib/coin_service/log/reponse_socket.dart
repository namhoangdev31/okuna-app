class ResponseSocket {
  bool? success;
  ResponseSocket({this.success});
  factory ResponseSocket.fromJson(Map<String, dynamic> json) {
    return ResponseSocket(
      success: json['success'],
    );
  }
}
