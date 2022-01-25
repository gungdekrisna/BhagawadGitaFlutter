class Sloka {
  String isiSloka;
  String isiTerjemahan;
  String klasifikasi;
  int bab;
  int sloka;
  String audioTerjemahan;

  Sloka({
    required this.isiSloka,
    required this.isiTerjemahan,
    required this.klasifikasi,
    required this.bab,
    required this.sloka,
    required this.audioTerjemahan
  });

  factory Sloka.fromJson(Map<String, dynamic> json) {
    return Sloka(
      isiSloka: json['isi_sloka'],
      isiTerjemahan: json['isi_terjemahan'],
      klasifikasi: json['klasifikasi'],
      bab: json['bab'],
      sloka: json['sloka'],
      audioTerjemahan: json['mp3_terjemahan']
    );
  }
}