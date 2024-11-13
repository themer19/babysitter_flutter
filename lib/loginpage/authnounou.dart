import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Authnounou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink[500]!,
              Colors.pink[400]!,
              Colors.pink[200]!,
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
                  Image.asset(
                    "images/motherhood.png",
                    width: 150,
                    height: 150,
                  ),
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
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.credit_card,
                          color: Color.fromARGB(179, 0, 0, 0)),
                      hintText: 'ID',
                      hintStyle: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.lock, color: Color.fromARGB(179, 0, 0, 0)),
                      hintText: 'Mot de passe',
                      hintStyle: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
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
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    margin: EdgeInsets.all(25),
                    child: TextButton(
                      child: Text(
                        'Je suis Maman',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 128, 255, 64),
                        foregroundColor: Colors.white,
                        minimumSize:
                            Size(20, 50), // Largeur = 200, Hauteur = 50
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Divider(color: Colors.white54),
                  SizedBox(height: 32.0),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Vous n'avez pas de compte ? envoyer une demande de travailleur",
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
