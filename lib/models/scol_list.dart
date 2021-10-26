class ScolList {
  int codClass;
  String nomClass;
  int nbreEtud;
  ScolList(this.codClass, this.nomClass, this.nbreEtud);
  Map<String, dynamic> toMap() {
    return {
      'codClass': (codClass == 0) ? null : codClass,
      'nomClass': nomClass,
      'nbreEtude': nbreEtud,
    };
  }
}
