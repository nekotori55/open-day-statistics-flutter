import 'error_result.dart';

abstract class ApiResult<T> {
  const factory ApiResult.success({required T data}) = Success<T>;

  const factory ApiResult.failure({required ErrorResult error}) = Failure<T>;
}

class Success<T> implements ApiResult<T> {
  final T data;

  const Success({required this.data});
}

class Failure<T> implements ApiResult<T> {
  final ErrorResult error;

  const Failure({required this.error});
}
