import 'package:crowfunding_project/data/models/post_model.dart';
import 'package:crowfunding_project/domain/repositories/post_repository.dart';

class GetPostsUsecase {
  final PostRepository _postRepository;

  GetPostsUsecase(this._postRepository);
  Future<List<PostModel>> call() => _postRepository.getPosts();
}
  
  