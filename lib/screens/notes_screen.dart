import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_inf272/screens/registrar_note.dart';
import 'package:provider/provider.dart';
import 'package:note_inf272/services/note_services.dart';

import '../model/note.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});
  @override
  NoteScreenState createState() => NoteScreenState();
}

class NoteScreenState extends State<NoteScreen> {
  late NoteServices noteServices;

  @override
  Widget build(BuildContext context) {
    noteServices = Provider.of<NoteServices>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text("App Notes"),
              ElevatedButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(create: (_) => NoteServices()),
                    ],
                    child: CrearNotesScreen(),
                  )),
                );
              }, child: Text('Agregar Notas'))
            ],
          ),
        ),
        body: cuerpoApp());
  }

  Widget fila() {
    return Column(
      children: [
        Expanded(child: cuerpoApp()),
        Expanded(child: ElevatedButton(onPressed: () {
          setState(() {
            cuerpoApp();
          });

        }, child: Text('boton ejemplo')))
      ],
    );
  }

  Widget cuerpoApp() {
    return FutureBuilder<dynamic>(
        future: noteServices.getNotas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Note> listNote = snapshot.data;
            print('entro');
            return ListView.builder(
                itemCount: listNote.length,
                itemBuilder: (context, index) {
                  final nota = listNote[index];
                  return disenoNotas(nota.id!, nota.titulo!, nota.contenido!, nota.fechaEdicion!);
                }
            );
          } else {
            return CircularProgressIndicator();
          }
        },
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
              Row(
                children: [
                  Text(fecha),
                  IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  IconButton(onPressed: () {
                    noteServices.deleteById(id);
                    setState(() {
                      cuerpoApp();
                    });
                  }, icon: Icon(Icons.delete)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
