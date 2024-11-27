import 'package:app/loginpage/authnounou.dart';
import 'package:app/loginpage/creecompteM.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Authmaman extends StatefulWidget {
  @override
  _AuthmamanState createState() => _AuthmamanState();
}

class _AuthmamanState extends State<Authmaman> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  void _validateAndSubmit() {
    setState(() {
      _emailError = _validateEmail(_emailController.text);
      _passwordError = _passwordController.text.isEmpty
          ? 'Veuillez entrer un mot de passe'
          : null;
    });

    if (_emailError == null && _passwordError == null) {
      // Tous les champs sont valides, vous pouvez continuer avec l'action de connexion.
      print('Validation réussie, traitement de la connexion');
    } else {
      print('Validation échouée, veuillez remplir les champs correctement');
    }
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Veuillez entrer un email';
    } else if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$').hasMatch(email)) {
      return 'Veuillez entrer un email valide';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red[200]!,
              Colors.red[300]!,
              Colors.red[100]!,
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
                    controller: _emailController,
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
                      errorText: _emailError,
                    ),
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(height: 16.0),
                  // Champ Mot de passe
                  TextField(
                    controller: _passwordController,
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
                      errorText: _passwordError,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility, color: Colors.white),
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
                    onPressed: _validateAndSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[200],
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
                      style: TextStyle(color: Colors.white),
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
                        backgroundColor: Colors.blue[200],
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
                  Divider(color: Colors.white),
                  SizedBox(height: 16.0),
                  Text(
                    'ou continuez avec',
                    style: TextStyle(color: Colors.white),
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
                        style: TextStyle(color: Colors.white),
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
