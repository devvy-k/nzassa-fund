import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/ui/features/projects/component/profile_avatar.dart';
import 'package:flutter/material.dart';

class CommentsBottomSheet extends StatefulWidget {
  final ProjectModel project;
  const CommentsBottomSheet({super.key, required this.project});

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              widget.project.comments!.isEmpty
                  ? const Center(child: Column(
                    children: [
                      Icon(Icons.comment, size: 40, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('Aucun Commentaire', style: TextStyle(fontWeight: FontWeight.bold )),
                    ],
                  ))
                  : 
              ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: widget.project.comments!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: ProfileAvatar(
                      userProfileImageUrl:'https://images.pexels.com/photos/6646918/pexels-photo-6646918.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
                      ),
                    title: Text(
                      widget.project.comments![index].authorName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Column(
                      children: [
                        IconButton(
                          onPressed: (){}, icon: Icon(Icons.favorite)
                          ),
                        SizedBox(width: 3),
                        Text(widget.project.comments![index].likes!.length.toString())
                      ],
                    ),
                  );
                },
                separatorBuilder:
                    (BuildContext context, int index) => const Divider(),
              ),
              Spacer(),
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
                          // Add comment logic here
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
