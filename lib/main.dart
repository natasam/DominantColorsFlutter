import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dominant_colors/dominant_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final List<String> photos = [
  photo1,
  photo2,
  photo3,
  photo4,
];
const String photo1 =
    'https://images.unsplash.com/photo-1686485188236-1d79ee4d398c';
const String photo2 =
    'https://plus.unsplash.com/premium_photo-1682470021166-48f7f8fbe416';
const String photo3 =
    'https://images.unsplash.com/photo-1672970904096-b046c51c7b43';
const String photo4 =
    'https://images.unsplash.com/photo-1696254980973-cf20718989ce';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageWidget(),
    );
  }
}

class ImageWidget extends StatefulWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

String photo = photo1;

class _ImageWidgetState extends State<ImageWidget> {
  List<Color> colors = [];
  var colorsCountToExtract = 10;
  late Random random;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    random = Random();
    extractColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: UniqueKey(),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
              onPressed: () {
                extractColors();
              },
              icon: const Icon(Icons.refresh))
        ],
        title: const Text(
          'Dominant colors',
          style: TextStyle(color: Colors.black54, letterSpacing: 1),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: colors.isEmpty
                ? null
                : LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0.1, 0.7, 1],
                    colors: [
                      colors.first.withOpacity(0.4),
                      colors[colors.length ~/ 2],
                      colors.last.withOpacity(0.7),
                    ],
                  )),
        child: ListView(
          children: [
            SizedBox(
              height: 300,
              child: imageBytes != null && imageBytes!.isNotEmpty
                  ? Image.memory(
                      imageBytes!,
                      fit: BoxFit.fill,
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
            Container(
              color: Colors.white.withOpacity(0.3),
              padding: const EdgeInsets.only(top: 6, bottom: 16),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text('Dominant $colorsCountToExtract colors:'),
                  _getDominantColors()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Uint8List> fetchImage(String photoUrl) async {
    var httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(photoUrl));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    return bytes;
  }

  Future<void> extractColors() async {
    setState(() {});

    photo = photos[random.nextInt(photos.length)];
    imageBytes = await fetchImage(photo);
    setState(() {});
    try {

//DominantColors dominantColors = DominantColorsBuilder()
     // .setBytes(imageBytes!)
     // .setDominantColorsCount(3)
     // .build();


      DominantColors extractor =
          DominantColors(bytes: imageBytes!, dominantColorsCount: colorsCountToExtract);

      List<Color> dominantColors = extractor.extractDominantColors();
      setState(() {});
      colors = dominantColors;
    } catch (e) {
      colors.clear();
    }
    setState(() {});
  }

  Widget _getDominantColors() {
    return SizedBox(
      height: 60,
      child: colors.isEmpty
          ? Container(
              alignment: Alignment.center,
              height: 60,
              child: const CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: colors.length,
              itemBuilder: (BuildContext context, int index) => Container(
                color: colors[index],
                height: 30,
                width: 30,
              ),
            ),
    );
  }
}
