import 'dart:convert';
import 'package:gallery_app/helpers/api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import '../globals/Globals.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  List<dynamic> _photos = [];

  void _handleSearch() async {
    final photos =
        await APIHelper.apiHelper.searchPhotos(_searchController.text);
    setState(() {
      _photos = photos;
    });
  }

  ScreenshotController screenshotController = ScreenshotController();

  void _captureScreenshot() async {
    // capture screenshot
    final Uint8List = await screenshotController.capture();

    // save image to gallery
    final result = await ImageGallerySaver.saveImage(Uint8List!);
    print('Image saved to gallery: $result');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Save Image in Gellary...'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool search = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery App'),
        centerTitle: true,
        elevation: 5,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: 'Search photos',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _handleSearch,
                ),
              ),
            ),
          ),
          (_searchController.text.isNotEmpty)
              ? Expanded(
                  child: GridView.builder(
                    itemCount: _photos.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final photo = _photos[index];
                      return GestureDetector(
                        onTap: () {
                          photo['links']['download'];
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [
                                  Center(
                                    child: Stack(
                                      alignment: Alignment(1.2, 1.1),
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Screenshot(
                                            controller: screenshotController,
                                            child: Image.network(
                                              photo['urls']['regular'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        FloatingActionButton(
                                          backgroundColor: Colors.grey,
                                          onPressed: () async {
                                            _captureScreenshot();
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.save_outlined,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          print(photo['links']['download']);
                        },
                        child: Image.network(
                          photo['urls']['regular'],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                )
              : Expanded(
                  child: GridView.builder(
                    itemCount: ADD.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        child: Image.network(
                          "${ADD[index]}",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
