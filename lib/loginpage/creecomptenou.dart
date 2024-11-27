import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart'; // Import du package file_picker

class Creecomptenou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.teal,
      ),
      home: FillProfileScreen(),
    );
  }
}

class FillProfileScreen extends StatefulWidget {
  @override
  _FillProfileScreenState createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  File? _image;
  String? _filePath; // Variable pour stocker le chemin du fichier sélectionné
  TextEditingController dateNaissanceController =
      TextEditingController(); // Contrôleur pour la date de naissance

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  // Fonction pour sélectionner un fichier
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // On autorise uniquement les fichiers PDF
    );

    if (result != null) {
      setState(() {
        _filePath = result
            .files.single.path; // On récupère le chemin du fichier sélectionné
      });
    } else {
      // L'utilisateur a annulé la sélection
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink[500]!,
              Colors.pink[400]!,
              Colors.pink[200]!,
            ],
          ),
        ),
        child: Scrollbar(
          thumbVisibility: true, // Afficher le curseur de défilement
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Icon(Icons.person,
                                size: 50,
                                color: const Color.fromARGB(255, 128, 255, 64))
                            : null,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 128, 255, 64),
                              shape: BoxShape.circle,
                            ),
                            child:
                                Icon(Icons.edit, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                buildTextField('Nom', Icons.person),
                buildTextField('Prénom', Icons.person),
                buildDateField(), // Remplacer par le champ date de naissance
                buildTextField('Cin', Icons.badge),
                buildTextField('Email', Icons.email),
                buildPhoneField(),
                buildDropdownField('Genre', Icons.transgender),
                SizedBox(height: 20),

                Center(
                  child: ElevatedButton(
                    onPressed:
                        _pickFile, // Appel de la fonction pour sélectionner un fichier
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 128, 255, 64),
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Centre l'icône et le texte
                      children: [
                        Icon(
                          Icons
                              .file_upload, // Icône de téléchargement de fichier
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 10), // Espace entre l'icône et le texte
                        Text(
                          'Déposer votre cv',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),

                // Affichage du chemin du fichier sélectionné
                if (_filePath != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Fichier sélectionné : $_filePath'),
                  ),
                SizedBox(height: 20),

// Champ pour sélectionner une image
                Center(
                  child: ElevatedButton(
                    onPressed: _pickImage, // Fonction pour choisir une image
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 128, 255, 64),
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Centre l'icône et le texte
                      children: [
                        Icon(
                          Icons
                              .camera_alt, // Icône pour indiquer l'action de la caméra ou du dépôt d'image
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 10), // Espace entre l'icône et le texte
                        Text(
                          'Déposer une image de votre carte cin',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),

// Affichage de l'image sélectionnée
                if (_image != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      _image!,
                      height: 200, // Taille de l'image affichée
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),

                SizedBox(height: 20),

                // Bouton de continuation
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 128, 255, 64),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Centre l'icône et le texte
                      children: [
                        Icon(
                          Icons.send, // Icône d'envoi
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 10), // Espace entre l'icône et le texte
                        Text(
                          'Envoyer votre demande',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, IconData icon,
      {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        readOnly: readOnly,
        style: TextStyle(
            color: Colors.black), // Ajout de cette ligne pour le texte en noir
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255), // Fond blanc
          prefixIcon: Icon(icon,
              color: const Color.fromARGB(255, 0, 0, 0)), // Icône en noir
          labelText: labelText,
          labelStyle: TextStyle(
              color:
                  const Color.fromARGB(255, 0, 0, 0)), // Texte du label en noir
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildPhoneField() {
    final List<Map<String, String>> countries = [
      {'name': 'Tunisia', 'code': '+216'},
      {'name': 'United States', 'code': '+1'},
      {'name': 'France', 'code': '+33'},
      {'name': 'Germany', 'code': '+49'},
      // Ajoutez d'autres pays ici
    ];

    String selectedCountryCode = countries.first['code']!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: selectedCountryCode,
              onChanged: (value) {
                setState(() {
                  selectedCountryCode = value!;
                });
              },
              items: countries.map<DropdownMenuItem<String>>((country) {
                return DropdownMenuItem<String>(
                  value: country['code']!,
                  child: Text('${country['code']} ${country['name']}'),
                );
              }).toList(),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                labelText: 'Phone number',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: dateNaissanceController,
        readOnly: true, // On empêche l'utilisateur de saisir manuellement
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          prefixIcon: Icon(Icons.calendar_today, color: Colors.black),
          labelText: 'Date de naissance',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        onTap: () async {
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (selectedDate != null) {
            setState(() {
              dateNaissanceController.text = "${selectedDate.toLocal()}"
                  .split(' ')[0]; // Format YYYY-MM-DD
            });
          }
        },
      ),
    );
  }

  Widget buildDropdownField(String labelText, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        items: <String>['Homme', 'Femme', 'Autre']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {},
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          prefixIcon: Icon(icon, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
