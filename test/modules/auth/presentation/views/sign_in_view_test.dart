import "package:bloc_test/bloc_test.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";
import "package:flutter_test/flutter_test.dart";
import "package:magnum_posts/modules/auth/auth_module.dart";
import "package:magnum_posts/modules/auth/core/data/datarources/auth_datasource.dart";
import "package:magnum_posts/modules/auth/presentation/blocs/sign_in_bloc.dart";
import "package:magnum_posts/modules/auth/presentation/views/sign_in_view.dart";
import "package:magnum_posts/modules/commons/utils/config/routes.dart";
import "package:magnum_posts/modules/commons/utils/states/base_state.dart";
import "package:mocktail/mocktail.dart";
import "package:modular_test/modular_test.dart";

import "../../../../run_test_widget.dart";

class MockSignInBloc extends MockCubit<BaseState> implements SignInBloc {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthDataSource extends Mock implements AuthDataSource {}

class MockIModularNavigator extends Mock implements IModularNavigator {}

void main() {
  late MockSignInBloc mockBloc;
  late MockIModularNavigator mockNavigator;

  const String mockEmail = "email@email.com";
  const String mockPassword = "123456";

  setUp(() {
    mockBloc = MockSignInBloc();
    mockNavigator = MockIModularNavigator();

    initModule(
      AuthModule(),
      replaceBinds: [
        Bind.instance<FirebaseAuth>(MockFirebaseAuth()),
        Bind.instance<AuthDataSource>(MockAuthDataSource()),
        Bind.instance<SignInBloc>(mockBloc),
      ],
    );

    Modular.navigatorDelegate = mockNavigator;
  });

  tearDown(() {
    mockBloc.close();
  });

  testWidgets("[PRESENTATION] SignInView", (tester) async {
    when(() => mockBloc.call(any(), any())).thenAnswer((_) async {});
    when(
      () => mockNavigator.pushReplacementNamed(
        any(),
        arguments: any(named: "arguments"),
      ),
    ).thenAnswer((_) async => null);

    whenListen(
      mockBloc,
      Stream<BaseState>.fromIterable([
        const LoadingState(),
        const SuccessState<bool>(true),
      ]),
      initialState: const InitialState(),
    );

    await tester.pumpWidget(runPageTest(const SignInView()));

    expect(find.text("E-mail"), findsOneWidget);
    expect(find.text("Senha"), findsOneWidget);
    expect(find.text("Entrar"), findsOneWidget);

    final emailField = find.widgetWithText(TextFormField, "seu@email.com");
    final passwordField = find.widgetWithText(TextFormField, "••••••••");

    await tester.enterText(emailField, mockEmail);
    await tester.enterText(passwordField, mockPassword);
    await tester.pump();

    await tester.tap(find.text("Entrar"));
    await tester.pumpAndSettle();

    verify(() => mockBloc.call(mockEmail, mockPassword)).called(1);

    verify(
      () => mockNavigator.pushReplacementNamed(
        Routes.posts + Routes.root,
        arguments: any(named: "arguments"),
      ),
    ).called(1);
  });
}
