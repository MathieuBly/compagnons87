import 'package:flutter/material.dart';

import '../conf/false_dialog.dart';
import '../conf/question.dart';
import '../conf/select_answer_dialog.dart';
import 'image_question_widget.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final Function(dynamic) onAnswerSelected;
  final VoidCallback onNextPressed;
  final bool isAnswerChecked;

  const QuestionWidget({
    required this.question,
    required this.onAnswerSelected,
    required this.onNextPressed,
    required this.isAnswerChecked,
    Key? key,
  }) : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  List<String> selectedAnswers = [];
  String selectedImageAnswerPath = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.all(0),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF327E89),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.question.text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  _buildQuestionTypeWidget(),
                  ElevatedButton(
                    onPressed: _onNextPressed,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFEE7203),
                    ),
                    child: const Text('Next'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionTypeWidget() {
    switch (widget.question.type) {
      case 'multipleChoice':
        return _buildMultipleChoiceWidget();
      case 'image':
        return _buildImageWidget();
      case 'text':
        return Container();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildImageWidget() {
    return ImageQuestionWidget(
      question: widget.question,
      onAnswerSelected: (value) {
        setState(() {
          selectedAnswers = value as List<String>;
          print('selectedAnswers: $selectedAnswers');
          // List<String>? correctImageAnswers =
          //     widget.question.correctImageAnswers;

          selectedAnswers.sort();
          // correctImageAnswers?.sort();

          // bool isCorrect = listEquals(selectedAnswers, correctImageAnswers);
          // print('isCorrect: $isCorrect');
        });
        widget.onAnswerSelected(selectedAnswers);
      },
    );
  }

  Widget _buildMultipleChoiceWidget() {
    return Column(
      children: widget.question.choiceAnswers!.map((choiceAnswer) {
        return CheckboxListTile(
          activeColor: const Color(0xFFEE7203),
          checkColor: Color.fromARGB(255, 255, 255, 255),
          title: Text(
            choiceAnswer,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          value: selectedAnswers.contains(choiceAnswer),
          onChanged: (value) {
            setState(() {
              if (value != null) {
                if (value) {
                  selectedAnswers.add(choiceAnswer);
                } else {
                  selectedAnswers.remove(choiceAnswer);
                }
                selectedAnswers.sort();
                widget.onAnswerSelected(selectedAnswers);
              }
            });
          },
        );
      }).toList(),
    );
  }

  void _onNextPressed() {
    if (widget.isAnswerChecked ||
        !widget.question.requiresAnswer ||
        (widget.question.type == 'text')) {
      selectedAnswers = [];
      print('tochenext');
      widget.onNextPressed();
    } else {
      if (selectedAnswers.isEmpty && selectedImageAnswerPath.isEmpty) {
        showNoAnswerPopup(context);
      } else {
        showWrongAnswerPopup(context);
        print('tocheelse');
      }
    }
  }
}
