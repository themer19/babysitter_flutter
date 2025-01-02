import 'package:app/barrenav/chekproduit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Accu extends StatelessWidget {
  Future<List<Nounou>> fetchNounous() async {
    final response =
        await http.get(Uri.parse('http://localhost:8088/auth/getall'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print('Données reçues : $data');
      return data.map((course) => Nounou.fromJson(course)).toList();
    } else {
      throw Exception('Failed to load nounou');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/back.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<Nounou>>(
                    future: fetchNounous(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No courses found'));
                      } else {
                        return SingleChildScrollView(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SectionHeader(title: "Nounou"),
                                CourseList(courses: snapshot.data!),
                                SectionHeader(title: "Trousseau bébé"),
                                CourseList(courses: snapshot.data!),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "See all",
            style: TextStyle(color: Colors.blue, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class CourseList extends StatelessWidget {
  final List<Nounou> courses;
  CourseList({required this.courses});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CourseCard(course: courses[index]),
          );
        },
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Nounou course;

  CourseCard({required this.course});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "images/mother.png", // Remplacez par le chemin de votre image
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${course.nom} ${course.prenom}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Texte du téléphone
                Text(
                  '${course.telephone}',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                // Icône pour aller à la page de détails
                IconButton(
                  icon: Icon(Icons.visibility, color: Colors.blue, size: 20),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Nounou {
  final int idbabysitter;
  final String nom;
  final String prenom;
  final int telephone;

  Nounou(
      {required this.idbabysitter,
      required this.nom,
      required this.prenom,
      required this.telephone});

  factory Nounou.fromJson(Map<String, dynamic> json) {
    return Nounou(
        idbabysitter: json['idbabysitter'],
        nom: json['nom'],
        prenom: json['prenom'],
        telephone: json['telephone']);
  }
}
