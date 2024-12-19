import 'package:flutter/material.dart';
import 'package:quiz_app/quiz%20app/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int score = 0;
  int currentquestion = 0;
  String? selctedanswer;
  void answerchecking() {
    if (selctedanswer == questions[currentquestion]["correctAnswer"]) {
      setState(() {
        score++;
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Correct Answer"),backgroundColor: Colors.green,duration: Duration(seconds: 1),));
      });
    } else if (selctedanswer != questions[currentquestion]["correctAnswer"]) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wrong Anwerr"),backgroundColor: Colors.red,duration: Duration(seconds: 1 ),));
    }

    if (currentquestion < 10) {
      setState(() {
        currentquestion = (currentquestion + 1);
        selctedanswer = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: currentquestion == 10
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 60,
                    child: Icon(Icons.person,size: 30,),
                  ),
                  Text(
                    " Your Score Is ${score.toString()}",
                    style: const TextStyle(fontSize: 30),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentquestion = 0;
                          score = 0;
                        });
                      },
                      child: const Text("Play Again")),
                ],
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Container(
                        height: 250,
                        width: 400,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF8A4FDF),
                              Color(0xFFE0B6FF)
                            ], // More purple, lighter transition to white
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            questions[currentquestion]["question"],
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    ...(questions[currentquestion]["options"] as List<String>)
                        .map((option) => RadioListTile(
                            value: option,
                            groupValue: selctedanswer,
                            title: Text(option),
                            onChanged: (value) {
                              setState(() {
                                selctedanswer = value;
                              });
                            }))
                        .toList(),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: selctedanswer != null ? answerchecking : null,
                      child: const Text('Next Question'),
                    ),
                    Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
