import "package:firebase_auth/firebase_auth.dart";

import "../../../utils/errors/errors.dart";
import "../../../utils/errors/handle_firebase_errors.dart";
import "../../domain/entities/result_wrapper.dart";
import "sign_out_datasource.dart";

class SignOutDataSourceImpl implements SignOutDataSource {
  final FirebaseAuth _auth;

  SignOutDataSourceImpl(this._auth);

  @override
  Future<ResultWrapper<bool>> signOut() async {
    try {
      await _auth.signOut();
      return ResultWrapper.success(true);
    } on FirebaseAuthException catch (e) {
      final error = handleFirebaseError(e);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError());
    }
  }
}
