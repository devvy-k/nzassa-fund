import 'dart:developer' as console;

import 'package:crowfunding_project/core/services/firestrore_service.dart';
import 'package:crowfunding_project/data/models/post_model.dart';

class PostsRemoteDatasource {
  final FirestroreService firestoreService;

  PostsRemoteDatasource(this.firestoreService);
  
  Future<List<PostModel>>  getPosts() async {
    final posts = await firestoreService.getPosts();
    console.log('[RemoteDatasource] Posts length : ${posts.length}');
    return posts;
  } 
}
  