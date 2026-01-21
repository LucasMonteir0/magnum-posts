import 'package:flutter_test/flutter_test.dart';
import 'package:magnum_posts/modules/posts/core/domain/entities/post_entity.dart';

void main() {
  group('PostEntity', () {
    test('should create a valid PostEntity instance', () {
      const entity = PostEntity(
        id: 1,
        title: 'Test Title',
        body: 'Test Body',
        userId: 10,
      );

      expect(entity.id, 1);
      expect(entity.title, 'Test Title');
      expect(entity.body, 'Test Body');
      expect(entity.userId, 10);
    });

    test('should support value equality via Equatable', () {
      const entity1 = PostEntity(
        id: 1,
        title: 'Title',
        body: 'Body',
        userId: 1,
      );
      const entity2 = PostEntity(
        id: 1,
        title: 'Title',
        body: 'Body',
        userId: 1,
      );
      const entity3 = PostEntity(
        id: 2,
        title: 'Title',
        body: 'Body',
        userId: 1,
      );

      expect(entity1, equals(entity2));
      expect(entity1, isNot(equals(entity3)));
    });

    test('should have correct props', () {
      const entity = PostEntity(
        id: 1,
        title: 'Title',
        body: 'Body',
        userId: 10,
      );

      expect(entity.props, [1, 'Title', 'Body', 10]);
    });
  });
}
