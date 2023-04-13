class HttpException implements Exception{
  final String messageException;
  HttpException(this.messageException);

  @override
  String toString() {
    return messageException;
  }
}