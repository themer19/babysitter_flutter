class Content {
  String image;
  String title;
  String discription;

  Content(
      {required this.image, required this.title, required this.discription});
}

List<Content> contents = [
  Content(
    title: 'BABY-SITTER',
    image: 'images/bebe1.png',
    discription:
        "Bienvenue dans Bambino, votre partenaire de confiance pour trouver la baby-sitter idéale. Grâce à notre plateforme, trouvez facilement des gardiens qualifiés et de confiance pour veiller sur vos enfants, que ce soit pour des besoins ponctuels ou réguliers. Des profils vérifiés, des avis transparents et une communication simplifiée pour une tranquillité d'esprit totale. Simplifiez la garde d'enfants, restez serein, nous nous occupons du reste.",
  ),
  Content(
      title: 'Recherche de baby-sitter',
      image: 'images/bebe2..png',
      discription:
          " Les parents peuvent rechercher des baby-sitters en fonction de critères tels que la localisation, les qualifications, les évaluations, et les disponibilités. "),
  Content(
      title: 'Messagerie intégrée',
      image: 'images/chat.png',
      discription:
          "Un système de messagerie permet aux parents et aux baby-sitters de communiquer avant, pendant, et après la garde, pour confirmer les détails et résoudre d’éventuelles questions. "),
];
