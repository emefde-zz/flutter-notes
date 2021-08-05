import 'package:flutter_infinite_list/posts/models/post.dart';
import 'package:http/http.dart' as http;

abstract class IPostRepository {
  Future<List<Post>> fetchPosts();
}

class PostRepository extends IPostRepository {

  PostRepository({
    required this.client,
    required int postLimit
  }) : _postLimit = postLimit;

  final http.Client client;
  int _postLimit;

  @override
  Future<List<Post>> fetchPosts([int startIndex = 0]) async {
    final response = await client.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
        <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'},
      ),
    );

    if (response.statusCode == 200) {
      return postFromJson(response.body);
    }

    throw Exception('error fetching posts');
  }

}