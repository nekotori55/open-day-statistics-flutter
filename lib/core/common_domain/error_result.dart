class ErrorResult {
  const ErrorResult({
    this.statusCode,
    this.message,
  });

  final int? statusCode;
  final String? message;
}
