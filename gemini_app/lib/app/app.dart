import 'package:flutter/material.dart';
import 'package:gemini_app/pages/home.dart';
import 'package:gemini_app/provider/generate_content_provider.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiApp extends StatelessWidget {
  const GeminiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GenerateContentProvider(
      model: configurarModelo(),
      modelProvision: configurarModeloVision(),
      child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage()),
    );
  }
}

GenerativeModel configurarModelo() {
  const apiKey = 'tu-clave-acceso';
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  return model;
}
GenerativeModel configurarModeloVision() {
  const apiKey = 'tu-clave-acceso';
  final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);
  return model;
}
