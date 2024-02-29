class FormQuestion {
  String? questionText;
  String? questionType;

  FormQuestion({
    required this.questionText,
    required this.questionType,
  });

  factory FormQuestion.fromJson(Map<String, dynamic> json) {
    return FormQuestion(
      questionText: json['questionText'],
      questionType: json['questionType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'questionType': questionType,
    };
  }
}