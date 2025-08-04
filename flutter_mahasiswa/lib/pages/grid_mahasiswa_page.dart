import 'package:flutter/material.dart';
import 'package:flutter_mahasiswa/pages/detail_mahasiswa_page.dart';
import '../models/mahasiswa.dart';
import '../services/api_services.dart';

class GridMahasiswaPage extends StatefulWidget {
  const GridMahasiswaPage({super.key});

  @override
  State<GridMahasiswaPage> createState() => _GridMahasiswaPageState();
}

class _GridMahasiswaPageState extends State<GridMahasiswaPage>{
  late Future<List<Mahasiswa>> _mahasiswaList;

  @override
  void initState(){
    super.initState();
    _mahasiswaList = ApiServices.fetchMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Grid Mahasiswa'),), backgroundColor: Colors.blue,),
      body: FutureBuilder(
        future: _mahasiswaList, 
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Center(child: Text('Terjadi Kesalahan: ${snapshot.error}'),);
          }else if(!snapshot.hasData || snapshot.data!.isEmpty){
            return const Center(child: Text('Tidak ada data mahasiswa'));
          }else {
            final mahasiswa = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1,
              ), 
              padding: const EdgeInsets.all(10),
              itemCount: mahasiswa.length,
              itemBuilder: (context, index){
                final mhs = mahasiswa[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMahasiswaPage(mahasiswa: mhs),
                      ),
                    );
                  },
                  child:  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            mhs.nama,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8,),
                          Text('NIM: ${mhs.nama}'),
                          Text('Angkatan: ${mhs.angkatan}'),
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          }
        }
      ),
    );
  }
}