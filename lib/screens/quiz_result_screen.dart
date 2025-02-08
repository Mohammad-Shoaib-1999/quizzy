import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class QuizResultScreen extends StatefulWidget {
  const QuizResultScreen({super.key});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  Container resultText(double topMargin, String title, double fontsize,
      FontWeight fontweight, Color color) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(
        title,
        style:
            TextStyle(fontSize: fontsize, fontWeight: fontweight, color: color),
      ),
    );
  }

  InkWell resultSelectionBtn(String title, Function myfun) {
    return InkWell(
      onTap: () {
        myfun();
      },
      child: DottedBorder(
        color: Colors.black,
        dashPattern: [8, 4],
        strokeWidth: 2,
        child: Container(
            height: 50,
            width: 170,
            decoration: const BoxDecoration(color: Colors.blueAccent),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Quiz Result",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/congratulation.png')),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 90),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.grey.shade400,
                        child: const CircleAvatar(
                          radius: 46,
                          backgroundColor: Colors.transparent,
                          child: Icon(
                            Icons.person,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    resultText(5, "Hemant Prajapati", 18, FontWeight.w600,
                        Colors.grey.shade600),
                    resultText(10, "Congratulations", 28, FontWeight.w300,
                        Colors.black.withOpacity(.8)),
                    resultText(5, "Your Score :", 18, FontWeight.w300,
                        Colors.grey.shade600),
                    Image.asset(
                      'assets/images/badge_.png',
                      width: 80,
                    ),
                    resultText(
                        30, "5/10", 30, FontWeight.w600, Colors.grey.shade600),
                    Container(
                      width: size.width * .7,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blueAccent),
                        gradient: const LinearGradient(
                          colors: [Colors.blueAccent, Colors.lightBlueAccent],
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: LinearProgressIndicator(
                          value: 5 / 15,
                          backgroundColor: Colors.white.withOpacity(0.3),
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                    resultText(
                        30, "1 sec", 30, FontWeight.w600, Colors.grey.shade600),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            resultSelectionBtn("Close", () {}),
                            resultSelectionBtn("Share", () {})
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}