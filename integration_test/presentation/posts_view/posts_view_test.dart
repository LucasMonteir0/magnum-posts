import "package:bloc_test/bloc_test.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:magnum_posts/modules/commons/presentation/components/app_error_view.dart";
import "package:magnum_posts/modules/commons/presentation/components/loading_indicator.dart";

import "package:magnum_posts/modules/posts/core/data/datasources/posts_datasource.dart";
import "package:magnum_posts/modules/posts/core/domain/entities/post_entity.dart";
import "package:magnum_posts/modules/posts/posts_module.dart";
import "package:magnum_posts/modules/posts/presentation/blocs/get_posts/get_posts_bloc.dart";
import "package:magnum_posts/modules/posts/presentation/blocs/get_posts/get_posts_state.dart";
import "package:magnum_posts/modules/posts/presentation/components/post_card.dart";
import "package:magnum_posts/modules/posts/presentation/view/posts_view.dart";
import "package:mocktail/mocktail.dart";
import "package:modular_test/modular_test.dart";

import "../../../test/run_test_widget.dart";

class MockGetPostsBloc extends MockCubit<GetPostsState>
    implements GetPostsBloc {}

class MockPostsDatasource extends Mock implements PostsDatasource {}

class MockIModularNavigator extends Mock implements IModularNavigator {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockGetPostsBloc mockBloc;
  late MockIModularNavigator mockNavigator;

  setUp(() {
    mockBloc = MockGetPostsBloc();
    mockNavigator = MockIModularNavigator();

    initModule(
      PostsModule(),
      replaceBinds: [
        Bind.instance<GetPostsBloc>(mockBloc),
        Bind.instance<PostsDatasource>(MockPostsDatasource()),
      ],
    );

    Modular.navigatorDelegate = mockNavigator;
  });

  tearDown(() {
    mockBloc.close();
  });

  final tPostsList = List.generate(
    20,
    (i) => PostEntity(
      id: i + 1,
      title: "Title ${i + 1}",
      body: "Body ${i + 1}",
      userId: i + 1,
    ),
  );

  testWidgets("[INTEGRATION] PostsView", (tester) async {
    when(() => mockBloc.state).thenReturn(const GetPostsInitial());
    when(() => mockBloc.loadPosts()).thenAnswer((_) async {});

    whenListen(
      mockBloc,
      Stream<GetPostsState>.fromIterable([
        const GetPostsLoading(),
        GetPostsSuccess(posts: tPostsList, hasMore: true),
      ]),
      initialState: const GetPostsInitial(),
    );

    await tester.pumpWidget(runPageTest(const PostsView()));

    await tester.pumpAndSettle();

    expect(find.byType(Scaffold), findsOneWidget);

    verify(() => mockBloc.loadPosts()).called(1);

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(PostCard), findsWidgets);
    expect(find.byType(LoadingIndicator), findsNothing);
    expect(find.byType(AppErrorView), findsNothing);
  });
}
