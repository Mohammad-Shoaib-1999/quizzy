import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizzy/models/quiz_model.dart';
import 'package:quizzy/screens/quiz_screen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  List<QuizData> myData = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text("Quizzy App",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("Let's play",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 8.0, // Spacing between columns
                        mainAxisSpacing: 8.0, // Spacing between rows
                        childAspectRatio: 1, // Aspect ratio of each item
                      ),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => QuizScreen(
                                    questionsList: myData[index].questions))),
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blueGrey.shade100,
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: const Offset(3, 3))
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  myData[index].imagePath,
                                  height: 80,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      myData[index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "${myData[index].questions.length} questions",
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                      itemCount: myData.length, // Total number of items
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ));
  }

  getData() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/quiz_data.json");
    final Map<String, dynamic> jsonResult = jsonDecode(data);
    log(jsonResult.entries.toString());
    QuizModel quizModel = QuizModel.fromJson(jsonResult);
    setState(() {
      myData = quizModel.data;
    });
  }
}