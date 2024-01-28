import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:capteurimage/process_page.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:translator/translator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = "";
  File? image;
  late ImagePicker imagePicker;
  late TextRecognizer textRecognizer;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    textRecognizer = GoogleMlKit.vision.textRecognizer();
  }

  Future<void> Gallery() async {
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      image = File(xFile.path);

      setState(() {
        image;
        // Faire l'étiquetage des images_ extraire l'image de l'image
        ExtractionTexteImage();
      });
    }
  }

  Future<void> CaptureCamera() async {
    XFile? xFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (xFile != null) {
      image = File(xFile.path);

      setState(() {
        image;
        // Faire l'étiquetage des images_ extraire l'image de l'image
        ExtractionTexteImage();
      });
    }
  }

  Future<void> ExtractionTexteImage() async {
    try {
      final inputImage = InputImage.fromFilePath(image!.path);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);

      result = recognizedText.text;

      // Détecter la langue du système
      String systemLocale = Platform.localeName.split('_').first;

      // Traduire le texte extrait dans la langue du système
      final translator = GoogleTranslator();
      var translation = await translator.translate(result, to: systemLocale);

      setState(() {
        result = translation.text!;
      });

      navigateToProcessPage(context, image!, result);
    } catch (e) {
      print("Erreur lors de la reconnaissance de texte : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application de traitement d\'image'),
      ),
      body: Stack(
        children: [
          // Fond d'image
          Image.asset(
            'assets/fleur.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Modèle dans le coin supérieur gauche
          Positioned(
            left: 0,
            top: 0,
            child: CustomPaint(
              size: Size(80, 80),
              painter: PatternPainter(Color.fromARGB(255, 255, 216, 230)!, PatternType.TopLeft),
            ),
          ),
          // Modèle dans le coin bas droit
          Positioned(
            right: 0,
            bottom: 0,
            child: CustomPaint(
              size: Size(80, 80),
              painter: PatternPainter(Color.fromARGB(255, 255, 216, 230)!, PatternType.BottomRight),
            ),
          ),
          // Contenu de la page
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choisissez un onglet',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: Gallery,
                      icon: Icon(Icons.photo_library, size: 40, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: CaptureCamera,
                      icon: Icon(Icons.camera_alt, size: 40, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToProcessPage(
      BuildContext context, File image, String extractedText) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProcessPage(image: image, extractedText: extractedText),
      ),
    );
  }
}

enum PatternType {
  TopLeft,
  BottomRight,
}

class PatternPainter extends CustomPainter {
  final Color color;
  final PatternType type;

  PatternPainter(this.color, this.type);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path();
    if (type == PatternType.TopLeft) {
      path.lineTo(0, size.height);
      path.lineTo(size.width, 0);
    } else {
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
