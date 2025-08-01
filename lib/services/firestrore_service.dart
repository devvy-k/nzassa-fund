import 'dart:developer' as console show log;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowfunding_project/core/constants/firebase_contants.dart';
import 'package:crowfunding_project/core/data/models/author_model.dart';
import 'package:crowfunding_project/core/data/models/comment_model.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/data/models/user_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestroreService {
  final FirebaseFirestore _firestoreService = FirebaseFirestore.instance;
  final FirebaseStorage _storageService = FirebaseStorage.instance;

  // Retrieve all projects from the Firestore collection
  Stream<List<ProjectModel>> streamProjects() {
    try {
      final projectsCollection = _firestoreService.collection(
        FirebaseConstants.projectsCollection,
      );

      return projectsCollection.snapshots().asyncMap((snapshot) async {
        return snapshot.docs.map((doc) {
          final projectData = doc.data();

          final authorMap = projectData['author'] as Map<String, dynamic>;
          final author = AuthorModel.fromJson(authorMap);

          return ProjectModel.fromJson(doc.id, projectData, author);
        }).toList();
      });
    } catch (e) {
      throw Exception('Failed to load projects: $e');
    }
  }

  // Create project
  Future<void> createProject(ProjectModel project) async {
    try {
      await _firestoreService
          .collection(FirebaseConstants.projectsCollection)
          .doc(project.id)
          .set(project.toJson());
    } catch (e) {
      throw Exception('Failed to create project: $e');
    }
  }

  // Toggle like on a project
  Future<void> toggleLikeProject(String projectId, String userId) async {
    final projectRef = _firestoreService
        .collection(FirebaseConstants.projectsCollection)
        .doc(projectId);

    try {
      await _firestoreService.runTransaction((transaction) async {
        final snapshot = await transaction.get(projectRef);
        if (!snapshot.exists) {
          throw Exception('Project does not exist');
        }

        final likes = List<String>.from(snapshot.data()?['likes'] ?? []);
        if (likes.contains(userId)) {
          likes.remove(userId); // Unlike the project
        } else {
          likes.add(userId); // Like the project
        }

        transaction.update(projectRef, {'likes': likes});
      });
    } catch (e) {
      throw Exception('Failed to toggle like: $e');
    }
  }

  // upload media files
  Future<List<String>> uploadMediaFiles(
    List<File> files,
    String projectId,
  ) async {
    final List<String> uploadedFileUrls = [];
    for (File file in files) {
      try {
        final ref = _storageService.ref().child(
          '${FirebaseConstants.projectsMediaFolder}'
          '/$projectId/${file.path.split('/').last}',
        );
        final uploadTask = await ref.putFile(file);
        final fileUrl = await uploadTask.ref.getDownloadURL();
        uploadedFileUrls.add(fileUrl);
      } catch (e) {
        console.log('[FirestoreService] Failed to upload file: $e');
      }
    }
    return uploadedFileUrls;
  }
}

extension CommentService on FirestroreService {
  Future<CommentModel> addComment({
    required String projectId,
    required String content,
    required UserProfile user,
    String? parentCommentId,
  }) async {
    final commentRef =
        _firestoreService
            .collection(FirebaseConstants.projectsCollection)
            .doc(projectId)
            .collection(FirebaseConstants.commentsCollection)
            .doc();

    final comment = CommentModel(
      id: commentRef.id,
      content: content,
      authorId: user.id,
      authorName: user.name,
      authorAvatar: user.profilePicture ?? '',
      createdAt: DateTime.now(),
      parentCommentId: parentCommentId,
    );

    await commentRef.set(comment.toMap());
    return comment;
  }

  Stream<List<CommentModel>> streamComments(String projectId, {String? parentCommentId}){
    try {
      final comments = _firestoreService
          .collection(FirebaseConstants.projectsCollection)
          .doc(projectId)
          .collection(FirebaseConstants.commentsCollection)
          //.where('parentCommentId', isEqualTo: parentCommentId)
          //.orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => CommentModel.fromFirestore(doc))
              .toList());
      console.log('[FirestoreService] Successfully fetched comments for project: $projectId');
      return comments;
    } catch (e) {
      console.log('[FirestoreService] Failed to fetch comments: $e');
      throw Exception('Failed to fetch comments: $e');
    }
  }

  Future<void> deleteComment(String postId, String commentId) async {
    try {
      await _firestoreService
          .collection(FirebaseConstants.projectsCollection)
          .doc(postId)
          .collection(FirebaseConstants.commentsCollection)
          .doc(commentId)
          .delete();
    } catch (e) {
      console.log('[FirestoreService] Failed to delete comment: $e');
      throw Exception('Failed to delete comment: $e');
    }
  }
}
