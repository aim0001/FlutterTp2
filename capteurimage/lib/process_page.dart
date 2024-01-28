import 'dart:io';

import 'package:flutter/material.dart';

class ProcessPage extends StatelessWidget {
  final File image;
  final String extractedText;

  ProcessPage({required this.image, required this.extractedText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Traitement d\'image'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/beton.jpg'), // Remplacez 'assets/background_image.jpg' par le chemin de votre image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5), // Couleur de fond blanc transparent
                      borderRadius: BorderRadius.circular(10), // Coins arrondis
                    ),
                    child: Image.file(
                      image,
                      width: MediaQuery.of(context).size.width * 0.6, // Redimensionner l'image
                      height: MediaQuery.of(context).size.height * 0.6, // Redimensionner l'image
                      fit: BoxFit.contain, // Ajuster l'image à l'espace disponible
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(150, 10, 20, 100), // Ajuster les marges autour du texte
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5), // Couleur de fond blanc transparent
                      borderRadius: BorderRadius.circular(10), // Coins arrondis
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        extractedText,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16, // Taille de police différente
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
