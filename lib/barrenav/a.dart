import 'package:flutter/material.dart';

class BabySitterReservationPage extends StatelessWidget {
  const BabySitterReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réservation Baby-sitter'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Informations de l'enfant",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Champ pour le nom de l'enfant
              TextField(
                decoration: InputDecoration(
                  labelText: "Nom de l'enfant",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Champ pour l'âge de l'enfant
              TextField(
                decoration: InputDecoration(
                  labelText: "Âge de l'enfant",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              const Text(
                "Date et heure de réservation",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Champ pour sélectionner la date
              TextField(
                decoration: InputDecoration(
                  labelText: "Sélectionner une date",
                  suffixIcon: Icon(Icons.calendar_today),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onTap: () async {
                  // Ouvre un sélecteur de date
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    // Mettre à jour la date sélectionnée
                  }
                },
                readOnly: true,
              ),
              const SizedBox(height: 10),
              // Champ pour sélectionner l'heure
              TextField(
                decoration: InputDecoration(
                  labelText: "Sélectionner une heure",
                  suffixIcon: Icon(Icons.access_time),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onTap: () async {
                  // Ouvre un sélecteur d'heure
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    // Mettre à jour l'heure sélectionnée
                  }
                },
                readOnly: true,
              ),
              const SizedBox(height: 20),
              const Text(
                "Notes supplémentaires",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Champ pour des notes supplémentaires
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Ajouter des instructions ou des remarques",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Bouton de soumission
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Ajouter la logique de soumission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Réservation soumise avec succès !"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    "Réserver",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
