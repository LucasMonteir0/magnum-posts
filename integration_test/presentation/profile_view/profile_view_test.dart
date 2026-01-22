import "package:bloc_test/bloc_test.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/widgets.dart";
import "package:flutter_modular/flutter_modular.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:magnum_posts/modules/commons/core/data/datasources/sign_out_datasource.dart";
import "package:magnum_posts/modules/commons/presentation/blocs/sign_out_bloc.dart";
import "package:magnum_posts/modules/commons/presentation/components/app_button.dart";
import "package:magnum_posts/modules/commons/presentation/components/app_error_view.dart";
import "package:magnum_posts/modules/commons/presentation/components/custom_app_bar.dart";
import "package:magnum_posts/modules/commons/presentation/components/loading_indicator.dart";
import "package:magnum_posts/modules/commons/utils/config/firebase_options.dart";
import "package:magnum_posts/modules/commons/utils/config/routes.dart";
import "package:magnum_posts/modules/commons/utils/states/base_state.dart";
import "package:magnum_posts/modules/profile/core/domain/entites/profile_entity.dart";
import "package:magnum_posts/modules/profile/presentation/blocs/get_profile_bloc.dart";
import "package:magnum_posts/modules/profile/presentation/views/profile_view.dart";
import "package:magnum_posts/modules/profile/profile_module.dart";
import "package:mocktail/mocktail.dart";
import "package:modular_test/modular_test.dart";

import "../../../test/run_test_widget.dart";

class MockGetProfileBloc extends MockCubit<BaseState>
    implements GetProfileBloc {}

class MockSignOutBloc extends MockCubit<BaseState> implements SignOutBloc {}

class MockSignOutDataSource extends Mock implements SignOutDataSource {}

class MockIModularNavigator extends Mock implements IModularNavigator {}

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  late MockGetProfileBloc mockGetProfileBloc;
  late MockSignOutBloc mockSignOutBloc;
  late MockIModularNavigator mockNavigator;

  setUp(() {
    mockGetProfileBloc = MockGetProfileBloc();
    mockSignOutBloc = MockSignOutBloc();
    mockNavigator = MockIModularNavigator();

    initModule(
      ProfileModule(),
      replaceBinds: [
        Bind.instance<GetProfileBloc>(mockGetProfileBloc),
        Bind.instance<SignOutBloc>(mockSignOutBloc),
      ],
    );

    Modular.navigatorDelegate = mockNavigator;
  });

  tearDown(() {
    mockGetProfileBloc.close();
    mockSignOutBloc.close();
  });

  final tProfile = ProfileEntity(
    id: "abcd",
    name: "User Name",
    email: "user@email.com",
    pictureUrl: "https://example.com/avatar.png",
    postCount: 10,
    interests: ["Flutter", "Dart", "Mobile"],
    age: 18,
  );

  testWidgets("[INTEGRATION] ProfileView - Load Success and Sign Out", (
    tester,
  ) async {
    when(() => mockGetProfileBloc.state).thenReturn(const LoadingState());
    when(() => mockGetProfileBloc.call()).thenAnswer((_) async {});
    whenListen(
      mockGetProfileBloc,
      Stream.fromIterable([SuccessState<ProfileEntity>(tProfile)]),
      initialState: const LoadingState(),
    );

    when(() => mockSignOutBloc.state).thenReturn(const InitialState());
    when(() => mockSignOutBloc.call()).thenAnswer((_) async {});
    whenListen(
      mockSignOutBloc,
      Stream.fromIterable([
        const LoadingState(),
        const SuccessState<bool>(true),
      ]),
      initialState: const InitialState(),
    );
    when(
      () => mockNavigator.pushNamedAndRemoveUntil(
        Routes.auth + Routes.signIn,
        any<RoutePredicate>(),
      ),
    ).thenAnswer((_) async {
      return null;
    });

    await tester.pumpWidget(runPageTest(const ProfileView()));
    await tester.pumpAndSettle();

    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.text(tProfile.name), findsOneWidget);
    expect(find.text(tProfile.email), findsOneWidget);
    expect(find.text(tProfile.postCount.toString()), findsOneWidget);
    expect(find.text(tProfile.age.toString()), findsOneWidget);

    verify(() => mockGetProfileBloc.call()).called(1);

    final signOutButton = find.widgetWithText(AppButton, "Sair");
    expect(signOutButton, findsOneWidget);

    await tester.tap(signOutButton);
    await tester.pump();
    await tester.pump();

    verify(() => mockSignOutBloc.call()).called(1);
    verify(
      () => mockNavigator.pushNamedAndRemoveUntil(
        Routes.auth + Routes.signIn,
        any(),
      ),
    ).called(1);

    expect(find.byType(LoadingIndicator), findsNothing);
    expect(find.byType(AppErrorView), findsNothing);
  });
}
