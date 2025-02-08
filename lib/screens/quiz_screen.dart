import 'package:flutter/material.dart';
import 'package:quizzy/models/quiz_model.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questionsList;
  const QuizScreen({super.key, required this.questionsList});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final PageController _pageController = PageController();
  int currentQuestionIndex = 0;
  Map<String, String> selectedOptions = {};
  bool optionSelected = false;
  bool isCorrect = false;

  void _selectOption(Question question, String optionId) {
    setState(() {
      selectedOptions[question.questionId] = optionId;
      optionSelected = true;
      isCorrect = question.correctOptionId == optionId;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
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
                        value: (currentQuestionIndex + 1) /
                            widget.questionsList.length,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                  Text(
                    "${currentQuestionIndex + 1}/${widget.questionsList.length}",
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
              SizedBox(height: size.height * .1),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.questionsList.length,
                  itemBuilder: (context, index) {
                    final question = widget.questionsList[index];
                    return Column(
                      children: [
                        Container(
                          height: size.height * .2,
                          width: size.width * .9,
                          padding: const EdgeInsets.all(12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            question.questionText,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Column(
                          children: question.options.map((option) {
                            bool isSelected =
                                selectedOptions[question.questionId] ==
                                    option.optionId;
                            bool isCorrectOption =
                                question.correctOptionId == option.optionId;
                            return GestureDetector(
                              onTap: () {
                                _selectOption(question, option.optionId);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                width: size.width * .9,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? isCorrectOption
                                          ? Colors.green.withOpacity(.5)
                                          : Colors.red.withOpacity(.5)
                                      : Colors.blueAccent.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? isCorrectOption
                                            ? Colors.green
                                            : Colors.red
                                        : Colors.blueAccent.withOpacity(.4),
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      option.optionText,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        isCorrectOption
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        color: isCorrectOption
                                            ? Colors.green
                                            : Colors.red,
                                      )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  },
                ),
              ),
              if (optionSelected)
                InkWell(
                  onTap: () {
                    if (currentQuestionIndex <
                        widget.questionsList.length - 1) {
                      setState(() {
                        currentQuestionIndex++;
                        optionSelected = false;
                      });
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Handle the quiz submission here
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    width: size.width * .9,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      currentQuestionIndex < widget.questionsList.length - 1
                          ? "Next"
                          : "Submit",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}