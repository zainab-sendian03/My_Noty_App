import 'package:firebase_test/features/note/domain/entities/note_entity.dart';
import 'package:firebase_test/features/note/domain/repositories/note_repository.dart';

class AddNote {
  final NoteRepository noteRepository;

  AddNote(this.noteRepository);
  Future<NoteEntity> call(String title, String content, String imageUrl) async {
    return await noteRepository.addNote(title, content, imageUrl);
  }
}
