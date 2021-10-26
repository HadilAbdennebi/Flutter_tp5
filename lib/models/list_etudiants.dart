class ListEtudiants {
  int id;
  int codClass;
  String nom;
  String prenom;
  String datNais;
  ListEtudiants(this.id, this.codClass, this.nom, this.prenom, this.datNais);
  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0) ? null : id,
      'codClass': codClass,
      'nom': nom,
      'prenom': prenom,
      'datNais': datNais
    };
  }
}
