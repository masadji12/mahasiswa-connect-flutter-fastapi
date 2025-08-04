import 'package:flutter/material.dart';
import 'package:flutter_mahasiswa/services/api_services.dart';
import '../models/mahasiswa.dart';
import '../services/api_services.dart';
import 'detail_mahasiswa_page.dart';

class TambahMahasiswaPage extends StatefulWidget {
  const TambahMahasiswaPage({super.key});

  @override
  State<TambahMahasiswaPage> createState() => _TambahMahasiswaPageState();
}

class _TambahMahasiswaPageState extends State<TambahMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _idProvController = TextEditingController();
  final TextEditingController _angkatanController = TextEditingController();
  final TextEditingController _tinggiBadanController = TextEditingController();

  void _simpanData() async {
    if (_formKey.currentState!.validate()) {
      final mahasiswaBaru = {
        'nama': _namaController.text,
        'nim': _nimController.text,
        'id_prov': _idProvController.text,
        'angkatan': _angkatanController.text,
        'tinggi_badan': int.tryParse(_tinggiBadanController.text) ?? 0,
      };

      final response = await ApiServices.addMahasiswa(mahasiswaBaru);

      if (response != null) {
        Mahasiswa mahasiswa = Mahasiswa.fromJson(response);

        // Navigasi ke halaman detail setelah berhasil simpan
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailMahasiswaPage(mahasiswa: mahasiswa),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menyimpan data.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Tambah Mahasiswa')), backgroundColor: Colors.blue,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) => value!.isEmpty ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(labelText: 'NIM'),
                validator: (value) => value!.isEmpty ? 'NIM wajib diisi' : null,
              ),
              TextFormField(
                controller: _idProvController,
                decoration: const InputDecoration(labelText: 'ID Provinsi'),
                validator: (value) => value!.isEmpty ? 'ID Provinsi wajib diisi' : null,
              ),
              TextFormField(
                controller: _angkatanController,
                decoration: const InputDecoration(labelText: 'Angkatan'),
                validator: (value) => value!.isEmpty ? 'Angkatan wajib diisi' : null,
              ),
              TextFormField(
                controller: _tinggiBadanController,
                decoration: const InputDecoration(labelText: 'Tinggi Badan'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Tinggi badan wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _simpanData,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
