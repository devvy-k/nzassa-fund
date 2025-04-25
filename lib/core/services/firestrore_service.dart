import 'dart:developer' as console show log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowfunding_project/data/models/author_model.dart';
import 'package:crowfunding_project/data/models/project_model.dart';

class FirestroreService {
  final FirebaseFirestore _firestroreService = FirebaseFirestore.instance;

  // Retrieve all projects from the Firestore collection
  Future<List<ProjectModel>> getPosts() async {
    try {
      final projectsSnapshot =
          await _firestroreService.collection('projects').get();
      //console.log('[FirestoreService] Retrieved projects data: ${postsSnaphot.docs.map((doc) => doc.data()).toList()}');

      // Temp cache for authors
      final Map<String, AuthorModel> authorsCache = {};

      // async building for each project with putting author in cache
      final projectFutures =
          projectsSnapshot.docs.map((doc) async {
            final projectData = doc.data();
            final String authorId =
                projectData['author']; // Get author ID from post data

            // Check if author is already in cache
            AuthorModel author;
            if (authorsCache.containsKey(authorId)) {
              author = authorsCache[authorId]!;
            } else {
              final authorSnapshot =
                  await _firestroreService
                      .collection('users')
                      .doc(authorId)
                      .get();

              if (!authorSnapshot.exists) {
                throw Exception('Author not found for ID: $authorId');
              }

              final authorData = authorSnapshot.data()!;
              author = AuthorModel.fromJson(authorData);
              console.log('[FirestoreService] Author data: ${author.toJson()}');

              // add author to cache
              authorsCache[authorId] = author;
            }
            // Create PostModel instance
            return ProjectModel.fromJson(doc.id, projectData, author);
          }).toList();
      console.log('[FirestoreService] Projects length : ${projectFutures.length}');
      return await Future.wait(projectFutures);
    } catch (e) {
      throw Exception('Failed to load projects: $e');
    }
  }
}
