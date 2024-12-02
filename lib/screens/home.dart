import 'dart:async';
import 'package:flutter/material.dart';
import 'package:start/screens/create.dart';
import 'package:start/theme/theme.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Image list for the slider
  final List<String> _images = [
    'assets/images/aes.jpg',
    'assets/images/bohe.jpg',
    'assets/images/cont.jpg',
    'assets/images/jap.jpg',
    'assets/images/mod.jpg',
  ];

  @override
  void initState() {
    super.initState();
    // Start the auto-slide timer
    Timer.periodic(const Duration(seconds:3), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/b2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main Content
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                // Header
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0), // Adjust the value as needed
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                    'SUCASA',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                   ),
                  ),
                ),
              ),

                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 375, // Set the width of the box
                        height: 250, // Set the height of the box
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(201, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: [
                            // Image Slider
                            PageView.builder(
                              controller: _pageController,
                              itemCount: _images.length,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    _images[index],
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                            // Create Button
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => Create());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: lightColorScheme.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text('CREATE'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Other sections...
                // Recommended Section
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recommended',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('See All'),
                          ),
                        ],
                      ),
                      // Placeholder for recommended items
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.grey[300],
                              child: Center(child: Text('Item 1')),
                            ),
                          ),
                          SizedBox(width: 10, height: 10),
                          Expanded(
                            child: Container(
                              color: Colors.grey[300],
                              child: Center(child: Text('Item 2')),
                            ),
                          ),
                        ],
                      ),    
                    ],
                  ),
                ),
                 // Most Used Section
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Most Used',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('See All'),
                          ),
                        ],
                      ),
                      // Placeholder for most used items
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.grey[300],
                              child: Center(child: Text('Item 1')),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              color: Colors.grey[300],
                              child: Center(child: Text('Item 2')),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              color: Colors.grey[300],
                              child: Center(child: Text('Item 3')),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),   
              ],
            ),
          ),
          // Bottom Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/ho.png', width: 30, height: 30),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/add.png', width: 30, height: 30),
                  label: 'Create',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/pro.png', width: 30, height: 30),
                  label: 'Profile',
                ),
              ],
              selectedItemColor: lightColorScheme.primary, // Change the color of the selected label
              unselectedItemColor: lightColorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
