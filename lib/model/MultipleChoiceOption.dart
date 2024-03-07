class MultipleChoiceOption {
  String? optionText;

  MultipleChoiceOption({required this.optionText});

  factory MultipleChoiceOption.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceOption(optionText: json['optionText']);
  }

  Map<String, dynamic> toJson() {
    return {'optionText': optionText};
  }


}
