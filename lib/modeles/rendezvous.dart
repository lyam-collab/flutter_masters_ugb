class RendezVous {
  int idRV = 0;
  String description = "desc";
  String lieu = "lieu";
  DateTime date = DateTime.now();

  RendezVous(this.description, this.lieu, this.date);

  Map<String, dynamic> toJson() {
    return {"lieu": lieu, "description": description, "date": date};
  }

  @override
  String toString() =>
      'RendezVous(Id:$idRV, description: $description, lieu: $lieu, date:$date)';

  RendezVous.fromJson(Map<String, dynamic> json)
      : idRV = json['id'] ?? json['id'],
        description = json['description'] ?? json['description'],
        lieu = json['lieu'] ?? json['lieu'],
        date = DateTime.parse(json['date'].toString());
}
