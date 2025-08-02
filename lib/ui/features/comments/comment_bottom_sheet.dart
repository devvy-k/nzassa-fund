import 'package:crowfunding_project/core/controllers/session_manager.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/data/uistate.dart';
import 'package:crowfunding_project/ui/features/comments/comment_viewmodel.dart';
import 'package:crowfunding_project/ui/features/projects/component/profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsBottomSheet extends StatefulWidget {
  final ProjectModel project;
  const CommentsBottomSheet({super.key, required this.project});

  static void show(BuildContext context, ProjectModel project) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => CommentsBottomSheet(project: project),
    );
  }

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  TextEditingController commentController = TextEditingController();
  final commentViewmodel = Get.find<CommentViewmodel>();
  final userProfile = Get.find<SessionManager>().user;

  @override
  void initState() {
    super.initState();
    commentViewmodel.fetchComments(widget.project.id);
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.8,
      builder: (context, scrollController) {
        return Obx(() {
          final state = commentViewmodel.commentsState.value;
          final comments = commentViewmodel.comments;

          return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                Expanded(
                  child:
                      state is UiStateLoading
                          ? const Center(child: CircularProgressIndicator())
                          : comments.isEmpty
                          ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.comment,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Aucun Commentaire',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                          : ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: comments.length,
                            itemBuilder: (BuildContext context, int index) {
                              final comment = comments[index];
                              return ListTile(
                                leading: ProfileAvatar(
                                  userProfileImageUrl:
                                      'https://images.pexels.com/photos/6646918/pexels-photo-6646918.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                  userId: comment.authorId!,
                                ),
                                title: Text(
                                  comment.authorName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.favorite),
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      widget
                                          .project
                                          .comments![index]
                                          .likes!
                                          .length
                                          .toString(),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(),
                          ),
                ),

                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Ajouter un commentaire',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (commentController.text.isNotEmpty) {
                            commentViewmodel.newCommentContent.value =
                                commentController.text;
                            commentViewmodel.addComment(
                              widget.project.id,
                              userProfile!,
                            );
                            commentController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
