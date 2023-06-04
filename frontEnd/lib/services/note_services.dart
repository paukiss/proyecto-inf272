import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:note_inf272/model/note.dart';

class NoteServices extends ChangeNotifier{


  Future<List<Note>> getNotas () async {
    List<Note> listNote = [];
    final url = Uri.http("localhost:8080", "/nota");
    final resp = await http.get(url);
    final dataInJson = jsonDecode(resp.body);
    for (var elem in dataInJson) {
      Note data = Note.fromJson(elem);
      listNote.add(data);
    }
    return listNote;
  }

  Future<void> deleteById(int id) async {
    final url = Uri.http("localhost:8080", "/nota/$id");
    final resp = await http.delete(url);
    // final dataInJson = jsonDecode(resp.body);
    print(resp.body);
    // return resp.body;
  }

  Future<void> createNote(Note nota) async {
    final url = Uri.http("localhost:8080", "/nota");
    final contenido = jsonEncode(nota.convertToJson());
    final resp = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: contenido
    );
    // final dataInJson = jsonDecode(resp.body);
    print(resp.body);
    // return resp.body;
  }
}