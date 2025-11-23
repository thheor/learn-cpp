#include <mysqlx/xdevapi.h>
#include <iostream>
using namespace mysqlx;
using namespace std;

int main() {
    Session sess("localhost", 33060, "root", "");

    // cara jalanin query mysql
    // use database
    sess.sql("USE testing").execute();

    // QUERY
    SqlResult res = sess.sql(
        "SELECT s.student_id, s.name, sc.pk "
        "FROM student s "
        "JOIN snbt_score sc ON s.snbt_id = sc.snbt_id"
    ).execute();

    // PRINT HASIL QUERY prinsipnya kaya array
    for (auto row : res) {
        std::cout << row[0] << " " << row[1] << " " << row[2] << "\n";
    }
    int option, attempts = 0, jumlahJurusan;
    std::string username, password, email, ptn;
    std::string jurusan;
        
    login:
    cout << "\n=== Login or Register ===\n";
    cout << "1. Login\n" << "2. Register\n" << "Enter option: ";
    cin >> option;
    
    switch (option)
    {
    case 1:
        cout << "Email: ";
        cin >> username;
        cout << "Password: ";
        cin >> password;
        // if password and username does not matched then print invalid input
        break;
    case 2:
        cout << "Email: ";
        cin >> email;
        cout << "Create username: ";
        cin >> username;
        cout << "Create password: ";
        cin >> password;
        // if email is already in the database, print email is already used (using while loop)
        break;
    default:
        cout << "invalid please enter (1-2)\n";
        goto login;
        break;
    }

    int nisn;
    std::string nama, tanggal_lahir, sekolah;
    cout << "\nWelcome " << username << endl;
    cout << "=== Verifikasi biodata ===\n";
    cout << "Nama: ";
    cin >> nama;
    cout << "Tanggal Lahir: ";
    cin >> tanggal_lahir;
    cout << "Sekolah: ";
    cin >> sekolah;
    
    cout << "=== Pendaftaran ===\n";
    cout << "1. SNBP\n";
    cout << "2. SNBT\n";
    cout << "Pilih salah satu: ";
    cin >> option;
    
    switch(option){
        case 1:
        // if nisn is not in the isEligible database, print you are not eligible 
        cout << "=== SNBP ===\n";
        cout << "Masukkan jumlah jurusan (1-4): ";
        cin >> jumlahJurusan;

        for(int i = 0; i < jumlahJurusan; i++){
        cout << "PTN Pilihan " << i << ": ";
        cin >> ptn;
        // sql query
        cout << "Program Studi Pilihan " << i << ": ";
        cin >> jurusan;
        // sql query add where (id, jurusan, ptn)
        // add jurusan and univ in database 
        }
    }

}
