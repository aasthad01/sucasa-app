import 'package:flutter/material.dart';
import 'package:start/screens/home.dart';
import '../theme/theme.dart';

class PickYourTaste extends StatefulWidget {
  const PickYourTaste({Key? key}) : super(key: key);

  @override
  _PickYourTasteState createState() => _PickYourTasteState();
}

class _PickYourTasteState extends State<PickYourTaste> {
  List<String> options = [
    'Aesthetic',
    'Bohemian',
    'Chill',
    'Coastal',
    'Colour-based',
    'Contemporary',
    'Cozy',
    'Ethnic/Desi',
    'French Country',
    'Japanese design',
    'Minimalist',
    'Modern',
    'Royal',
    'Rustic/Earthy',
    'Vintage',
  ];

  List<String> images = [
    'assets/images/aes.jpg',
    'assets/images/bohe.jpg',
    'assets/images/chill.jpg',
    'assets/images/coas.jpg',
    'assets/images/color.jpg',
    'assets/images/cont.jpg',
    'assets/images/cozy.jpg',
    'assets/images/eth.jpg',
    'assets/images/fre.jpg',
    'assets/images/jap.jpg',
    'assets/images/mini.jpg',
    'assets/images/mod.jpg',
    'assets/images/royal.jpg',
    'assets/images/rust.jpg',
    'assets/images/vint.jpg',
  ];

  List<bool> isSelected = List.generate(15, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 54),
            const Text(
              'Pick your Taste',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 251, 246, 251),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected[index] = !isSelected[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected[index]
                            ? const Color.fromARGB(255, 197, 222, 214)
                            : const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(isSelected[index] ? 0.5 : 0.3),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          options[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                List<String> selectedOptions = [];
                for (int i = 0; i < options.length; i++) {
                  if (isSelected[i]) {
                    selectedOptions.add(options[i]);
                  }
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Home(), // Replace with your next page
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'SUBMIT',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
