import 'package:app/loginpage/authnounou.dart';
import 'package:app/loginpage/creecompteM.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Authmaman extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange[900]!,
              Colors.orange[800]!,
              Colors.orange[400]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image du logo
                  Image.asset(
                    "images/mother.png",
                    width: 150,
                    height: 150,
                  ),
                  // Titre de la page
                  Text(
                    "Se connecter",
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.0),
                  // Champ Email
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email,
                          color: Color.fromARGB(179, 0, 0, 0)),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(height: 16.0),
                  // Champ Mot de passe
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.lock, color: Color.fromARGB(179, 0, 0, 0)),
                      hintText: 'Mot de passe',
                      hintStyle: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility, color: Colors.white70),
                        onPressed: () {},
                      ),
                    ),
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(height: 8.0),
                  // Option 'Enregistrer'
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (bool? value) {},
                        activeColor: Color.fromARGB(255, 56, 182, 205),
                      ),
                      Text(
                        'Enregistrer',
                        style: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  // Bouton de connexion
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 56, 182, 205),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Se connecter',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Lien Mot de passe oublié
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Bouton "Je suis une assistante"
                  Container(
                    margin: EdgeInsets.all(25),
                    child: TextButton(
                      child: Text(
                        'Je suis Une assistante',
                        style: TextStyle(fontSize: 20.0),
                        textAlign: TextAlign
                            .center, // Texte centré à l'intérieur du bouton
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 241, 8, 129),
                        foregroundColor: Colors.white,
                        minimumSize:
                            Size(200, 50), // Largeur = 200, Hauteur = 50
                        padding: EdgeInsets.symmetric(
                            vertical:
                                15), // Pour s'assurer que le texte est bien centré verticalement
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Authnounou(), // Page suivante
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  // Séparateur et autres options de connexion
                  Divider(color: Colors.white54),
                  SizedBox(height: 16.0),
                  Text(
                    'ou continuez avec',
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.facebook, color: Colors.blue),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.g_mobiledata, color: Colors.red),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.apple, color: Colors.black),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.0),
                  // Lien pour s'inscrire
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Creecomptem(), // Page suivante
                          ),
                        );
                      },
                      child: Text(
                        "Vous n'avez pas de compte ? S'inscrire",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
