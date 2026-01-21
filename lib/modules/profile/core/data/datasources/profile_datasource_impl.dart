import "package:cloud_firestore/cloud_firestore.dart";

import "../../../../commons/core/domain/entities/result_wrapper.dart";
import "../../../../commons/utils/errors/errors.dart";
import "../../../../commons/utils/errors/handle_firebase_errors.dart";
import "../../domain/entites/profile_entity.dart";
import "../models/profile_model.dart";
import "profile_datasource.dart";

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseFirestore _firestore;

  ProfileDataSourceImpl(this._firestore);

  @override
  Future<ResultWrapper<ProfileEntity>> getProfile(String userId) async {
    try {
      final doc = await _firestore.collection("users").doc(userId).get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        return ResultWrapper.success(ProfileModel.fromJson(data));
      }
      return ResultWrapper.error(
        NotFoundError(message: "Usuário não encontrado"),
      );
    } on FirebaseException catch (e) {
      final error = handleFirebaseError(e);
      return ResultWrapper.error(error);
    } catch (e) {
      return ResultWrapper.error(UnknownError());
    }
  }
}
