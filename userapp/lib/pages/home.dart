import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> buttonColors = [
      const Color.fromARGB(255, 168, 194, 214),
      const Color.fromARGB(255, 175, 243, 177),
      const Color.fromARGB(255, 255, 228, 188),
      const Color.fromARGB(255, 245, 195, 253),
      const Color.fromARGB(255, 228, 141, 135),
      Colors.teal,
    ];

    final List<String> buttonLabels = [
      'Road Violations',
      'Sanitation',
      'Infrasructure',
      'Public Order',
      'Electricity and Powers',
      'Gov body issues',
    ];

    return Scaffold(
      appBar: banner(),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 300, left: 30),
            height: 50,
            width: 180,
            child: Text(
              'Select Services',
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 2,
                children: List.generate(6, (index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColors[index],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      minimumSize: Size(double.infinity, 40),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      // Add your onPressed action here
                    },
                    child: Text(
                      buttonLabels[index],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar banner() {
    return AppBar(
      title: const Text(
        'Home',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      leading: Container(
        alignment: Alignment.center,
        height: 20,
        width: 20,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 248, 246, 246),
        ),
        child: SvgPicture.asset(
          'assets/icons/threedotshorizontal.svg',
          height: 25,
          width: 25,
        ),
      ),
      actions: [
        Container(
          alignment: Alignment.center,
          width: 40,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 248, 246, 246),
          ),
          child: SvgPicture.asset(
            'assets/icons/profile.svg',
            height: 25,
            width: 25,
          ),
        ),
      ],
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
    );
  }
}
