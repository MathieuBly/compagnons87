class Question {
  final String text;
  final List<String>? choiceAnswers; // Liste des réponses
  final List<String>? correctAnswers; // Liste des bonnes réponses
  final String type;
  final bool requiresAnswer;
  final List<String>? correctImageAnswers;

  Question({
    required this.text,
    this.choiceAnswers,
    this.correctAnswers,
    required this.type,
    this.requiresAnswer = true,
    this.correctImageAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] ?? '',
      choiceAnswers: List<String>.from(json['choiceAnswers'] ?? []),
      correctAnswers: List<String>.from(json['correctAnswers'] ?? []),
      correctImageAnswers: List<String>.from(json['correctImageAnswers'] ?? []),
      type: json['type'] ?? '',
      requiresAnswer: json['requiresAnswer'] ?? true,
    );
  }
}
