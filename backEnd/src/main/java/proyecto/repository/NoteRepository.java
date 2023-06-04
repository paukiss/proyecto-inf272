package proyecto.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import proyecto.model.Nota;

public interface NoteRepository extends JpaRepository<Nota, Long> {

}
