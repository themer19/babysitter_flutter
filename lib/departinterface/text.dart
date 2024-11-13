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
        "Bienvenue dans [Nom de l'application], votre partenaire de confiance pour trouver la baby-sitter idéale. Grâce à notre plateforme, trouvez facilement des gardiens qualifiés et de confiance pour veiller sur vos enfants, que ce soit pour des besoins ponctuels ou réguliers. Des profils vérifiés, des avis transparents et une communication simplifiée pour une tranquillité d'esprit totale. Simplifiez la garde d'enfants, restez serein, nous nous occupons du reste.",
  ),
  Content(
      title: 'Fast Delevery',
      image: 'images/delevery.svg',
      discription:
          "simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the "
          "industry's standard dummy text ever since the 1500s, "
          "when an unknown printer took a galley of type and scrambled it "),
  Content(
      title: 'Reward surprises',
      image: 'images/reward.svg',
      discription:
          "simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the "
          "industry's standard dummy text ever since the 1500s, "
          "when an unknown printer took a galley of type and scrambled it "),
];
