import 'package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart';

abstract class AuthRepository {
  Future<ResultWrapper<bool>> signIn(String email, String password);
}
