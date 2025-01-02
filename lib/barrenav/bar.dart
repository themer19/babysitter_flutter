import 'package:app/barrenav/a.dart';
import 'package:app/barrenav/accu.dart';
import 'package:app/barrenav/chekproduit.dart';
import 'package:app/barrenav/enfant.dart';
import 'package:app/barrenav/messanger.dart';
import 'package:app/barrenav/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Bar extends StatefulWidget {
  final String id;
  const Bar({Key? key, required this.id}) : super(key: key);

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  int _currentIndex = 0; // Indice de l'onglet sélectionné

  // Définir une liste de pages, chaque page correspondant à un bouton
  final List<Widget> _pages = [
    Accu(), // Page d'accueil
    MesEnfantsPage(), // Page de recherche
    BabySitterReservationPage(),
    ChatScreen(), // Page de messagerie
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight:
              80, // Augmente la hauteur de l'AppBar pour intégrer le champ
          backgroundColor: Colors.pink,
          title: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          Colors.white.withOpacity(0.9), // Couleur du fond
                      hintText: "chercher",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Coins arrondis
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(fontSize: 16), // Taille du texte
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart,
                    color: Colors.white), // Icône de panier
                onPressed: () {
                 Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartPage(), // Page suivante
                ),
              );
                },
              ),
            ],
          ),
        ),

        drawer: Navbar(
          
          onItemSelected: (int index) {
            setState(() {
              _currentIndex = index; // Mettre à jour la page affichée
            });
            Navigator.pop(context);
            // Ferme le Drawer
          },
          id: widget.id,
        ),
        body: _pages[_currentIndex], // Afficher la page sélectionnée
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex, // Indice de l'onglet actif
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Met à jour l'indice actif
            });
          },
          selectedItemColor:
              Colors.pink, // Couleur des icônes sélectionnées (rose)
          unselectedItemColor:
              Colors.grey, // Couleur des icônes non sélectionnées (gris)
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Carte',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.child_friendly),
              label: "Mes enfants",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "Messanger",
            ),
          ],
        ),
      ),
    );
  }
}

class Navbar extends StatefulWidget {
  final Function(int) onItemSelected;
  final String id;
  const Navbar({required this.onItemSelected, required this.id, Key? key})
      : super(key: key);
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  String name = "Utilisateur"; // Valeur par défaut
  String email = "email@example.com";
  String id = ""; // Valeur par défaut
  bool isLoading = true; // Indicateur de chargement

  @override
  void initState() {
    super.initState();
    fetchData(); // Charger les données lors de l'initialisation
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://localhost:8088/auth/getid/${widget.id}'); // URL de l'API

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Validation des données reçues
        if (data is Map<String, dynamic>) {
          setState(() {
            id = data['idParent'].toString() ??
                ""; // Utilise une valeur par défaut
            name = data['nom'] ?? "Utilisateur"; // Nom par défaut
            email = data['email'] ?? "email@example.com"; // Email par défaut
            isLoading = false; // Chargement terminé
          });
        } else {
          // Si les données reçues ne sont pas conformes
          print("Données inattendues : $data");
          setState(() {
            isLoading = false;
          });
        }
      } else {
        // Gère les erreurs HTTP
        print('Erreur HTTP ${response.statusCode} : ${response.body}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      // Gère les erreurs réseau ou autres exceptions
      print('Erreur lors de la requête : $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.pink),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                      'assets/images/profile.jpg'), // Remplacez par votre image
                ),
                SizedBox(height: 10),
                Text(
                  'Bonjour, $name',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  '$email',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () => widget.onItemSelected(0),
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Recherche'),
            onTap: () => widget.onItemSelected(1),
          ),
          ListTile(
            leading: Icon(Icons.child_friendly),
            title: Text('Mes enfants'),
            onTap: () => widget.onItemSelected(2),
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Messanger'),
            onTap: () => widget.onItemSelected(3),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètres'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfileScreen(id: widget.id), // Page suivante
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Déconnexion'),
            onTap: () {
              Navigator.pop(context);
              // Ajoutez ici votre logique pour Déconnexion
            },
          ),
        ],
      ),
    );
  }
}
