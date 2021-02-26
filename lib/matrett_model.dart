class MatrettModel {
  String navn;
  String beskrivelse;
  String bilde;
  String pris;

  MatrettModel({this.navn, this.beskrivelse, this.bilde, this.pris});

  factory MatrettModel.fromJson(dynamic json) {
    return MatrettModel(
      navn: "${json['navn']}",
      beskrivelse: "${json['beskrivelse']}",
      bilde: "${json['bilde']}",
      pris: "${json['pris']}",
    );
  }

  Map toJson() =>
      {"navn": navn, "bilde": bilde, "beskrivelse": beskrivelse, "pris": pris};
}
