import 'package:flutter/material.dart';
import 'package:flutter_mahasiswa/pages/edit_mahasiswa_page.dart';
import 'package:flutter_mahasiswa/services/api_services.dart';
import '../models/mahasiswa.dart';

class DetailMahasiswaPage extends StatelessWidget {
  final Mahasiswa mahasiswa;

  const DetailMahasiswaPage({super.key, required this.mahasiswa});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Detail Mahasiswa'),),),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20,),

            Text('Nama: ${mahasiswa.nama}', style: TextStyle(fontSize: 20),),
            Text('NIM: ${mahasiswa.nim}', style: TextStyle(fontSize: 20),),
            Text('Angkatan: ${mahasiswa.angkatan}', style: TextStyle(fontSize: 20),),
            Text('Tinggi Badan: ${mahasiswa.tinggi_badan} cm', style: TextStyle(fontSize: 20),),

            SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => EditMahasiswaPage(mahasiswa: mahasiswa)
                      )
                    );
                  }, 
                  child: const Text('Edit'),
                ),
                const SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () async{
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Konfirmasi'),
                        content: Text('yakin ingin menghapus dati ini?'),
                        actions: [
                          TextButton(
                            child: Text('Batal'),
                            onPressed: () => Navigator.of(context).pop(false)
                          ),

                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true), 
                            child: Text('Hapus')
                          )
                        ],
                      )
                    );
                    if (confirm == true) {
                      try {
                        await ApiServices.deletemahasiswa(mahasiswa.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Data berhasil dihapus')),
                        );
                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gagal Menghapus data')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Hapus'))
              ],
            )
          ],
        ),
      ),
    );
  }
}