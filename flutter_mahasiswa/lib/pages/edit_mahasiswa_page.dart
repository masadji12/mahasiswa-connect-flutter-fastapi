// pages/edit_mahasiswa_page.dart

import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../services/api_services.dart';

class EditMahasiswaPage extends StatefulWidget {
  final Mahasiswa mahasiswa;

  const EditMahasiswaPage({super.key, required this.mahasiswa});

  @override
  State<EditMahasiswaPage> createState() => _EditMahasiswaPageState();
}

class _EditMahasiswaPageState extends State<EditMahasiswaPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController namaController;
  late TextEditingController nimController;
  late TextEditingController idProvController;
  late TextEditingController angkatanController;
  late TextEditingController tinggiController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.mahasiswa.nama);
    nimController = TextEditingController(text: widget.mahasiswa.nim);
    idProvController = TextEditingController(text: widget.mahasiswa.id_prov);
    angkatanController = TextEditingController(text: widget.mahasiswa.angkatan);
    tinggiController = TextEditingController(text: widget.mahasiswa.tinggi_badan.toString());
  }

  @override
  void dispose() {
    namaController.dispose();
    nimController.dispose();
    idProvController.dispose();
    angkatanController.dispose();
    tinggiController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    Map<String, dynamic> data = {
      'nama': namaController.text,
      'nim': nimController.text,
      'id_prov': idProvController.text,
      'angkatan': angkatanController.text,
      'tinggi_badan': int.tryParse(tinggiController.text),
    };

    // Hapus field kosong/null agar sesuai PATCH
    data.removeWhere((key, value) => value == null || value.toString().isEmpty);

    bool success = await ApiServices.updateMahasiswa(widget.mahasiswa.id, data);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil diperbarui')),
      );
      Navigator.pop(context, true); // Kembali ke halaman sebelumnya
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memperbarui data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Mahasiswa")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: namaController, decoration: const InputDecoration(labelText: 'Nama')),
              TextFormField(controller: nimController, decoration: const InputDecoration(labelText: 'NIM')),
              TextFormField(controller: idProvController, decoration: const InputDecoration(labelText: 'ID Provinsi')),
              TextFormField(controller: angkatanController, decoration: const InputDecoration(labelText: 'Angkatan')),
              TextFormField(controller: tinggiController, decoration: const InputDecoration(labelText: 'Tinggi Badan'), keyboardType: TextInputType.number),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text('Simpan Perubahan')),
            ],
          ),
        ),
      ),
    );
  }
}
