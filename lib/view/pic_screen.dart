import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:readmore/readmore.dart';

class PicScreen extends StatefulWidget {
  const PicScreen({super.key});

  @override
  State<PicScreen> createState() => _PicScreenState();
}

class _PicScreenState extends State<PicScreen> {
  final cookbox = Hive.box("CookBox");
  final i = Hive.box("iBox");
  int ind = -1;

  @override
  void initState() {
    if (cookbox.isNotEmpty && i.isEmpty) {
      i.add(0);
    }
    if (cookbox.isNotEmpty) {
      ind = int.parse(i.getAt(0).toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D2228),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: cookbox.isEmpty || ind < 0
          ? []
          : [
              GestureDetector(
                onTap: () {
                  if (ind != 0) {
                    setState(() {
                      ind--;
                      i.putAt(0, ind);
                    });
                  }
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * 0.05,
                        horizontal: MediaQuery.of(context).size.width * 0.18),
                    decoration: BoxDecoration(
                        color: Color(0xFFFB8122),
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      "Back",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  if (ind < cookbox.length - 1) {
                    setState(() {
                      ind++;
                      i.putAt(0, ind);
                    });
                  }
                },
                child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.width * 0.05,
                        horizontal: MediaQuery.of(context).size.width * 0.18),
                    decoration: BoxDecoration(
                        color: Color(0xFFFB8122),
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      "Next",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
              )
            ],
      body: cookbox.isEmpty || ind < 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.08,
                        left: 8),
                    decoration: const BoxDecoration(
                        color: Color(0xFFFB8122), shape: BoxShape.circle),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No data found",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ],
                ),
              ],
            )
          : Stack(
              children: [
                CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    expandedHeight: 470.0,
                    floating: false,
                    pinned: true,
                    leading: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Color(0xFF12122A), shape: BoxShape.circle),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    actions: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            ind = 0;
                            i.putAt(0, ind);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Color(0xFF12122A), shape: BoxShape.circle),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.restore,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      background: ClipRRect(
                        child: Image.file(
                            File(cookbox.getAt(
                                int.parse(i.getAt(0).toString()))["img"]),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          cookbox.getAt(int.parse(
                                              i.getAt(0).toString()))["name"],
                                          style: const TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (ind == 0) {
                                                cookbox.clear();
                                                ind--;
                                                i.clear();
                                              } else {
                                                cookbox.deleteAt(ind);
                                                ind--;
                                                i.putAt(0, ind);
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Color(0xFFFB8122),
                                            size: 24,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  ReadMoreText(
                                    cookbox.getAt(int.parse(
                                        i.getAt(0).toString()))["desc"],
                                    trimLines: 3,
                                    style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white70),
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: ' Show less',
                                    moreStyle: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF31C002),
                                    ),
                                    lessStyle: const TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFF00001),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                            ),
                        childCount: 1),
                  )
                ]),
              ],
            ),
    );
  }
}
