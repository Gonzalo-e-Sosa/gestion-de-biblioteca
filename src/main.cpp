#include <windows.h>
#include <sqltypes.h>
#include <sql.h>
#include <sqlext.h>
#include <iostream>

void show_error(unsigned int handletype, const SQLHANDLE& handle) {
    SQLWCHAR sqlstate[1024];
    SQLWCHAR message[1024];
    if (SQL_SUCCESS == SQLGetDiagRec(handletype, handle, 1, sqlstate, NULL, message, 1024, NULL)) {
        std::wcerr << L"Message: " << message << L"\nSQLSTATE: " << sqlstate << std::endl;
    }
}

int main() {
    // Define variables de manejo de conexión y declaración
    SQLHANDLE sqlenvhandle;
    SQLHANDLE sqlconnectionhandle;
    SQLHANDLE sqlstatementhandle;
    
    // Inicializar el entorno de ODBC
    if (SQL_SUCCESS != SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &sqlenvhandle))
        return -1;

    if (SQL_SUCCESS != SQLSetEnvAttr(sqlenvhandle, SQL_ATTR_ODBC_VERSION, (SQLPOINTER)SQL_OV_ODBC3, 0))
        return -1;

    // Inicializar el manejador de conexión
    if (SQL_SUCCESS != SQLAllocHandle(SQL_HANDLE_DBC, sqlenvhandle, &sqlconnectionhandle))
        return -1;

    // Establecer la cadena de conexión
    SQLWCHAR connection_string[] = L"DRIVER={SQL Server};SERVER=localhost;DATABASE=biblioteca;UID=your_username;PWD=your_password;";
    
    // Conectar a la base de datos
    if (SQL_SUCCESS != SQLDriverConnect(sqlconnectionhandle, NULL, connection_string, SQL_NTS, NULL, 0, NULL, SQL_DRIVER_NOPROMPT))
        return -1;

    // Inicializar el manejador de declaración
    if (SQL_SUCCESS != SQLAllocHandle(SQL_HANDLE_STMT, sqlconnectionhandle, &sqlstatementhandle))
        return -1;

    // Ejecutar una consulta de ejemplo
    SQLWCHAR query[] = L"SELECT * FROM Seguridad.Usuario";
    if (SQL_SUCCESS != SQLExecDirect(sqlstatementhandle, query, SQL_NTS))
        show_error(SQL_HANDLE_STMT, sqlstatementhandle);

    // Obtener resultados de la consulta
    SQLLEN user_id, dni, name;
    SQLCHAR name_buffer[50];

    while (SQLFetch(sqlstatementhandle) == SQL_SUCCESS) {
        SQLGetData(sqlstatementhandle, 1, SQL_C_SLONG, &user_id, 0, NULL);
        SQLGetData(sqlstatementhandle, 2, SQL_C_SLONG, &dni, 0, NULL);
        SQLGetData(sqlstatementhandle, 3, SQL_C_WCHAR, name_buffer, sizeof(name_buffer), NULL);

        std::wcout << L"UserID: " << user_id << L", DNI: " << dni << L", Name: " << name_buffer << std::endl;
    }

    // Liberar recursos
    SQLFreeHandle(SQL_HANDLE_STMT, sqlstatementhandle);
    SQLDisconnect(sqlconnectionhandle);
    SQLFreeHandle(SQL_HANDLE_DBC, sqlconnectionhandle);
    SQLFreeHandle(SQL_HANDLE_ENV, sqlenvhandle);

    return 0;
}
