package proyecto.model;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;
import java.util.Date;

@Entity
@Getter
@Setter @NoArgsConstructor @ToString @AllArgsConstructor
@Table(name="nota")
public class Nota implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name="id_note")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long idNote;

    private String titulo;
    private String contenido;
    private Date fechaCreacion = new Date();
    private Date fechaEdicion = new Date();

}
