import 'dart:developer' as console;

import 'package:crowfunding_project/data/datasources/posts_remote_datasource.dart';
import 'package:crowfunding_project/data/models/post_model.dart';
import 'package:crowfunding_project/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostsRemoteDatasource _postsRemoteDatasource;

  PostRepositoryImpl(this._postsRemoteDatasource);

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final List<PostModel> posts = await _postsRemoteDatasource.getPosts();
      console.log('[Repository] Posts length : ${posts.length}');
      return posts;
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}
