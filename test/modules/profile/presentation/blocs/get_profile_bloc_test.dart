import "package:bloc_test/bloc_test.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/commons/core/domain/entities/result_wrapper.dart";
import "package:magnum_posts/modules/commons/utils/cache/app_cache.dart";
import "package:magnum_posts/modules/commons/utils/errors/errors.dart";
import "package:magnum_posts/modules/commons/utils/states/base_state.dart";
import "package:magnum_posts/modules/profile/core/data/models/profile_model.dart";
import "package:magnum_posts/modules/profile/core/domain/entites/profile_entity.dart";
import "package:magnum_posts/modules/profile/core/domain/user_cases/get_profile/get_profile_use_case.dart";
import "package:magnum_posts/modules/profile/presentation/blocs/get_profile_bloc.dart";
import "package:mocktail/mocktail.dart";
import "package:shared_preferences/shared_preferences.dart";

class MockGetProfileUseCase extends Mock implements GetProfileUseCase {}

void main() {
  late GetProfileBloc bloc;
  late MockGetProfileUseCase mockUseCase;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({"userId": "user-123"});
    await AppCache.instance.init();
  });

  setUp(() {
    mockUseCase = MockGetProfileUseCase();
    bloc = GetProfileBloc(mockUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  const tUserId = "user-123";
  final tProfileModel = ProfileModel(
    id: tUserId,
    name: "John Doe",
    email: "john@example.com",
    age: 25,
    pictureUrl: "https://example.com/picture.jpg",
    postCount: 10,
    interests: ["Flutter", "Dart"],
  );
  final tSuccessResult = ResultWrapper.success(tProfileModel);
  final tErrorResult = ResultWrapper<ProfileModel>.error(
    NotFoundError(message: "Usuário não encontrado"),
  );

  group("[PRESENTATION] GetProfileBloc", () {
    test("InitialState", () {
      expect(bloc.state, isA<InitialState>());
    });

    blocTest<GetProfileBloc, BaseState>(
      "Bloc Success",
      build: () {
        when(
          () => mockUseCase.call(any()),
        ).thenAnswer((_) async => tSuccessResult);
        return GetProfileBloc(mockUseCase);
      },
      act: (bloc) => bloc.call(),
      expect: () => [isA<LoadingState>(), isA<SuccessState<ProfileEntity>>()],
      verify: (_) {
        verify(() => mockUseCase.call(tUserId)).called(1);
      },
    );

    blocTest<GetProfileBloc, BaseState>(
      "Bloc Error",
      build: () {
        when(
          () => mockUseCase.call(any()),
        ).thenAnswer((_) async => tErrorResult);
        return GetProfileBloc(mockUseCase);
      },
      act: (bloc) => bloc.call(),
      expect: () => [isA<LoadingState>(), isA<ErrorState>()],
      verify: (_) {
        verify(() => mockUseCase.call(tUserId)).called(1);
      },
    );
  });
}
