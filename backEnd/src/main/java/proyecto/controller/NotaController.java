package proyecto.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import proyecto.model.Nota;
import proyecto.services.NoteService;

import java.util.ArrayList;
import java.util.List;

@RestController
@CrossOrigin(origins = "*")
public class NotaController {

    @Autowired
    NoteService noteService;


    @GetMapping("/nota")
    public List<Nota> getNotas() {
        List<Nota> notaList = new ArrayList<Nota>();

        noteService.findAll().forEach(notaList :: add);

        return notaList;
    }

    @PostMapping("/nota")
    public String getNotas(@RequestBody Nota nota) {
        try {
            noteService.save(nota);
            return "Se guardo la nota";
        } catch (Exception e) {
            return "Error al guardar la nota";
        }
    }

    @DeleteMapping("/nota/{id}")
    public String deleteNoteById(@PathVariable("id") Long id) {
        noteService.deleteById(id);
        return "Se logro borrar la nota con Id: " + id;
    }
}
