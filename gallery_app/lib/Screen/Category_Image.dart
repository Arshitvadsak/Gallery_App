import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import '../globals/Globals.dart';

class Category_Images extends StatefulWidget {
  const Category_Images({Key? key}) : super(key: key);

  @override
  State<Category_Images> createState() => _HomePageState();
}

class _HomePageState extends State<Category_Images> {
  final List<String> image = [
    'Nature',
    'Cars',
    'Dogs',
    'flowers',
    'Cats',
    'buildings',
  ];
  int _currentIndex = 0;
  int currentPage = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Gallary App",
        ),
        elevation: 5,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChipList(
                  listOfChipNames: image,
                  activeBgColorList: [Colors.greenAccent],
                  inactiveBgColorList: [Colors.cyan],
                  activeTextColorList: [Colors.black87],
                  inactiveTextColorList: [Colors.black],
                  activeBorderColorList: [Colors.black],
                  listOfChipIndicesCurrentlySeclected: [_currentIndex],
                  extraOnToggle: (val) {
                    _currentIndex = val;
                    setState(() {
                      Images = allList[val];
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              initialPage: currentPage,
              onPageChanged: (val, _) {
                setState(() {
                  currentPage = val;
                });
                print(currentPage);
              },
              scrollDirection: Axis.horizontal,
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.easeInOutBack,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.7,
            ),
            items: Images.map(
              (e) => Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage("${e['image']}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ).toList(),
          ),
          SizedBox(height: 10),
          Container(
            height: 20,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: Images.map((e) {
                int i = Images.indexOf(e);
                return GestureDetector(
                  onTap: () {
                    carouselController.animateToPage(
                      i,
                      duration: Duration(milliseconds: 800),
                    );
                  },
                  child: CircleAvatar(
                      radius: 5,
                      backgroundColor: (currentPage == i)
                          ? Colors.black87
                          : Colors.white60),
                );
              }).toList(),
            ),
          ),
          Text(
            "All Images",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Container(
            height: 400,
            child: GridView.builder(
                padding: EdgeInsets.only(top: 10.0),
                itemCount: All.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemBuilder: (context, index) {
                  return Image.network(
                    All[index],
                    fit: BoxFit.cover,
                  );
                }),
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
