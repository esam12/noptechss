class NoptechHttpResponse<T> {
  NoptechHttpStatus status;
  T response;
  String message;
  NoptechHttpResponse(
      {required this.status, required this.response, required this.message});
  @override
  String toString() {
    return "{ NoptechHttpResponse : { status:$status, message:$message, response:$response}}";
  }
}

enum NoptechHttpStatus { Ok, Error }
