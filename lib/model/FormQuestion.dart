class FormQuestion {
  String? questionText;
  String? questionType;
  List<String?> multipleChoiceOptions;
  int? ratingScale;


  FormQuestion({
    required this.questionText,
    required this.questionType,
    required this.multipleChoiceOptions,
    required this.ratingScale,
  });

  factory FormQuestion.fromJson(Map<String, dynamic> json) {
    return FormQuestion(
      questionText: json['questionText'],
      questionType: json['questionType'],
      multipleChoiceOptions: json['multipleChoiceOptions'],
      ratingScale: json['ratingScale']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'questionType': questionType,
      'multipleChoiceOptions': multipleChoiceOptions,
      'ratingScale': ratingScale

    };
  }
}