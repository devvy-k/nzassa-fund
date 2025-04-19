import 'package:crowfunding_project/data/models/post_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> getPosts();
}