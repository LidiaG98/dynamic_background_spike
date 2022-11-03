import 'package:flutter/material.dart';
import 'package:image_pixels/image_pixels.dart';
import 'package:palette_generator/palette_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Palette Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> images = [
    'https://upload.wikimedia.org/wikipedia/commons/9/91/Visually_Logo.png',
    'https://png.pngtree.com/png-vector/20220727/ourmid/pngtree-cooking-logo-png-image_6089722.png',
    'https://www.pngmart.com/files/10/Apple-Logo-PNG-Clipart.png',
    'https://www.freepnglogos.com/uploads/mini-cooper-car-logo-brands-png-images-26.png',
    'https://firebasestorage.googleapis.com/v0/b/semy-staging.appspot.com/o/vendor-image%2FXFwIlRLTmIcBdnBF9eVD6OIwwyk2%2F1605126750640.steins_cupertino.jpeg?alt=media&token=90fa7052-9d2d-499f-a206-91d523e2df54',
    'https://storage.googleapis.com/semy-development-static/vendors/full%20shilling.png',
    'https://d2s742iet3d3t1.cloudfront.net/restaurants/restaurant-29121000000000000/restaurant_list_image_1584556688.png',
    "https://firebasestorage.googleapis.com/v0/b/semy-staging.appspot.com/o/vendor-image%2FN9KrkHMk1HTHCJNIacV6BiZki532%2F1620938936638.Icepick%20Willy's.jpeg?alt=media&token=d17fa20e-2b90-4f4b-a1d0-019b936384ec",
  ];
  late List<PaletteColor> dycolors;
  late int _index;

  @override
  void initState() {
    super.initState();
    dycolors = [];
    _index = 0;
    addColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Background Color Spike'),
        elevation: 0,
        backgroundColor: dycolors.isEmpty
            ? Theme.of(context).primaryColor
            : dycolors[_index].color,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            color: dycolors.isEmpty ? Colors.white : dycolors[_index].color,
            child: PageView(
              onPageChanged: (int index) {
                setState(() {
                  _index = index;
                });
              },
              children: images
                  .map((image) => Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  image: DecorationImage(
                      image: Image.network(image).image, fit: BoxFit.cover),
                ),
              ))
                  .toList(),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: dycolors.isEmpty ? Colors.white : dycolors[_index].color,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "With palette generator",
                  style: TextStyle(
                      color: dycolors.isEmpty
                          ? Colors.black
                          : dycolors[_index].titleTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                    "Lorem ipsum dolor sit amet consectetur adipisicing elit. ",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: dycolors.isEmpty
                        ? Colors.black
                        : dycolors[_index].bodyTextColor, fontSize: 22.0))
              ],
            ),
          ),
          ImagePixels(
            imageProvider: getImage(),
            defaultColor: Colors.blue,
            builder: (context, img) {
              return Container(
                color: img.pixelColorAtAlignment!(Alignment.center)?? Colors.blue,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: img.pixelColorAtAlignment!(Alignment.center)?? Colors.blue,
                        image: DecorationImage(
                            image: getImage(), fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(32.0),
                      width: double.infinity,
                      color: img.pixelColorAtAlignment!(Alignment.center)?? Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            "With Image Pixels",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0),
                          ),
                          Text(
                              "Lorem ipsum dolor sit amet consectetur adipisicing elit. ",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 22.0))
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  void addColor() async {
    for (String image in images) {
      final PaletteGenerator pg = await PaletteGenerator.fromImageProvider(
        Image.network(image).image,
      );
      dycolors.add(pg.dominantColor?? PaletteColor(Colors.white, 2));
      setState(() {

      });
    }
  }

  ImageProvider getImage() {
    return Image.network(images[_index]).image;
  }
}
