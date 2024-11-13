import 'package:app/departinterface/home.dart';
import 'package:app/departinterface/text.dart';
import 'package:flutter/material.dart';

class Premier extends StatefulWidget {
  @override
  _Premier createState() => _Premier();
}

class _Premier extends State<Premier> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length, // Utilisation de contents.length
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        contents[i]
                            .image, // Assurez-vous que contents[i].image existe
                        width: 300, // Largeur de l'image
                        height: 250, // Hauteur de l'image
                        fit: BoxFit.cover, // Ajustement de l'image
                      ),
                      SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(254, 131, 131, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // Titre aligné en haut de la section colorée
                                Text(
                                  contents[i]
                                      .title, // Assurez-vous que contents[i].title existe
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 5),
                                // Texte de description dans la section colorée
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      contents[i]
                                          .discription, // Assurez-vous que contents[i].discription existe
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                // Indicateur de page
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    contents.length,
                                    (index) => buildDot(index, context),
                                  ),
                                ),
                                // Bouton "Next" ou "Continue"
                                Container(
                                  height: 60,
                                  margin: EdgeInsets.all(40),
                                  width: double.infinity,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (currentIndex == contents.length - 1) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                Home(), // Page suivante
                                          ),
                                        );
                                      } else {
                                        _controller.nextPage(
                                          duration: Duration(milliseconds: 100),
                                          curve: Curves.easeIn,
                                        );
                                      }
                                    },
                                    child: Text(
                                      currentIndex == contents.length - 1
                                          ? "Continue"
                                          : "Next",
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Fonction pour construire les indicateurs de page
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Colors.black : Colors.white,
      ),
    );
  }
}
