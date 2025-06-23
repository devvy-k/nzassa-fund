import 'dart:developer' as console show log;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowfunding_project/core/constants/firebase_contants.dart';
import 'package:crowfunding_project/core/data/models/author_model.dart';
import 'package:crowfunding_project/core/data/models/project_model.dart';
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
        return snapshot.docs.map((doc){
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

  // upload media files
  Future<List<String>> uploadMediaFiles(List<File> files, String projectId) async{
    final List<String> uploadedFileUrls = [];
    for (File file in files) {
      try {
        final ref = _storageService
            .ref()
            .child('${FirebaseConstants.projectsMediaFolder}'
                '/$projectId/${file.path.split('/').last}');
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
