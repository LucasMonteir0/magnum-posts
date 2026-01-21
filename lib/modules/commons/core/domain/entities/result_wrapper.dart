import "base_error.dart";

class ResultWrapper<T> {
  final bool isSuccess;
  final T? data;
  final BaseError? error;

  ResultWrapper({required this.isSuccess, this.data, this.error});

  factory ResultWrapper.success(T data) {
    return ResultWrapper(isSuccess: true, data: data);
  }

  factory ResultWrapper.error(BaseError? error) {
    return ResultWrapper(isSuccess: false, error: error);
  }
}
