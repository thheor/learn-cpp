#include <mysqlx/xdevapi.h>
#include <iostream>
#include <vector>
using namespace mysqlx;
using namespace std;

Session sess("localhost", 33060, "root", "");
Schema db = sess.getSchema("snpmb");
RowResult res;
SqlResult sqlRes;
DocResult docs;
Row row;

bool isExist(std::string table, std::string value, std::string where, auto param){
    Table tab = db.getTable(table);

    res = tab.select(value).where(where + " = :param").bind("param", param).execute();
    bool result = res.count() > 0;
    if(!result){
        return false;
    }
    
    return true;
}

template <typename T> T data(std::string table, std::string value, std::string where, auto param){
    Table tab = db.getTable(table);
    
    RowResult res = tab.select(value).where(where + " = :param").bind("param", param).execute();

    Row row = *res.begin();

    return row[0].get<T>();
}

int login(){
    int option, userId;
    std::string username, password, email, tanggalLahir, temp;
    bool exist;

    Table tab = db.getTable("akun_user");
    
    loginRegister:
    cout << "\n=== Login or Register ===\n";
    cout << "1. Login\n" << "2. Register\n" << "Enter option: ";
    cin >> option;
    
    switch (option)
    {
    case 1:
        login:
        cout << "\n=== LOGIN ===\n";
        cout << "Email: ";
        cin >> email;
        cout << "Password: ";
        cin >> password;

        exist = isExist("akun_user", "email", "email", email);
        if(!exist){
            cout << "Your email is not registered!\n";
            goto loginRegister;
        }

        temp = data<std::string>("akun_user", "password", "email", email);
        if(password != temp){
            cout << "Wrong password!\n\n";
            goto login;
        }

        break;
    case 2:
        // Kayanya username mending ganti NISN
        // trus tanggal lahir ganti NPSN
        cout << "\n=== REGISTER ===\n";
        cout << "Email: ";
        cin >> email;
        cout << "Create username: ";
        cin.ignore();
        getline(cin, username);
        cout << "Create password: ";
        cin >> password;
        cout << "Tanggal lahir [YYYY-MM-DD]: ";
        cin >> tanggalLahir;

        exist = isExist("akun_user", "email", "email", email);
        if(exist){
            cout << "Email is already registered!\n";
            goto loginRegister;
        }

        tab.insert("email", "nama_user", "password", "tanggal_lahir")
            .values(email, username, password, tanggalLahir)
            .execute();

        cout << "Register account successfully!\n";
        break;
    default:
        cout << "Invalid input! Please enter (1-2)\n";
        goto login;
        break;
    }

    userId = data<int>("akun_user", "id_user", "email", email);

    return userId;
}

void inputJurusan(std::string type, int userId, int biodataId){
    vector<int> jurusanId;
    std::string jurusan;
    int ptnId, jumlahJurusan, constraint;
    char confirm;
    
    if(type == "SNBP"){
        if(!isExist("biodata", "status_eligible", "id_user", userId)){
            cout << "Maaf anda bukan siswa eligible.\n";
            return;
        } else {
            constraint = 2;
        }
    } else if(type == "SNBT"){
        constraint = 4;
    }

        inputJurusan:
        cout << "Masukkan jumlah jurusan (1-" + to_string(constraint) + "): ";
        cin >> jumlahJurusan;

    if(jumlahJurusan > constraint || jumlahJurusan < 1){
            cout << "Masukkan jumlah jurusan dengan benar!\n";
            goto inputJurusan;
        }

    for(int i = 0; i < jumlahJurusan; i++){
        Table tab = db.getTable("ptn");
        RowResult res = tab.select("nama_ptn").execute();

        cout << "Daftar PTN\n";
        int index = 1;
        for(Row row : res.fetchAll()){
            cout << index << ". " << row.get(0).get<std::string>() << endl;
            index++;
        }

        cout << "PTN Pilihan " << i + 1 << ": ";
        cin >> ptnId;
                    // sql query
        tab = db.getTable("program_studi");
        res = tab.select("nama_prodi").where("id_ptn = :param").bind("param" ,ptnId).execute();
        
        cout << "\nDaftar Prodi\n";
        for(Row row : res.fetchAll()){
            cout << row.get(0).get<std::string>() << endl;
        }
        cin.ignore();
        inputProdi:
        cout << "Program Studi Pilihan " << i + 1 << " [nama prodi]: ";
        getline(cin, jurusan);
        cout << jurusan << endl;
        if(!isExist("program_studi", "nama_prodi", "nama_prodi", jurusan)){
            cout << "Masukkan nama prodi dengan benar!\n";
            goto inputProdi;
        }
        std::string temp = "id_ptn = " + to_string(ptnId) + " && nama_prodi";
        int Id = data<int>("program_studi", "id_prodi", temp, jurusan);
        jurusanId.push_back(Id);
    }

    if(jumlahJurusan == 1){
        Table tab = db.getTable("pendaftaran_snbp");
        tab.insert("id_user", "id_biodata", "id_prodi1")
        .values(userId, biodataId, jurusanId.at(0))
        .execute();
    } else if (jumlahJurusan == 2){
        Table tab = db.getTable("pendaftaran_snbp");
        tab.insert("id_user", "id_biodata", "id_prodi1", "id_prodi2")
        .values(userId, biodataId, jurusanId.at(0), jurusanId.at(1))
        .execute();
    }

    cout << "Berhasil daftar " + type + "!\n";

    jurusanId.clear();
}

int main() {
    Table tab = db.getTable("akun_user");
    int option, userId, biodataId;
    std::string username;

    userId = login();
    bool reInput = true, exist;
    char confirm;

    biodataId = data<int>("biodata", "id_biodata", "id_user", userId);
    
    do{
        cout << "\n=== MENU UTAMA ===\n";
        cout << "1. Verifikasi Data Siswa dan Sekolah\n";
        cout << "2. Pendaftaran SNBP\n";
        cout << "3. Pendaftaran UTBK-SNBT\n";
        cout << "4. Exit\n";
        cout << "Choose [1-4]: ";
        cin >> option;
        
        int nisn, tahunLulus, sekolahId;
        std::string nama, tempat, tanggalLahir, sekolah, jurusan;
        switch(option){
            case 1:
            cout << "\n=== Verifikasi biodata ===\n";

            exist = isExist("biodata", "id_user", "id_user", userId);
            if(exist){
                // Table tab = db.getTable("biodata");
                // RowResult res = tab.select("id_biodata", "id_user", "id_sekolah", "nama_lengkap")
                //             .where("id_user = :param")
                //             .bind("param", userId)
                //             .execute();
                
                sess.sql("USE snpmb").execute();
                SqlResult sqlRes = sess.sql("SELECT b.nisn, b.nama_lengkap, b.tempat_lahir, b.tanggal_lahir, b.jurusan, b.tahun_lulus, sa.nama_sekolah "
                                            "FROM biodata b "
                                            "JOIN sekolah_asal sa ON b.id_sekolah = sa.id_sekolah "
                                            "JOIN akun_user au ON au.id_user = b.id_user "
                                            "WHERE au.id_user = " + std::to_string(userId))
                                            .execute();
                Row row;
                    
                username = data<std::string>("biodata", "nama_lengkap", "id_user", userId);
                cout << "Your data has been verified!\n\n";
                cout << "Welcome " << username << endl;
                while((row = sqlRes.fetchOne())){
                    cout << "NISN: " << row[0] << endl;
                    cout << "Nama: " << row[1] << endl;
                    cout << "Tempat Lahir: " << row[2] << endl;
                    cout << "Tanggal Lahir: " << row[3] << endl;
                    cout << "Jurusan: " << row[4] << endl;
                    cout << "Tahun Lulus: " << row[5] << endl;
                    cout << "Sekolah: " << row[6] << endl;
                }
            } else {
                cout << "NISN: ";
                cin >> nisn;
                cout << "Nama: ";
                cin.ignore();
                getline(cin, nama);
                cout << "Tempat lahir: ";
                cin.ignore();
                getline(cin, tempat);
                cout << "Tanggal Lahir [YYYY-MM-DD]: ";
                cin >> tanggalLahir;
                cout << "Sekolah: ";
                cin.ignore();
                getline(cin, sekolah);
                cout << "Jurusan: ";
                cin.ignore();
                getline(cin, jurusan);
                cout << "Tahun lulus: ";
                cin >> tahunLulus;
                
                sekolahId = data<int>("sekolah_asal", "id_sekolah", "nama_sekolah", sekolah);
                tab = db.getTable("biodata");
                tab.insert("id_user", "id_sekolah", "nisn", "nama_lengkap", "tempat_lahir", "tanggal_lahir", "jurusan", "tahun_lulus")
                    .values(userId, sekolahId, nisn, nama, tempat, tanggalLahir, jurusan, tahunLulus)
                    .execute();

                cout << "Data updated successfully!\n";
            }
            break;
            case 2:
                // if nisn is not in the isEligible database, print you are not eligible 
            exist = isExist("biodata", "id_user", "id_user", userId);
            if(!exist){
                cout << "\nYou have to verify your data first!\n";
                break;
            }
            cout << "\n=== SNBP ===\n";
            inputJurusan("SNBP", userId, biodataId);
                break;
            case 3:

                break;
            case 4:
                cout << "BYE\n";
                break;
            default:
                cout << "Invalid Input! Masukkan angka [1-4]\n";
            break;
        }
    }while(option != 4);
    
    sess.close();
    return 0;
}