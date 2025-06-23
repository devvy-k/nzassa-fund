import 'dart:developer' as console;
import 'dart:io';

import 'package:crowfunding_project/core/data/models/project_model.dart';
import 'package:crowfunding_project/core/data/uistate.dart';
import 'package:crowfunding_project/core/domain/usecases/projects/create_project_usecase.dart';
import 'package:get/get.dart';

class CollectCreationViewmodel extends GetxController {
  final CreateProjectUseCase createProjectUseCase;

  CollectCreationViewmodel(this.createProjectUseCase);
  // Change File to String after testing
  final RxList<File> mediaFiles = <File>[].obs;
  final RxList<File> receipts = <File>[].obs;

  final Rxn<UiState> createProjectState = Rxn<UiState>();

  Future<void> createProject(ProjectModel project) async {
    try {
      await createProjectUseCase.call(project);
      createProjectState.value = UiStateSuccess(null);
    } catch (e) {
      console.log('[CollectCreationViewmodel] Error creating project: $e');
      createProjectState.value = UiStateError(e.toString());
    }
  }
}
