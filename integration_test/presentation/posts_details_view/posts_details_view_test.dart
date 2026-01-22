import "package:bloc_test/bloc_test.dart";
import "package:flutter_modular/flutter_modular.dart";
import "package:flutter_test/flutter_test.dart";
import "package:integration_test/integration_test.dart";
import "package:magnum_posts/modules/commons/presentation/components/app_error_view.dart";
import "package:magnum_posts/modules/commons/presentation/components/custom_app_bar.dart";
import "package:magnum_posts/modules/commons/presentation/components/loading_indicator.dart";
import "package:magnum_posts/modules/commons/utils/states/base_state.dart";
import "package:magnum_posts/modules/posts/core/data/datasources/posts_datasource.dart";
import "package:magnum_posts/modules/posts/core/domain/entities/author_entity.dart";
import "package:magnum_posts/modules/posts/core/domain/entities/post_entity.dart";
import "package:magnum_posts/modules/posts/posts_module.dart";
import "package:magnum_posts/modules/posts/presentation/blocs/get_author_by_id/get_author_by_id_bloc.dart";
import "package:magnum_posts/modules/posts/presentation/blocs/get_post_by_id/get_post_by_id_bloc.dart";
import "package:magnum_posts/modules/posts/presentation/view/post_details_view.dart";
import "package:mocktail/mocktail.dart";
import "package:modular_test/modular_test.dart";

import "../../../test/run_test_widget.dart";

class MockGetPostByIdBloc extends MockCubit<BaseState>
    implements GetPostByIdBloc {}

class MockGetAuthorByIdBloc extends MockCubit<BaseState>
    implements GetAuthorByIdBloc {}

class MockPostsDatasource extends Mock implements PostsDatasource {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockGetPostByIdBloc mockPostBloc;
  late MockGetAuthorByIdBloc mockAuthorBloc;

  setUp(() {
    mockPostBloc = MockGetPostByIdBloc();
    mockAuthorBloc = MockGetAuthorByIdBloc();

    initModule(
      PostsModule(),
      replaceBinds: [
        Bind.instance<GetPostByIdBloc>(mockPostBloc),
        Bind.instance<GetAuthorByIdBloc>(mockAuthorBloc),
        Bind.instance<PostsDatasource>(MockPostsDatasource()),
      ],
    );
  });

  tearDown(() {
    mockPostBloc.close();
    mockAuthorBloc.close();
  });

  const tPost = PostEntity(
    id: 1,
    title: "Post Title",
    body: "Post Body Content",
    userId: 1,
  );

  const tAuthor = AuthorEntity(id: 1, name: "Author Name");

  testWidgets("[INTEGRATION] PostDetailsView - Load Success", (tester) async {
    when(() => mockPostBloc.state).thenReturn(const LoadingState());
    when(() => mockPostBloc.call(1)).thenAnswer((_) async {});

    whenListen(
      mockPostBloc,
      Stream.fromIterable([const SuccessState<PostEntity>(tPost)]),
      initialState: const LoadingState(),
    );

    when(
      () => mockAuthorBloc.state,
    ).thenReturn(const SuccessState<AuthorEntity>(tAuthor));
    when(() => mockAuthorBloc.call(1)).thenAnswer((_) async {});

    await tester.pumpWidget(runPageTest(const PostDetailsView(postId: "1")));

    await tester.pumpAndSettle();

    expect(find.byType(CustomAppBar), findsOneWidget);
    expect(find.text(tPost.title), findsOneWidget);
    expect(find.text(tPost.body), findsOneWidget);

    verify(() => mockPostBloc.call(1)).called(1);
    verify(() => mockAuthorBloc.call(1)).called(1);

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byType(LoadingIndicator), findsNothing);
    expect(find.byType(AppErrorView), findsNothing);
  });
}
