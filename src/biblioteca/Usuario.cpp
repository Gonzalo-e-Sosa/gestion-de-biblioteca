#include "../../include/biblioteca/Usuario.h"
#include<stdexcept>
#include<functional>

Usuario::Usuario(string dni, string nombre, string correo, string clave)
: nombre(nombre)
{
    setDni(dni);
    setCorreo(correo);
    setClave(clave);
}
    
// Setters
void Usuario::setDni(const string& nuevoDni){
    // Comprobar si el DNI es un número
    char* end;
    long dni = strtol(nuevoDni.c_str(), &end, 10);

    // Verificar si toda la cadena se convirtió a un número y el puntero final apunta al final de la cadena
    if (*end != '\0' || errno == ERANGE) {
        // Lanzar una excepción si la conversión no fue exitosa
        throw std::invalid_argument("El DNI debe ser un número válido.");
    }

    this->dni = dni;
};

void Usuario::setNombre(const string& nuevoNombre)
{
    this->nombre = nuevoNombre;
};

void Usuario::setCorreo(const string& nuevoCorreo)
{
    if(nuevoCorreo.find('@') == string::npos)
       throw "El correo no posee arroba";

    this->correo = nuevoCorreo;
};

void Usuario::setClave(const string& nuevaClave)
{
    return;    
};

// Clave
bool Usuario::autenticar(const string& claveIngresada) const{
    return 1;
};

void Usuario::cambiarClave(const string& nuevaClave)
{
    return;
};

/*Este método permitiría restablecer la clave del usuario a un valor predeterminado o enviar una nueva clave por correo electrónico.*/
void Usuario::restablecerClave()
{
    return;
};

// Verificación de Permisos 
bool Usuario::tienePermisoAdmin() const {return 1;};
bool Usuario::tienePermisoBibliotecario() const {return 1;};
bool Usuario::tienePermisoUsuario() const{return 1;};

// Resgistro de Actividad
/*Estos métodos podrían registrar la actividad del usuario, como la hora y fecha de inicio y cierre de sesión, lo cual es útil para auditoría y seguimiento de actividades.*/
void Usuario::registrarInicioSesion(){return;};
void Usuario::registrarCierreSesion(){return;};
