import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mahasiswa.dart';

class ApiServices {
  static const String baseUrl = 'http://192.168.1.29:8000'; // gunakan IP laptop

  static Future<List<Mahasiswa>> fetchMahasiswa() async{
    final response = await http.get(Uri.parse('$baseUrl/mahasiswa'));

    if (response.statusCode == 200){
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Mahasiswa.fromJson(data)).toList();
    }else {
      throw Exception('Gagal Memuat data mahasiswa');
    }
  }


  static Future<Map<String, dynamic>?> addMahasiswa(Map<String, dynamic> data) async {
  final response = await http.post(
    Uri.parse('$baseUrl/mahasiswa'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    return null;
  }
}
  static Future<void> deletemahasiswa(int id) async{
    final response = await http.delete(
      Uri.parse('$baseUrl/mahasiswa/$id')
    );

    if(response.statusCode != 200){
      throw Exception('Gagal menghapus data mahasiswa');
    }
  }

  static Future<bool> updateMahasiswa(int id, Map<String, dynamic> data) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/mahasiswa/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Gagal update: ${response.statusCode} - ${response.body}');
      return false;
    }
  }
}