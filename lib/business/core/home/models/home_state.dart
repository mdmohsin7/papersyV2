import 'package:equatable/equatable.dart';
import 'package:papersy/business/unions/notes/notes_union.dart' as n;
import 'package:papersy/business/unions/papers/papers_union.dart' as p;
import 'package:papersy/client/models/notes_model.dart';
import 'package:papersy/client/models/papers_model.dart';

class HomeState extends Equatable {
  final int index;
  final List<Note> notes;
  final List<Paper> papers;
  final n.NotesUnion notesUnion;
  final p.PapersUnion papersUnion;

  HomeState({
    this.index,
    this.notes,
    this.papers,
    this.notesUnion,
    this.papersUnion,
  });

  HomeState copy({
    int index,
    List<Note> notes,
    List<Paper> papers,
    n.NotesUnion notesUnion,
    p.PapersUnion papersUnion,
  }) {
    return HomeState(
        index: index ?? this.index,
        notes: notes ?? this.notes,
        papers: papers ?? this.papers,
        notesUnion: notesUnion ?? this.notesUnion,
        papersUnion: papersUnion ?? this.papersUnion);
  }

  static HomeState initialState() => HomeState(
      index: 0,
      notes: null,
      papers: null,
      notesUnion: n.None(),
      papersUnion: p.None());

  @override
  List<Object> get props => [index, notes, papers, notesUnion, papersUnion];
}
