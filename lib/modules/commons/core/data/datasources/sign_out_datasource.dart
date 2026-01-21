import "../../domain/entities/result_wrapper.dart";

abstract class SignOutDataSource {
  Future<ResultWrapper<bool>> signOut();
}
