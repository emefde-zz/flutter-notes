import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_infinite_list/posts/bloc/post_bloc.dart';
import 'package:flutter_infinite_list/posts/repository/post_repository.dart';
import 'package:flutter_infinite_list/posts/view/post_list.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Posts')),
        body: RepositoryProvider(
            create: (_) => PostRepository(client: http.Client(), postLimit: 60),
            child: _PostPageBloc()));
  }
}

class _PostPageBloc extends StatelessWidget {
  const _PostPageBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            PostBloc(repository: context.read<PostRepository>())
              ..add(PostFetched()),
        child: PostList());
  }
}
