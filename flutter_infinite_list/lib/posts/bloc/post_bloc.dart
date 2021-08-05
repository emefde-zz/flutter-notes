import 'package:equatable/equatable.dart';
import 'package:flutter_infinite_list/posts/models/post.dart';
import 'package:flutter_infinite_list/posts/repository/post_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.repository}) : super(const PostState());

  final PostRepository repository;

  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
      Stream<PostEvent> events,
      TransitionFunction<PostEvent, PostState> transitionFn) {
    return super.transformEvents(
        events.debounceTime(const Duration(microseconds: 500)), transitionFn);
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostFetched) {
      yield await _mapPostFetchedEventToState(event);
    }
  }

  Future<PostState> _mapPostFetchedEventToState(PostFetched event) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await repository.fetchPosts();
        return state.copyWith(
            status: PostStatus.success, posts: posts, hasReachedMax: false);
      }
      final posts = await repository.fetchPosts(state.posts.length);
      return posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: false);
    } on Exception {
      return state.copyWith(status: PostStatus.failure);
    }
  }
}
