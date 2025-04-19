import 'dart:developer' as console show log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowfunding_project/data/models/author_model.dart';
import 'package:crowfunding_project/data/models/post_model.dart';

class FirestroreService {
  final FirebaseFirestore _firestroreService = FirebaseFirestore.instance;

  // Retrieve all posts from the Firestore collection
  Future<List<PostModel>> getPosts() async {
    try {
      final postsSnaphot = await _firestroreService.collection('posts').get();
      //console.log('[FirestoreService] Retrieved posts data: ${postsSnaphot.docs.map((doc) => doc.data()).toList()}');

      // Temp cache for authors
      final Map<String, AuthorModel> authorsCache = {};

      // async building for each post with putting author in cache
      final postFutures =
          postsSnaphot.docs.map((doc) async {
            final postData = doc.data();
            final String authorId =
                postData['author']; // Get author ID from post data

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
              console.log(
                  '[FirestoreService] Author data: ${author.toJson()}');

              // add author to cache
              authorsCache[authorId] = author;
            }
            // Create PostModel instance
            return PostModel.fromJson(doc.id, postData, author);
          }).toList();
      console.log('[FirestoreService] Posts length : ${postFutures.length}');
      return await Future.wait(postFutures);
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}
