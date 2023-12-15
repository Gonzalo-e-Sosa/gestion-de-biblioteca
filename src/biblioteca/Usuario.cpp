#include "../../include/biblioteca/Usuario.h"
#include<stdexcept>
#include<algorithm>
#include<cctype>

Usuario::Usuario(string dni, string nombre, string correo, string clave)
{
    setDni(dni);
    setNombre(nombre);
    setCorreo(correo);
    setClave(clave);
}
    
// Setters
void Usuario::setDni(const string& nuevoDni){
    // Comprobar si el DNI es un número
    if (!all_of(nuevoDni.begin(), nuevoDni.end(), ::isdigit)) {
        throw invalid_argument("El DNI debe ser un número válido.");
    }
    
    char* end;
    long dni = strtol(nuevoDni.c_str(), &end, 10);

    // Verificar si toda la cadena se convirtió a un número y el puntero final apunta al final de la cadena
    if (*end != '\0' || errno == ERANGE) {
        throw invalid_argument("El DNI no es un número válido.");
    }

    this->dni = dni;
};

void Usuario::setNombre(const string& nuevoNombre)
{
    if (nuevoNombre.empty() || all_of(nuevoNombre.begin(), nuevoNombre.end(), ::isspace)) {
        throw invalid_argument("El nombre no puede estar vacío");
    }

    if (nuevoNombre.length() < 3 || nuevoNombre.length() > 50) {
        throw invalid_argument("La longitud del nombre debe estar entre 3 y 50 caracteres.");
    }

    if (!all_of(nuevoNombre.begin(), nuevoNombre.end(), ::isdigit)) {
        throw invalid_argument("El nombre no puede contener solo números.");
    }    

    if (!all_of(nuevoNombre.begin(), nuevoNombre.end(), ::isalnum)) {
        throw invalid_argument("El nombre debe contener letras y números.");
    }
    
    this->nombre = nuevoNombre;
};

void Usuario::setCorreo(const string& nuevoCorreo)
{
    if(nuevoCorreo.find('@') == string::npos)
       throw invalid_argument("El correo no posee arroba.");

    this->correo = nuevoCorreo;
};

void Usuario::setClave(const string& nuevaClave)
{
    if(!all_of(nuevaClave.begin(), nuevaClave.end(), ::isalnum))
        throw invalid_argument("La clave debe contener letras y números.");
    
    
    this->clave = nuevaClave;
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
