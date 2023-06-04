import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_inf272/screens/notes_screen.dart';
import 'package:provider/provider.dart';
import 'package:note_inf272/services/note_services.dart';

import '../model/note.dart';

class CrearNotesScreen extends StatefulWidget {
  const CrearNotesScreen({super.key});
  @override
  CrearNotesScreenState createState() => CrearNotesScreenState();
}

class CrearNotesScreenState extends State<CrearNotesScreen> {
  late NoteServices noteServices;

  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';

  @override
  Widget build(BuildContext context) {
    noteServices = Provider.of<NoteServices>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text("Crear Notes"),
        ),
        body: formulario());
  }

  Widget formulario() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) {
                _title = value!;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Content'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter content';
                }
                return null;
              },
              onSaved: (value) {
                _content = value!;
              },
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // Aquí puedes guardar la nota en tu base de datos o hacer lo que desees con los datos
                  print('Title: $_title');
                  print('Content: $_content');
                  noteServices.createNote(Note(titulo: _title, contenido: _content));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MultiProvider(
                      providers: [
                        ChangeNotifierProvider(create: (_) => NoteServices()),
                      ],
                      child: NoteScreen(),
                    )),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget disenoNotas(int id, String titulo, String contenido, String fecha) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(10),
      width: 470,
      height: 160,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(100, 253, 184, 75)),
      child: Row(
        children: [
          Icon(Icons.note, size: 150),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Titulo:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                titulo,
              ),
              Text(
                'Contenido:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  contenido,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
