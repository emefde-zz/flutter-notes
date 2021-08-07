import 'package:flutter_infinite_list/posts/bloc/post_bloc.dart';
import 'package:flutter_infinite_list/posts/models/post.dart';
import 'package:flutter_infinite_list/posts/repository/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'post_bloc_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  testPostBloc();
}

void testPostBloc() {
  group('test bloc', () {
    final mockRepository = MockPostRepository();
    final expected = [Post(id: 1, title: "title", body: "body")];

    blocTest<PostBloc, PostState>('test post bloc',
        build: () {
          when(mockRepository.fetchPosts()).thenAnswer((_) async => expected);
          return PostBloc(repository: mockRepository);
        },
        act: (bloc) => bloc.add(PostFetched()),
        expect: () => [isA<PostState>()],
        verify: (bloc) async {
          verify(mockRepository.fetchPosts()).called(1);
          expect(bloc.state.posts.length, 1);
          expect(bloc.state.posts.first.id, 1);
          expect(bloc.state.posts.first.title, 'title');
          expect(bloc.state.posts.first.body, 'body');
        });
  });
}
