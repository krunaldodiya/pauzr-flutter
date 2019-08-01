import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/post.dart';
import 'package:pauzr/src/resources/api.dart';

class PostBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  int lastPage;
  int page = 1;
  bool busy;
  List<Post> posts = [];
  bool loading;
  bool loaded;
  Map error = const {};

  setState({
    int lastPage,
    int page,
    bool busy,
    List<Post> posts,
    bool loading,
    bool loaded,
    Map error,
  }) {
    this.lastPage = lastPage ?? this.lastPage;
    this.page = page ?? this.page;
    this.busy = busy ?? this.busy;
    this.posts = posts ?? this.posts;
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;

    notifyListeners();
  }

  deletePost(int postId) async {
    setState(loading: true, loaded: false);

    try {
      await _apiProvider.deletePost(postId);
      final List<Post> postsData = posts
        ..removeWhere((post) => post.id == postId);

      setState(
        posts: postsData,
        loading: false,
        loaded: true,
      );

      return postsData;
    } catch (error) {
      setState(loading: false, loaded: true);
    }
  }

  getPostDetail(int postId) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.getPostDetail(postId);
      final results = response.data;

      final Post currentPost = Post.fromMap(results['post']);
      final List<Post> postsData = posts
          .map((post) => post.id == currentPost.id ? currentPost : post)
          .toList();

      setState(
        posts: postsData,
        loading: false,
        loaded: true,
      );

      return currentPost;
    } catch (error) {
      print(error);
      setState(loading: false, loaded: true);
    }
  }

  createPost(description, photo) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.createPost(
        description,
        photo,
      );

      final results = response.data;
      final Post currentPost = Post.fromMap(results['post']);
      final List<Post> postsData = posts..insert(0, currentPost);

      setState(
        posts: postsData,
        loading: false,
        loaded: true,
      );

      return postsData;
    } catch (error) {
      setState(loading: false, loaded: true);
    }
  }

  editPost(postId, description, photo) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.editPost(
        postId,
        description,
        photo,
      );

      final results = response.data;
      final Post currentPost = Post.fromMap(results['post']);
      final List<Post> postsData = posts
          .map((post) => post.id == currentPost.id ? currentPost : post)
          .toList();

      setState(
        posts: postsData,
        loading: false,
        loaded: true,
      );

      return postsData;
    } catch (error) {
      setState(loading: false, loaded: true);
    }
  }

  getPosts({loadMore: false, @required int userId}) async {
    if (busy == true) return false;
    if (loadMore == true && page == lastPage) return false;

    if (loadMore == false) {
      setState(
        page: 1,
        posts: [],
        loading: true,
        loaded: false,
      );
    } else {
      setState(busy: true, page: page + 1);
    }

    try {
      final Response response = await _apiProvider.getPosts(page, userId);
      final results = response.data;

      final List<Post> imageData = Post.fromList(results['posts']['data']);
      final int lastPage = results['posts']['last_page'];
      final List<Post> postsData = posts..addAll(imageData);

      setState(
        lastPage: lastPage,
        posts: postsData,
        loading: false,
        loaded: true,
        busy: false,
      );

      return postsData;
    } catch (error) {
      setState(
        error: error.response.data,
        loading: false,
        loaded: true,
        busy: false,
      );
    }
  }

  toggleFavorite(int postId) async {
    setState(loading: true, loaded: false);

    try {
      await _apiProvider.toggleFavorite(postId);
      setState(loading: false, loaded: true);
    } catch (error) {
      setState(loading: false, loaded: true);
    }
  }
}
