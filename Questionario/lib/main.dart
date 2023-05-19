import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class Question {
  String title;
  List<String> options;
  int answerIndex;
  int selectedOption;

  Question({required this.title, required this.options, required this.answerIndex})
      : selectedOption = -1;
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Question> questions = [
    Question(
      title: 'Qual o melhor filme da franquia Carros?',
      options: ['Carros', 'Carros 2 ', 'Carros 3'],
      answerIndex: 0,
    ),
    Question(
      title: 'Qual o nome do patrocinador do Relampago McQueen?',
      options: ['Dinoco', 'Rustezy', 'htB'],
      answerIndex: 1,
    ),

    Question(
      title: 'Quantas copas pistão tem Relampago McQueen?',
      options: ['10', '5', '7'],
      answerIndex: 2,
    ),

    Question(
      title: 'Qual o nome da rota que da acesso a Radiator Springs?',
      options: ['76', '86', '66'],
      answerIndex: 2,
    ),

    Question(
      title: 'Porque Doc Hudson parou de correr?',
      options: ['Sofreu acidente', 'Se aposentou ', 'Foi Substituido'],
      answerIndex: 2,
    ),
    
  ];

  List<int?> selectedAnswers = [];

  bool isQuizSubmitted = false;

  void submitQuiz() {
    setState(() {
      isQuizSubmitted = true;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedAnswers = List<int?>.filled(questions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz App'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final question = questions[index];
                    final isAnsweredCorrectly = isQuizSubmitted &&
                        selectedAnswers.length > index &&
                        selectedAnswers[index] == question.answerIndex;

                    final isAnsweredWrong = isQuizSubmitted &&
                        selectedAnswers.length > index &&
                        selectedAnswers[index] != question.answerIndex;
                    final wrongAnswere = isAnsweredWrong ? Colors.red : null;



                    return Card(
                      color: isAnsweredCorrectly ? Colors.green : wrongAnswere,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Column(
                              children: question.options.asMap().entries.map(
                                (entry) {
                                  final optionIndex = entry.key;
                                  final optionText = entry.value;
                                  final isSelected = selectedAnswers.length > index &&
                                      selectedAnswers[index] == optionIndex;

                                  return ListTile(
                                    title: Text(optionText),
                                    leading: Radio<int>(
                                      value: optionIndex,
                                      groupValue: selectedAnswers[index],
                                      onChanged: (int? value) {
                                        setState(() {
                                          selectedAnswers[index] = value;
                                        });
                                      },
                                    ),
                                    tileColor: isSelected ? Colors.grey : null,
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: selectedAnswers.contains(null) ? null : submitQuiz,
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


