import 'package:flutter/material.dart';
import 'package:flutter_infinite_list/posts/bloc/post_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final _scrollController = ScrollController();
  late PostBloc _bloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _bloc = context.read<PostBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
      switch (state.status) {
        case PostStatus.failure:
          return const Center(child: Text('Failed to fetch posts'));
        case PostStatus.success:
          if (state.posts.isEmpty) {
            return const Center(
              child: Text('No posts available'),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return index >= state.posts.length
                  ? BottomLoader()
                  : PostListItem(post: state.posts[index]);
            },
            itemCount: state.hasReachedMax
                ? state.posts.length
                : state.posts.length + 1,
          );
      }
    });
  }

  void _onScroll() {}
}
