abstract class CallBackFromServer {
  void resuiltSuccess();

  void internalServerError();

  void badRequest() {}

  void notFound() {}

  void otherResuilt() {}

  void existsRequest() {}
}

abstract class CallBackUpdateBusStatus extends CallBackFromServer {
  void onNoTag();
}

abstract class CallBack {
  void resuiltSuccess();

  void resuiltError();
}

abstract class CallBackCreateCommentCode {
  void resuiltSuccess();

  void resuiltError();

  void resuiltNoFunction();
}

abstract class CallBackReview {
  void resuiltNoFunction();
}

abstract class CallbackAdmsion extends CallBack {
  void resuiltDuplication();
}

abstract class CallBackDelete {
  void deleteSuccess();

  void deleteError();
}

abstract class CallBackDetailBus {
  void onResuilt();
  void onNoTagDetail();
}

abstract class CallBackFinishBus {
  void finishSuccess();

  void finishServerError();

  void finishbadRequest() {}

  void finishNotFound() {}

  void finishOtherResuilt() {}

  void finishExistsRequest() {}
}

abstract class CallBackGetInfoBus {
  void resuiltSuccess();

  void internalServerError();

  void badRequest() {}

  void notFound() {}

  void otherResuilt() {}

  void existsRequest() {}

  void notRole() {}
}
