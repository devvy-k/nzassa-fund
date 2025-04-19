import 'dart:developer' as console;

import 'package:crowfunding_project/data/models/post_model.dart';
import 'package:crowfunding_project/domain/usecases/posts/get_posts_usecase.dart';
import 'package:get/get.dart';

class HomeViewmodel extends GetxController {
  final GetPostsUsecase getPostsUsecase;
  HomeViewmodel(this.getPostsUsecase);

  // Reactive post data
  final RxList<PostModel> posts = <PostModel>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    console.log('[HomeViewModel] onInit');
    fetchPosts();
    super.onInit();
  }

  void fetchPosts() async {
    isLoading.value = true;
    getPostsUsecase
        .call()
        .then((fetchedPosts) {
          posts.assignAll(fetchedPosts);
          isLoading.value = false;
        })
        .catchError((error) {
          // Handle error
          isLoading.value = false;
        });
  }
}
