package proyecto.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import proyecto.model.Nota;
import proyecto.repository.NoteRepository;

import java.util.List;


@Service
public class NoteService {

    @Autowired
    NoteRepository notaRepository;

    public List<Nota> findAll() {
        return notaRepository.findAll();
    }

    public Nota findById(Long Id) {
        return notaRepository.findById(Id).orElse(null);
    }

    public Nota save(Nota note) {
        return notaRepository.save(note);
    }

    public void deleteById(Long Id) {
        notaRepository.deleteById(Id);
    }
}


