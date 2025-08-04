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
}