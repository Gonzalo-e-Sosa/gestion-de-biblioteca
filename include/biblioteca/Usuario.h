#include<string>

using namespace std; 

class Usuario
{
private:
    unsigned dni;
    string nombre;
    string correo;
    string clave;
    //fecha fechaCreacion
public:
    // Inicialización
    Usuario(string dni, string nombre, string correo, string clave);
    //Usuario(unsigned dni, string nombre, string correo, string clave);

    // Getters
    inline int getDni() const { return this->dni; };
    inline string getNombre() const { return this->nombre; };
    inline string getCorreo() const { return this->correo; };

    // Setters
    void setDni(const string& nuevoDni);
    void setNombre(const string& nuevoNombre);
    void setCorreo(const string& nuevoCorreo);
    void setClave(const string& nuevaClave);

    // Clave
    bool autenticar(const string& claveIngresada) const;
    void cambiarClave(const string& nuevaClave);
    void restablecerClave();
    /*Este método permitiría restablecer la clave del usuario a un valor predeterminado o enviar una nueva clave por correo electrónico.*/

    // Verificación de Permisos 
    bool tienePermisoAdmin() const;
    bool tienePermisoBibliotecario() const;
    bool tienePermisoUsuario() const;

    // Resgistro de Actividad
    void registrarInicioSesion();
    void registrarCierreSesion();
    /*Estos métodos podrían registrar la actividad del usuario, como la hora y fecha de inicio y cierre de sesión, lo cual es útil para auditoría y seguimiento de actividades.*/

    // Destructor
    //~Usuario();
};

