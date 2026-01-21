import "../entities/result_wrapper.dart";

abstract class SignOutRepository {
  Future<ResultWrapper<bool>> signOut();
}
