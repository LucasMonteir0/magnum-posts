import 'package:flutter_test/flutter_test.dart';
import 'package:magnum_posts/modules/posts/core/domain/entities/author_entity.dart';

void main() {
  group('AuthorEntity', () {
    test('should create a valid AuthorEntity instance', () {
      const entity = AuthorEntity(id: 1, name: 'John Doe');

      expect(entity.id, 1);
      expect(entity.name, 'John Doe');
    });

    test('should support value equality via Equatable', () {
      const entity1 = AuthorEntity(id: 1, name: 'John Doe');
      const entity2 = AuthorEntity(id: 1, name: 'John Doe');
      const entity3 = AuthorEntity(id: 2, name: 'Jane Doe');

      expect(entity1, equals(entity2));
      expect(entity1, isNot(equals(entity3)));
    });

    test('should have correct props', () {
      const entity = AuthorEntity(id: 5, name: 'Test Author');

      expect(entity.props, [5, 'Test Author']);
    });
  });
}
