import 'package:flutter_test/flutter_test.dart';
import 'package:magnum_posts/modules/commons/utils/errors/errors.dart';
import 'package:magnum_posts/modules/commons/utils/states/base_state.dart';

void main() {
  group('BaseState', () {
    group('LoadingState', () {
      test('should create LoadingState instance', () {
        const state = LoadingState();

        expect(state, isA<BaseState>());
        expect(state, isA<LoadingState>());
      });

      test('should have empty props', () {
        const state = LoadingState();

        expect(state.props, isEmpty);
      });

      test('should support value equality', () {
        const state1 = LoadingState();
        const state2 = LoadingState();

        expect(state1, equals(state2));
      });
    });

    group('SuccessState', () {
      test('should create SuccessState with data', () {
        const state = SuccessState('Test Data');

        expect(state, isA<BaseState>());
        expect(state, isA<SuccessState<String>>());
        expect(state.data, 'Test Data');
      });

      test('should have data in props', () {
        const state = SuccessState(42);

        expect(state.props, [42]);
      });

      test('should support value equality', () {
        const state1 = SuccessState('data');
        const state2 = SuccessState('data');
        const state3 = SuccessState('different');

        expect(state1, equals(state2));
        expect(state1, isNot(equals(state3)));
      });

      test('should work with complex types', () {
        final state = SuccessState([1, 2, 3]);

        expect(state.data, [1, 2, 3]);
      });
    });

    group('InitialState', () {
      test('should create InitialState without data', () {
        const state = InitialState();

        expect(state, isA<BaseState>());
        expect(state, isA<InitialState>());
        expect(state.data, isNull);
      });

      test('should create InitialState with optional data', () {
        const state = InitialState('Initial Data');

        expect(state.data, 'Initial Data');
      });

      test('should have data in props', () {
        const state = InitialState('test');

        expect(state.props, ['test']);
      });

      test('should support value equality', () {
        const state1 = InitialState();
        const state2 = InitialState();
        const state3 = InitialState('data');

        expect(state1, equals(state2));
        expect(state1, isNot(equals(state3)));
      });
    });

    group('ErrorState', () {
      test('should create ErrorState with error', () {
        final error = NotFoundError(message: 'Not found');
        final state = ErrorState(error);

        expect(state, isA<BaseState>());
        expect(state, isA<ErrorState>());
        expect(state.error, error);
      });

      test('should use UnknownError when null is passed', () {
        final state = ErrorState(null);

        expect(state.error, isA<UnknownError>());
      });

      test('should have error in props', () {
        final error = BadRequestError();
        final state = ErrorState(error);

        expect(state.props, [error]);
      });

      test('should support value equality', () {
        final error = NotFoundError();
        final state1 = ErrorState(error);
        final state2 = ErrorState(error);

        expect(state1, equals(state2));
      });
    });
  });
}
