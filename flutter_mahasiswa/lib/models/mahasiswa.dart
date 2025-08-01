class Mahasiswa{
  final int id;
  final String nama;
  final String nim;
  final String id_prov;
  final int angkatan;
  final int tinggi_badan;

  Mahasiswa({
    required this.id,
    required this.nama,
    required this.nim,
    required this.id_prov,
    required this.angkatan,
    required this.tinggi_badan,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json){
    return Mahasiswa(
      id: json['id'], 
      nama: json['nama'], 
      nim: json['nim'], 
      id_prov: json['id_prov'], 
      angkatan: json['angkatan'], 
      tinggi_badan: json['tinggi_badan']
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'nama': nama,
      'nim': nim,
      'id_prov': id_prov,
      'angkatan': angkatan,
      'tinggi_badan': tinggi_badan,
    };
  }
}