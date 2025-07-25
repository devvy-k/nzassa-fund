import 'dart:async';
import 'dart:developer' as console;

import 'package:crowfunding_project/core/data/models/comment_model.dart';
import 'package:crowfunding_project/core/data/models/user_profile.dart';
import 'package:crowfunding_project/core/data/uistate.dart';
import 'package:crowfunding_project/core/domain/usecases/comments/add_comment_usecase.dart';
import 'package:crowfunding_project/core/domain/usecases/comments/delete_comment_usecase.dart';
import 'package:crowfunding_project/core/domain/usecases/comments/get_comment_usecase.dart';
import 'package:get/get.dart';

class CommentViewmodel extends GetxController {
  final GetCommentUsecase _getCommentUsecase;
  final AddCommentUsecase _addCommentUsecase;
  final DeleteCommentUsecase _deleteCommentUsecase;
  CommentViewmodel(
    this._getCommentUsecase,
    this._addCommentUsecase,
    this._deleteCommentUsecase,
  );

  final RxList<CommentModel> comments = <CommentModel>[].obs;
  final RxList<CommentModel> replies = <CommentModel>[].obs;
  final RxString newCommentContent = ''.obs;
  final RxnString replyingToContentId = RxnString(null);
  final Rx<UiState<List<CommentModel>>?> commentsState = Rx<UiState<List<CommentModel>>?>(null);
  StreamSubscription<List<CommentModel>>? _commentsSubscription;

  Future<void> fetchComments(String projectId, {String? parentCommentId}) async {
    commentsState.value = UiStateLoading();
    try {
      _commentsSubscription?.cancel();
      _commentsSubscription = _getCommentUsecase.call(projectId, parentCommentId: parentCommentId).listen(
        (commentList) {
          comments.value = commentList;
          commentsState.value = UiStateSuccess(commentList);
        },
        onError: (error) {
          commentsState.value = UiStateError('Failed to load comments: $error');
        },
      );
    } catch (e) {
      commentsState.value = UiStateError('Failed to load comments: $e');
    }
  }

  Future<void> addComment(String projectId, String content, UserProfile user, {String? parentCommentId}) async {
    if (newCommentContent.value.isEmpty) return;

    try {
      await _addCommentUsecase.call(
        projectId: projectId,
        content: newCommentContent.value,
        user: user,
        parentCommentId: replyingToContentId.value,
      );
      newCommentContent.value = '';
      replyingToContentId.value = null;
    } catch (e) {
      console.log('[CommentViewmodel] Error adding comment: $e');
    }
  }

  Future<void> loadReplies(String projectId, String commentId) async {
    try {
       _getCommentUsecase.call(projectId, parentCommentId: commentId)
          .listen((fetchedReplies){
            replies.assignAll(fetchedReplies);
          });
    } catch (e) {
      console.log('[CommentViewmodel] Error loading replies: $e');
    }
  }

  Future<void> deleteComment(String projectId, String commentId) async {
    try {
      await _deleteCommentUsecase.call(projectId, commentId);
      comments.removeWhere((comment) => comment.id == commentId);
      replies.removeWhere((reply) => reply.id == commentId);
    } catch (e) {
      console.log('[CommentViewmodel] Error deleting comment: $e');
    }
  }

 void setReplyingTo(String? commentId){
  replyingToContentId.value = commentId;
 }
}
