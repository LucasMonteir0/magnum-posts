import "package:firebase_auth/firebase_auth.dart";

import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../../../commons/utils/errors/errors.dart";
import "../../../../commons/utils/errors/handle_firebase_errors.dart";
import "auth_datasource.dart";

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _auth;

  AuthDataSourceImpl(this._auth);
  @override
  Future<ResultWrapper<String>> signIn(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return ResultWrapper.success(result.user!.uid);
    } on FirebaseAuthException catch (e) {
      final error = handleFirebaseError(e);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError());
    }
  }
}
