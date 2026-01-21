import 'package:flutter_test/flutter_test.dart';
import 'package:magnum_posts/modules/commons/core/domain/entities/api/api_error.dart';
import 'package:magnum_posts/modules/commons/core/domain/entities/api/api_response.dart';
import 'package:magnum_posts/modules/commons/core/domain/services/http/http_service.dart';
import 'package:magnum_posts/modules/posts/core/data/datasources/posts_datasource_impl.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpService extends Mock implements HttpService {}

void main() {
  late PostsDatasourceImpl datasource;
  late MockHttpService mockHttpService;

  setUp(() {
    mockHttpService = MockHttpService();
    datasource = PostsDatasourceImpl(mockHttpService);
  });

  group('PostsDatasourceImpl', () {
    group('getPosts', () {
      final tPostsJsonList = [
        {'id': 1, 'title': 'Title 1', 'body': 'Body 1', 'userId': 1},
        {'id': 2, 'title': 'Title 2', 'body': 'Body 2', 'userId': 2},
      ];
      final tApiResponse = ApiResponse(data: tPostsJsonList, statusCode: 200);

      test(
        'should return list of PostEntity when call is successful',
        () async {
          when(
            () => mockHttpService.get(any()),
          ).thenAnswer((_) async => tApiResponse);

          final result = await datasource.getPosts();

          expect(result.isSuccess, true);
          expect(result.data!.length, 2);
          expect(result.data![0].id, 1);
          expect(result.data![1].id, 2);
        },
      );

      test('should return error when ApiError is thrown', () async {
        when(() => mockHttpService.get(any())).thenThrow(
          ApiError(
            message: 'Not Found',
            statusCode: 404,
            errorType: DioExceptionType.badResponse,
          ),
        );

        final result = await datasource.getPosts();

        expect(result.isSuccess, false);
        expect(result.error, isNotNull);
        expect(result.error!.code, 404);
      });

      test(
        'should return UnknownError when generic exception is thrown',
        () async {
          when(
            () => mockHttpService.get(any()),
          ).thenThrow(Exception('Unknown error'));

          final result = await datasource.getPosts();

          expect(result.isSuccess, false);
          expect(result.error, isNotNull);
          expect(result.error!.code, -1);
        },
      );
    });

    group('getPostById', () {
      final tPostJson = {
        'id': 1,
        'title': 'Title',
        'body': 'Body',
        'userId': 1,
      };
      final tApiResponse = ApiResponse(data: tPostJson, statusCode: 200);

      test('should return PostEntity when call is successful', () async {
        when(
          () => mockHttpService.get(any()),
        ).thenAnswer((_) async => tApiResponse);

        final result = await datasource.getPostById(1);

        expect(result.isSuccess, true);
        expect(result.data!.id, 1);
        expect(result.data!.title, 'Title');
      });

      test('should return error when ApiError is thrown', () async {
        when(() => mockHttpService.get(any())).thenThrow(
          ApiError(
            message: 'Not Found',
            statusCode: 404,
            errorType: DioExceptionType.badResponse,
          ),
        );

        final result = await datasource.getPostById(1);

        expect(result.isSuccess, false);
        expect(result.error, isNotNull);
      });
    });

    group('getAuthorById', () {
      final tAuthorJson = {'id': 1, 'name': 'John Doe'};
      final tApiResponse = ApiResponse(data: tAuthorJson, statusCode: 200);

      test('should return AuthorEntity when call is successful', () async {
        when(
          () => mockHttpService.get(any()),
        ).thenAnswer((_) async => tApiResponse);

        final result = await datasource.getAuthorById(1);

        expect(result.isSuccess, true);
        expect(result.data!.id, 1);
        expect(result.data!.name, 'John Doe');
      });

      test('should return error when ApiError is thrown', () async {
        when(() => mockHttpService.get(any())).thenThrow(
          ApiError(
            message: 'Not Found',
            statusCode: 404,
            errorType: DioExceptionType.badResponse,
          ),
        );

        final result = await datasource.getAuthorById(1);

        expect(result.isSuccess, false);
        expect(result.error, isNotNull);
      });
    });
  });
}
