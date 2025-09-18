import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
           'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
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
          child: SvgPicture.asset('assets/icons/threedotshorizontal.svg',
          height:25 ,
          width: 25,),
          
      ),
      actions: [Container(
          alignment: Alignment.center,
          height: 40,
          width: 40,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 248, 246, 246),
            
          ),
          child: SvgPicture.asset('assets/icons/profile.svg',
          height: 25,
          width: 25,),
          
      ),],
        /*leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),*/
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
    );
  }
}
