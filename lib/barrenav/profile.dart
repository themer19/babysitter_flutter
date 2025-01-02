import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  final String id;
  const ProfileScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Utilisateur";
  String prenom = "Utilisateur";
  String email = "email@example.com";
  String telephone = "8888888";
  String date = "31/12/2222";
  String id = "";
  bool isLoading = true;
  String profileImageUrl =
      "assets/default_profile.png"; // URL de l'image par défaut

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://localhost:8088/auth/getid/${widget.id}'); // Remplacez par votre URL API

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          id = data['idParent'].toString();
          name = data['nom'] ?? "Utilisateur";
          prenom = data['prenom'] ?? "Utilisateur";
          email = data['email'] ?? "email@example.com";
          telephone = data['telephone'] ?? "8888888";
          date = data['daten'] ?? "31/12/2222";
          profileImageUrl = data['profileImage'] ??
              profileImageUrl; // Mettez à jour l'image du profil
          isLoading = false;
        });
      } else {
        print('Erreur ${response.statusCode} : ${response.body}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Erreur lors de la connexion : $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Code du dialogue de changement de mot de passe...
  void _showPasswordChangeDialog() {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Modifier le mot de passe"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: oldPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Ancien mot de passe",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Nouveau mot de passe",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Confirmer le mot de passe",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
                String oldPassword = oldPasswordController.text;
                String newPassword = newPasswordController.text;
                String confirmPassword = confirmPasswordController.text;

                if (oldPassword.isEmpty ||
                    newPassword.isEmpty ||
                    confirmPassword.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Veuillez remplir tous les champs.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                  );
                } else if (newPassword != confirmPassword) {
                  Fluttertoast.showToast(
                    msg: "Les mots de passe ne correspondent pas.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Mot de passe modifié avec succès!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  );
                  // Implémentez ici votre logique pour enregistrer le nouveau mot de passe
                }
              },
              child: Text("Valider"),
            ),
          ],
        );
      },
    );
  }

  void _showPasswordDialog() {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmer les modifications"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Entrez votre mot de passe pour valider les changements."),
              SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Mot de passe",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (passwordController.text == "votreMotDePasse") {
                  Fluttertoast.showToast(
                    msg: "Changements validés avec succès!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Mot de passe incorrect!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                }
              },
              child: Text("Valider"),
            ),
          ],
        );
      },
    );
  }

  void _showImagePicker() async {
    final ImagePicker _picker = ImagePicker();
    // Affichez un dialogue pour demander à l'utilisateur de choisir entre la galerie ou l'appareil photo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Changer l'image de profil"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo),
                title: Text("Choisir depuis la galerie"),
                onTap: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    _updateProfileImage(File(image
                        .path)); // Appeler une méthode pour mettre à jour l'image
                  }
                  Navigator.of(context).pop(); // Fermer le dialogue
                },
              ),
              ListTile(
                leading: Icon(Icons.camera),
                title: Text("Prendre une photo"),
                onTap: () async {
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.camera);
                  if (image != null) {
                    _updateProfileImage(File(image
                        .path)); // Appeler une méthode pour mettre à jour l'image
                  }
                  Navigator.of(context).pop(); // Fermer le dialogue
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateProfileImage(File image) {
    setState(() {
      // Mettez à jour votre variable d'image de profil ici
      // Par exemple :
      // _profileImage = image;
    });
    // Vous pouvez également ajouter la logique pour sauvegarder l'image sur un serveur si nécessaire
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            EditableProfileField(
                              icon: Icons.person,
                              label: "Prénom",
                              value: prenom,
                              onSave: (newValue) {
                                setState(() => prenom = newValue);
                              },
                            ),
                            EditableProfileField(
                              icon: Icons.person,
                              label: "Nom",
                              value: name,
                              onSave: (newValue) {
                                setState(() => name = newValue);
                              },
                            ),
                            EditableProfileField(
                              icon: Icons.cake,
                              label: "Date de naissance",
                              value: date,
                              onSave: (newValue) {
                                setState(() => date = newValue);
                              },
                            ),
                            EditableProfileField(
                              icon: Icons.phone,
                              label: "Téléphone",
                              value: telephone,
                              onSave: (newValue) {
                                setState(() => telephone = newValue);
                              },
                            ),
                            EditableProfileField(
                              icon: Icons.email,
                              label: "Email",
                              value: email,
                              onSave: (newValue) {
                                setState(() => email = newValue);
                              },
                            ),
                            EditableProfileField(
                              icon: Icons.lock,
                              label: "Mot de passe",
                              value: "********",
                              isPassword: true,
                              onTap: _showPasswordChangeDialog,
                              onSave: (String) {},
                            ),
                            EditableProfileField(
                              icon: Icons.location_on,
                              label: "Adresse",
                              value: email,
                              onSave: (newValue) {
                                setState(() => email = newValue);
                              },
                            ),
                            EditableProfileField(
                              icon: Icons.child_care,
                              label: "Nombre d'enfants",
                              value: email,
                              onSave: (newValue) {
                                setState(() => email = newValue);
                              },
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _showPasswordDialog,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor: const Color.fromARGB(
                                    255, 128, 244, 56), // Couleur rose
                              ),
                              child: const Text(
                                'Valider les changements',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.pink, // Couleur rose pour l'en-tête
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      child: Center(
        child: GestureDetector(
          onTap: _showImagePicker, // Appel de la fonction pour changer l'image
          child: Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(profileImageUrl), // Image de profil
                child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 128, 244,
                        56), // Couleur de fond de l'icône d'édition
                  ),
                  child: Icon(
                    Icons.edit, // Icône d'édition
                    color: Colors.white,
                    size: 30,
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

class EditableProfileField extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Function(String) onSave;
  final bool isPassword;
  final void Function()? onTap;

  const EditableProfileField({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onSave,
    this.isPassword = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            _showEditDialog(context);
          },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 24),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(isPassword ? "********" : value),
                  ],
                ),
              ),
              if (!isPassword) Icon(Icons.edit),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    TextEditingController controller = TextEditingController(text: value);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Modifier $label"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.of(context).pop();
              },
              child: Text("Sauvegarder"),
            ),
          ],
        );
      },
    );
  }
}
