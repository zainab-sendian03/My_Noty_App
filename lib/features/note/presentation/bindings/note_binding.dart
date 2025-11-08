import 'package:get/get.dart';
import 'package:firebase_test/features/note/domain/repositories/note_repository.dart';
import 'package:firebase_test/features/note/domain/usecases/add_note.dart';
import 'package:firebase_test/features/note/data/repositories/note_repository_impl.dart';
import 'package:firebase_test/features/note/presentation/controllers/add_note_controller.dart';

class NoteBinding extends Bindings {
  @override
  void dependencies() {
    // Repository
    Get.lazyPut<NoteRepository>(() => NoteRepositoryImpl());

    // Use Cases
    Get.lazyPut(() => AddNote(Get.find<NoteRepository>()));

    // Controllers
    Get.lazyPut(() => AddNoteController());
  }
}
