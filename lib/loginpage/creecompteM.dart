import 'dart:convert';
import 'dart:io';
import 'package:app/loginpage/authmaman.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Creecomptem extends StatelessWidget {
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
  final String defaultImagePath =
      'images/mother.png'; // Assurez-vous que ce chemin est correct
  final _formKey = GlobalKey<FormState>();

  // Contrôleurs pour les champs de texte
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _dateNaissanceController =
      TextEditingController();

  String? _selectedGender;
  String? _selectedEtat;
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Préparer les données à envoyer sans inclure l'image
    Map<String, String> data = {
      'nom': _nomController.text,
      'prenom': _prenomController.text,
      'cin': _cinController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'confpassword': _confirmPasswordController.text,
      'telephone': _phoneController.text,
      'genre': _selectedGender ?? '',
      'etat': _selectedEtat ?? '',
      'adresse': "tunis",
      'daten': _dateNaissanceController.text,
      'role': "parent",
    };

    try {
      // Création de la requête multipart
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.1.18:8088/auth/addParent'), // Remplacez par votre URL
      );

      // Ajout des champs texte
      request.fields.addAll(data);

      // Ajout de l'image si elle existe
      if (_image != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image', // Nom du champ pour le serveur
          _image!.path,
        ));
      }

      // Envoi de la requête
      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (responseData.statusCode == 200) {
        // Succès
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Compte créé avec succès'),
          backgroundColor: Colors.green,
        ));
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Demande de creation du compte'),
            content: Text(
                'Cette demande a été traitée avec succès.Votre compte serai active dans 24H'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Authmaman(), // Remplace NouvellePage() par ta classe de page
                    ),
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Décoder la réponse JSON
        final data = json.decode(responseData.body);

        // Extraire les informations nécessaires
        final timestamp = data['timestamp'] ?? 'Inconnu';
        final status = data['status'] ?? 'Inconnu';
        final error = data['error'] ?? 'Erreur inconnue';
        final path = data['path'] ?? 'Chemin non spécifié';

        // Vérifier les détails de l'erreur (si disponibles)
        final details = data['details'];
        String fieldErrorMessage = '';
        if (details != null && details is Map) {
          final field = details['field'] ?? 'Inconnu';
          final message = details['message'] ?? 'Erreur dans les données.';
          fieldErrorMessage = '\nChamp: $field\nProblème: $message';
        }

        // Construire un message d'erreur détaillé
        final errorMessage =
            'Erreur $status: $error\nChemin: $path\nHeure: $timestamp$fieldErrorMessage';
        print(data['etat']);
        // Afficher le message dans le SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: const Color.fromARGB(255, 54, 67, 244),
          ),
        );
      }
    } catch (e) {
      // Erreur réseau
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Une erreur est survenue : $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red[200]!,
              Colors.red[300]!,
              Colors.red[100]!,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : AssetImage(defaultImagePath) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 42, 195, 218),
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
                buildTextField('Nom', Icons.person, _nomController),
                buildTextField('Prénom', Icons.person, _prenomController),
                buildTextField('Cin', Icons.badge, _cinController),
                buildTextField('Email', Icons.email, _emailController),
                buildTextField('Mot de passe', Icons.lock, _passwordController,
                    obscureText: true),
                buildTextField('Confirmation mot de passe', Icons.lock,
                    _confirmPasswordController,
                    obscureText: true),
                buildTextField(
                    'Adresse', Icons.location_on, _adresseController),
                buildTextField('Date de Naissance', Icons.calendar_today,
                    _dateNaissanceController),
                buildPhoneField(),
                buildDropdownField('Genre', ['Homme', 'Femme', 'Autre'],
                    (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                }),
                buildDropdownField('Etat', ['marie', 'divorce', 'veuf'],
                    (value) {
                  setState(() {
                    _selectedEtat = value;
                  });
                }),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 56, 182, 205),
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Continuer',
                      style: TextStyle(color: Colors.white, fontSize: 18),
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

  Widget buildTextField(
      String labelText, IconData icon, TextEditingController controller,
      {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: Colors.black),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: labelText == 'Date de Naissance'
            ? TextInputType.none
            : TextInputType.text,
        onTap: labelText == 'Date de Naissance'
            ? () async {
                // Montre le sélecteur de date lorsque le champ est tapé
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  controller.text = "${pickedDate.toLocal()}"
                      .split(' ')[0]; // Formate la date
                }
              }
            : null, // Pas d'action pour le champ d'adresse

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Ce champ ne peut pas être vide';
          }
          return null;
        },
      ),
    );
  }

  Widget buildPhoneField() {
    return buildTextField('Numéro de téléphone', Icons.phone, _phoneController);
  }

  Widget buildDropdownField(
      String label, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        value: label == 'Genre' ? _selectedGender : _selectedEtat,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: TextStyle(color: Colors.black)),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(Icons.transgender, color: Colors.black),
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(color: Colors.black),
        validator: (value) {
          if (value == null) {
            return 'Veuillez sélectionner $label';
          }
          return null;
        },
      ),
    );
  }
}
