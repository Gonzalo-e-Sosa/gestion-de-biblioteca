#include "Autor.h"
#include "Categoria.h"

class Libro
{
private:
    string titulo;
    Autor autor;
    Categoria categoria;
    unsigned cantpag;
    //fecha fechaPublicacion
public:
    /*
    Libro(string titulo, string autor, string categoria, string cantpag, string fechaPublicacion);
    Libro(string titulo, string autor, string categoria, unsigned cantpag, string fechaPublicacion);
    Libro(string titulo, Autor autor, Categoria categoria, unsigned cantpag, string fechaPublicacion);
    */
    inline string getTitulo() const {return this->titulo;};
    inline Autor getAutor() const {return this->autor;};
    inline Categoria getCategoria() const {return this->categoria;};
    inline unsigned getCantpag() const {return this->cantpag;};
    // inline Fecha getFechaPublicacion() const {return this->fechaPublicacion;};

    //~Libro();
};