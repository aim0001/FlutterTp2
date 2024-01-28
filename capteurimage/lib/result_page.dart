// result_page.dart

import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String extractedText;

  ResultPage({required this.extractedText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Extraction Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Extracted Text:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              extractedText.isEmpty ? 'No text extracted.' : extractedText,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
