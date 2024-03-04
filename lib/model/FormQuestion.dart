import 'MultipleChoiceOption.dart';

class FormQuestion {
  String? questionText;
  String? questionType;
  List<MultipleChoiceOption?> multipleChoiceOptions;
  int? ratingScale;

  FormQuestion({
    required this.questionText,
    required this.questionType,
    required this.multipleChoiceOptions,
    required this.ratingScale,
  });

  factory FormQuestion.fromJson(Map<String, dynamic> json) {
    List<dynamic> optionsJson = json['multipleChoiceOptions'] ?? [];
    List<MultipleChoiceOption?> options = optionsJson
        .map((option) =>
    option != null ? MultipleChoiceOption.fromJson(option) : null)
        .toList();

    return FormQuestion(
      questionText: json['questionText'],
      questionType: json['questionType'],
      multipleChoiceOptions: options,
      ratingScale: json['ratingScale'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> optionsJson =
    multipleChoiceOptions.map((option) => option?.toJson() ?? {}).toList();

    return {
      'questionText': questionText,
      'questionType': questionType,
      'multipleChoiceOptions': optionsJson,
      'ratingScale': ratingScale,
    };
  }
}