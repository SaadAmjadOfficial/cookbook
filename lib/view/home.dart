import 'package:cookbook/view/add_recipe.dart';
import 'package:cookbook/view/pic_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D2228),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.15),
            child: Image.asset(
              "assets/images/logo.png",
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => AddImage(),
                      ));
                },
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.05),
                      decoration: BoxDecoration(
                          color: Color(0xFFFB8122),
                          borderRadius: BorderRadius.circular(16)),
                      child: Icon(
                        Icons.add_box_rounded,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.2,
                      ),
                    ),
                    Text(
                      "Add Recipe",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFFE1E2E2)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => PicScreen(),
                      ));
                },
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.05),
                      decoration: BoxDecoration(
                          color: Color(0xFFFB8122),
                          borderRadius: BorderRadius.circular(16)),
                      child: Icon(
                        Icons.dining,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.2,
                      ),
                    ),
                    Text(
                      "Explore Recipe",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFFE1E2E2)),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
