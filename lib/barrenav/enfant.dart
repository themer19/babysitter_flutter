import 'package:flutter/material.dart';

class MesEnfantsPage extends StatelessWidget {
  // Exemple de données statiques (peut être remplacé par des données dynamiques)
  final List<Map<String, dynamic>> enfants = [
    {"nom": "Emma", "age": 5, "details": "Aime jouer au dessin."},
    {"nom": "Lucas", "age": 8, "details": "Passionné par les voitures."},
    {"nom": "Léa", "age": 3, "details": "Adore écouter des histoires."},
  ];

  MesEnfantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Enfants'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: enfants.length,
          itemBuilder: (context, index) {
            final enfant = enfants[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.pink.shade100,
                  child: Text(
                    enfant["nom"]![0], // Première lettre du nom
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  enfant["nom"],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Âge : ${enfant["age"]} ans"),
                trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
                onTap: () {
                  // Navigate to details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnfantDetailsPage(
                        nom: enfant["nom"],
                        age: enfant["age"],
                        details: enfant["details"],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

// Page de détails pour un enfant
class EnfantDetailsPage extends StatelessWidget {
  final String nom;
  final int age;
  final String details;

  const EnfantDetailsPage({
    super.key,
    required this.nom,
    required this.age,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de $nom'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nom,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Âge : $age ans",
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              "Détails",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              details,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
