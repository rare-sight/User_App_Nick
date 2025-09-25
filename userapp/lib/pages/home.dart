import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:userapp/pages/issues.dart';
import 'package:userapp/pages/report.dart'; // central page

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    IssuesPage(),
    Center(child: Text("test")),
    Center(child: Text("Contact Page")),
  ];

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
      'Road & Transport',
      'Sanitation',
      'Infrastructure',
      'Public Order',
      'Electricity and Power',
      'Gov Body Issues',
    ];

    // Each service has its own categories
    final List<List<String>> categories = [
      ['Potholes', 'Wrong Parking', 'Clogged Road'],
      ['Garbage', 'Sewage Leak', 'Overflowing Bins'],
      ['Broken Buildings', 'Unsafe Structures'],
      ['Illegal Encroachments', 'Noise Complaints'],
      ['Power Cut', 'Street Lights Not Working'],
      ['Corruption', 'Inefficient Service'],
    ];

    return Scaffold(
      appBar: banner(),
      backgroundColor: Colors.white,
      body: _currentIndex == 1
          ? Column(
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            elevation: 4,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReportPage(
                                  serviceTitle: buttonLabels[index],
                                  categories: categories[index],
                                ),
                              ),
                            );
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
            )
          : _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 52, 85, 113),
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: "Issues"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add_ic_call), label: "Contact"),
        ],
      ),
    );
  }

  AppBar banner() {
    return AppBar(
      title: const Text(
        'Prototype',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      leading: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(255, 248, 246, 246),
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
            color: Color.fromARGB(255, 248, 246, 246),
          ),
          child: SvgPicture.asset(
            'assets/icons/profile.svg',
            height: 25,
            width: 25,
          ),
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
