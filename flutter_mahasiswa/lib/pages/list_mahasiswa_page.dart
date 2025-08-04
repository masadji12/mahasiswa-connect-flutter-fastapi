import 'package:flutter/material.dart';
import 'package:flutter_mahasiswa/pages/detail_mahasiswa_page.dart';
import '../models/mahasiswa.dart';
import '../services/api_services.dart';

class ListMahasiswaPage extends StatefulWidget {
  const ListMahasiswaPage({super.key});

  @override
  State<ListMahasiswaPage> createState() => _ListMahasiswaPageState();
}

class _ListMahasiswaPageState extends State<ListMahasiswaPage> {
  late Future<List<Mahasiswa>> futureMahasiswa;

  @override
  void initState(){
    super.initState();
    futureMahasiswa = ApiServices.fetchMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('List  Mahasiswa')), backgroundColor: Colors.blue),
      body: FutureBuilder(
        future: futureMahasiswa, 
        builder: (context, snapshot){
          if (snapshot.hasData) {
            final mahasiswaList = snapshot.data!;
            return ListView.builder(
              itemCount: mahasiswaList.length,
              itemBuilder: (context, index){
                final mhs = mahasiswaList[index];
                return ListTile(
                  title: Text(mhs.nama),
                  subtitle: Text('NIM: ${mhs.nim} - Angkatan: ${mhs.angkatan}'),
                  trailing: Text('${mhs.tinggi_badan} cm'),
                  onTap: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => DetailMahasiswaPage(mahasiswa: mhs))
                    );
                  },
                );
              }
            );
          }else if(snapshot.hasError){
            return Center(child: Text('Terjadi Kesalahan: ${snapshot.error}'),);
          }else {
            return const Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}