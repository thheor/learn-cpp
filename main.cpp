#include <mysqlx/xdevapi.h>
#include <iostream>
using namespace mysqlx;
using namespace std;

Session sess("localhost", 33060, "root", "");
Schema db = sess.getSchema("snpmb");

bool isEligible(std::string id){
    Table tab = db.getTable("akun");

    return false;
}

template <typename T> T data(std::string table, std::string value, std::string where, std::string param){
    Table tab = db.getTable(table);
    
    RowResult res = tab.select(value).where(where + " = :param").bind("param", param).execute();

    Row row = *res.begin();

    return row[0].get<T>();
}

int main() {
    
    // cara jalanin query mysql
    // use database
    // sess.sql("USE snpmb").execute();
    Table tab = db.getTable("akun_user");
    RowResult res;
    DocResult docs;
    Collection myColl = db.getCollection("myCollection");

    // QUERY
    // SqlResult res = sess.sql(
    //     "SELECT s.student_id, s.name, sc.pk "
    //     "FROM student s "
    //     "JOIN snbt_score sc ON s.snbt_id = sc.snbt_id"
    // ).execute();

    // // PRINT HASIL QUERY prinsipnya kaya array
    // for (auto row : res) {
    //     std::cout << row[0] << " " << row[1] << " " << row[2] << "\n";
    // }

    int option, attempts = 0, jumlahJurusan, userId;
    std::string username, password, email, ptn, tanggalLahir;
    std::string jurusan;
    bool isExist;
        
    login:
    cout << "\n=== Login or Register ===\n";
    cout << "1. Login\n" << "2. Register\n" << "Enter option: ";
    cin >> option;
    
    switch (option)
    {
    case 1:
        cout << "Email: ";
        cin >> email;
        cout << "Password: ";
        cin >> password;
        username = data<std::string>("akun_user", "nama_user", "email", email);
        userId = data<int>("akun_user", "id_user", "email", email);

        // if password and username does not matched then print invalid input
        break;
    case 2:
        cout << "Email: ";
        cin >> email;
        cout << "Create username: ";
        cin >> username;
        cout << "Create password: ";
        cin >> password;
        cout << "Tanggal lahir [YYYY-MM-DD]: ";
        cin >> tanggalLahir;

        res = tab.select("email").where("email = :param").bind("param", email).execute();
        isExist = res.count() > 0;
        if(isExist){
            cout << "Email is already registered!\n";
            goto login;
        }

        cout << "Register account successfully!\n";
        break;
    default:
        cout << "Invalid input! Please enter (1-2)\n";
        goto login;
        break;
    }

    do{
        // res = tab.select("nama").where("id = :param").bind("param", id).execute();
        cout << "\nWelcome " << username << endl;
        cout << "Your ID is " << userId << endl;
        cout << "=== MENU UTAMA ===\n";    
        cout << "1. Verifikasi Data Siswa dan Sekolah\n";
        cout << "2. Pendaftaran SNBP\n";
        cout << "3. Pendaftaran UTBK-SNBT\n";
        cout << "4. Exit\n";

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
        // cout << "NISN: ";
        // cout << "NIK: ";
        // cout << "Jenis kelamin: ";
        // cout << "Jurusan: ";
        // cout << "Tahun lulus: ";
        // cout << "No HP: ";
        // cout << "Agama: ";
        // cout << "Alamat: ";
        // cout << "Penghasilan ayah: ";
        // cout << "Penghasian ibu: ";
        // cout << "Jumlah tanggungan: ";

        cout << "=== Pendaftaran ===\n";
        cout << "1. SNBP\n";
        cout << "2. SNBT\n";
        cout << "Pilih salah satu: ";
        cin >> option;
        
        bool reInput = true;
        char confirm;
        switch(option){
            case 1:
            // if nisn is not in the isEligible database, print you are not eligible 
            while(reInput){

                cout << "=== SNBP ===\n";
                cout << "Masukkan jumlah jurusan (1-4): ";
                cin >> jumlahJurusan;
                
            for(int i = 0; i < jumlahJurusan; i++){
            cout << "PTN Pilihan " << i + 1 << ": ";
            cin >> ptn;
            // sql query
            cout << "Program Studi Pilihan " << i + 1 << ": ";
            cin >> jurusan;
            // sql query add where (id, jurusan, ptn)
            // add jurusan and univ in database 
            }
            cout << "Ketik [Y/y] jika sudah benar \n => ";
            cin >> confirm;

            confirm == 'Y' || 'y' ? reInput = false : reInput = true;
            }

            break;
        case 2:
            break;
        default:
            break;
            }
    }while(option != 4);
    
    sess.close();

}