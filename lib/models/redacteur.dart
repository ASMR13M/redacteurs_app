class Redacteur {
  final int? id;
  final String nom;
  final String email;

  Redacteur({this.id, required this.nom, required this.email});

  // Convertir en Map pour l'insertion dans la DB
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{'nom': nom, 'email': email};
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Créer un objet à partir d'un Map récupéré de la DB
  factory Redacteur.fromMap(Map<String, dynamic> map) {
    return Redacteur(
      id: map['id'] as int?,
      nom: map['nom'] as String,
      email: map['email'] as String,
    );
  }
}
