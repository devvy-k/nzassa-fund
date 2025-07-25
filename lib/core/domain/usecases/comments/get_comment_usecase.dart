import 'package:crowfunding_project/core/data/models/comment_model.dart';
import 'package:crowfunding_project/core/domain/repositories/project_repository.dart';

class GetCommentUsecase {
  final ProjectRepository _projectRepository;

  GetCommentUsecase(this._projectRepository);

  Stream<List<CommentModel>> call(String projectId, {String? parentCommentId}) {
    return _projectRepository.getComments(projectId, parentCommentId: parentCommentId);
  }
}