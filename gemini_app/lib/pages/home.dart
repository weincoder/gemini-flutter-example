import 'package:flutter/material.dart';
import 'package:gemini_app/provider/generate_content_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const prompt = 'Describeme de una forma amigable que es Flutter';
  static const compararImagenPregunta =
      '¿Que diferencias vez entre estas dos imágenes? puedes darme bastante detalle';
  static const imagenPregunta = 'Puedes describirme esta imagen por favor';
  static const img1Path = './images/lior.jpeg';
  static const img2Path = './images/sushi.jpeg';
  GenerateContentProvider? generateContentProvider;
  @override
  void initState() {
    super.initState();
    generateContentProvider = GenerateContentProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gemini ✦!',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  prompt,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                FutureBuilder(
                    future:
                        generateContentProvider!.obtenerRespuestaGemini(prompt),
                    builder: (context, respuestaAsync) {
                      if (respuestaAsync.connectionState ==
                          ConnectionState.done) {
                        print(respuestaAsync.data);
                        return Text(respuestaAsync.data!);
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                Text(
                  compararImagenPregunta,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      Image(image: AssetImage(img1Path)),
                      SizedBox(
                        width: 25,
                      ),
                      Image(image: AssetImage(img2Path)),
                    ],
                  ),
                ),
                FutureBuilder(
                    future: generateContentProvider!.comparadorDeImagenes(
                        compararImagenPregunta, img1Path, img2Path),
                    builder: (context, respuestaAsync) {
                      if (respuestaAsync.connectionState ==
                          ConnectionState.done) {
                        print(respuestaAsync.data);
                        return Text(respuestaAsync.data!);
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                Text(
                  imagenPregunta,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const Image(image: AssetImage(img1Path)),
                FutureBuilder(
                    future: generateContentProvider!
                        .describirImagen(imagenPregunta, img1Path),
                    builder: (context, respuestaAsync) {
                      if (respuestaAsync.connectionState ==
                          ConnectionState.done) {
                        print(respuestaAsync.data);
                        return Text(respuestaAsync.data!);
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
