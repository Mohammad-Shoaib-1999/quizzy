import 'dart:convert';

QuizModel quizModelFromJson(String str) => QuizModel.fromJson(json.decode(str));

String quizModelToJson(QuizModel data) => json.encode(data.toJson());

class QuizModel {
  List<QuizData> data;

  QuizModel({required this.data});

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
        data: List<QuizData>.from(json["data"].map((x) => QuizData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class QuizData {
  String id;
  String title;
  String imagePath;
  List<Question> questions;

  QuizData({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.questions,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) => QuizData(
        id: json["id"],
        title: json["title"],
        imagePath: json["image_path"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image_path": imagePath,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  String questionId;
  String questionText;
  List<Option> options;
  String correctOptionId;

  Question({
    required this.questionId,
    required this.questionText,
    required this.options,
    required this.correctOptionId,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        questionId: json["question_id"],
        questionText: json["question_text"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        correctOptionId: json["correct_option_id"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "question_text": questionText,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "correct_option_id": correctOptionId,
      };
}

class Option {
  String optionId;
  String optionText;

  Option({
    required this.optionId,
    required this.optionText,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        optionId: json["option_id"],
        optionText: json["option_text"],
      );

  Map<String, dynamic> toJson() => {
        "option_id": optionId,
        "option_text": optionText,
      };
}