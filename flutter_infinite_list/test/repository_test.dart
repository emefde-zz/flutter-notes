import 'package:flutter_infinite_list/posts/models/post.dart';
import 'package:flutter_infinite_list/posts/repository/post_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('mocking some stuff', () {
    var stringResponse = """ 
    {
      "id": 1,
      "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
      "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    }
    """;

    test('testing mocks', () async {
      final mockClient = MockClient();
      final response = http.Response(stringResponse, 200);
      final url = Uri.https('jsonplaceholder.typicode.com', '/posts');

      final repository = PostRepository(client: mockClient, postLimit: 1);

      final expexted = [
        Post(id: 1, title: 'Mocked post', body: 'Mocked body post')
      ];

      when(mockClient.get(url))
          .thenAnswer((realInvocation) async => Future.value(response));
      when(repository.fetchPosts())
          .thenAnswer((value) async => Future.value(expexted));

      expect(await repository.fetchPosts(), isA<Post>());
    });
  });
}
