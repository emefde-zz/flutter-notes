import 'package:flutter_infinite_list/posts/models/post.dart';
import 'package:flutter_infinite_list/posts/repository/post_repository.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'repository_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('mocking some stuff', () {
    final jsonString = '''
    [{"id": 1, "title": "Mocked post", "body": "Mocked body post"}, {"id": 2, "title": "Mocked post 2", "body": "Mocked body post 2"}]
    ''';

    Uri _makeTestURL(int startIndex, int postLimit) {
      return Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$postLimit'},
      );
    }

    test('testing httpClient', () async {
      final mockClient = MockClient();

      when(mockClient.get(_makeTestURL(0, 1)))
          .thenAnswer((_) async => http.Response(jsonString, 200));

      expect(await fetchPost(mockClient), isA<List<Post>>());
    });

    test('testing repository success', () async {
      final mockClient = MockClient();
      final startIndex = 0;
      final postLimit = 1;

      final repository =
          PostRepository(client: mockClient, postLimit: postLimit);

      when(mockClient.get(_makeTestURL(startIndex, postLimit)))
          .thenAnswer((_) async => http.Response(jsonString, 200));

      expect(await repository.fetchPosts(), isA<List<Post>>());
    });

    test('testing repository failure', () async {
      final mockClient = MockClient();
      final startIndex = 0;
      final postLimit = 1;
      final repository =
          PostRepository(client: mockClient, postLimit: postLimit);

      when(mockClient.get(_makeTestURL(startIndex, postLimit)))
          .thenAnswer((_) async => http.Response('Not found', 404));

      expect(repository.fetchPosts(), throwsException);
    });

    test('test model parsing', () {
      final posts = postFromJson(jsonString);
      expect(posts.length, 2);
      expect(posts[0].id, 1);
      expect(posts[0].title, 'Mocked post');
      expect(posts[0].body, 'Mocked body post');
      expect(posts[1].id, 2);
      expect(posts[1].title, 'Mocked post 2');
      expect(posts[1].body, 'Mocked body post 2');
    });
  });
}

// just to test http client mock
Future<List<Post>> fetchPost(http.Client client) async {
  final response = await client.get(
    Uri.https(
      'jsonplaceholder.typicode.com',
      '/posts',
      <String, String>{'_start': '0', '_limit': '1'},
    ),
  );

  if (response.statusCode == 200) {
    return postFromJson(response.body);
  }

  throw Exception('error fetching posts');
}
