import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 100),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange[900]!,
              Colors.orange[800]!,
              Colors.orange[400]!,
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
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Icon(Icons.person,
                                size: 50,
                                color: const Color.fromARGB(255, 56, 182, 205))
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
                              color: const Color.fromARGB(255, 42, 195, 218),
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
                buildTextField('Date de naissance', Icons.calendar_today,
                    readOnly: true),
                buildTextField('Cin', Icons.badge),
                buildTextField('Email', Icons.email),
                buildPhoneField(),
                buildDropdownField('Genre', Icons.transgender),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate the form fields
                      if (_formKey.currentState?.validate() ?? false) {
                        // If form is valid, proceed
                        print('Form is valid');
                      } else {
                        print('Form is not valid');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 56, 182, 205),
                      padding:
                          EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Continue',
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

  Widget buildTextField(String labelText, IconData icon,
      {bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
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
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCountryCode,
                    items: countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country['code'],
                        child: Text(
                          '${country['name']} (${country['code']})',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 251, 251, 251)),
                        ),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 253, 253),
                hintText: 'Phone Number',
                hintStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre numéro de téléphone';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownField(String labelText, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.white, // Fond de la liste déroulante en blanc
        style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0)), // Texte en noir
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(
              255, 255, 255, 255), // Fond de l'entrée en blanc
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
        items: ['Male', 'Female', 'Other'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez sélectionner un genre';
          }
          return null;
        },
      ),
    );
  }
}
