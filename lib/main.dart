import 'package:flutter/material.dart';
// import 'globals.dart' as globals;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'getting text input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  TextEditingController myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sentence Checker App',
          style: TextStyle(
            fontFamily: 'IndieFlower',
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: TextField(
          controller: myController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          String text = myController.text;
          print(text);
          Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) => const SecondRoute()),
              MaterialPageRoute(
                builder: (context) => SecondRoute(
                  text: text,
                ),
              ));
          // );
        },
        tooltip: 'Show me the value!', //show string when touched
        child: Text(
          "Enter",
          style: TextStyle(fontFamily: 'IndieFlower', fontSize: 20.0),
        ),
        backgroundColor: Colors.black,

        // const Icon(Icons.text_fields),
      ),
    );
  }
}

class SecondRoute extends StatefulWidget {
  String text;
  //const SecondRoute({Key? key}) : super(key: key);
  SecondRoute({Key? key, required this.text}) : super(key: key);

  @override
  _SecondRouteState createState() => _SecondRouteState();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Second Route"),
  //     ),
  //     body: Center(
  //       child: Text(
  //         text,
  //         style: TextStyle(fontSize: 24),
  //       ),
  //     ),
  //   );
  // }
}

// class _SecondRouteState extends State<SecondRoute> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Second Route"),
//       ),
//       body: Center(
//         child: Text(
//           "hello world",
//           // text,
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

class _SecondRouteState extends State<SecondRoute> {
  String newT = "";
  String pressedText = "";
  // _SecondRouteState(this.newT);
  List<ElevatedButton> buttonsList = [];
  bool _flag = true;
  List wordlist = [];
  List shufflelist = [];

  List breakText() {
    newT = widget.text;
    var x = newT.split(" ");
    print(x);
    bool res = x.remove("");
    while (res == true) {
      res = x.remove("");
    }
    print(x);
    return x;
  }

  onButtonPressed(String buttonValue) {
    // print('You clicked $buttonValue');
    pressedText = pressedText + " " + buttonValue;
    // print(pressedText);
  }

  List makeShuffle(List list) {
    List puranlist = list;
    puranlist.shuffle();

    return puranlist;
  }

  bool checkpressedText(String text) {
    var output = text.split(" ");
    var input = newT.split(" ");
    bool res = output.remove("");
    bool whiteSpace = input.remove("");
    while (res == true) {
      res = output.remove("");
    }
    while (whiteSpace == true) {
      whiteSpace = output.remove("");
    }
    bool isCorrect = true;
    if (output.length == input.length) {
      for (int i = 0; i < output.length; i++) {
        if (input[i] != output[i]) {
          isCorrect = false;
          break;
        }
      }
    } else {
      isCorrect = false;
    }
    return isCorrect;
  }

  @override
  void initState() {
    super.initState();
    wordlist = breakText(); // initialize from here
    shufflelist = makeShuffle(wordlist);
  }

  List<Widget> _buildButtonsWithNames() {
    List<ElevatedButton> buttonsList = [];
    for (int i = 0; i < shufflelist.length; i++) {
      buttonsList.add(
        new ElevatedButton(
          onPressed: () => {
            setState(() {
              List<ElevatedButton> buttonsList = [];
              onButtonPressed(shufflelist[i]);
              _flag = !_flag;
            }),
          },
          child: Text(shufflelist[i]),
          style: ElevatedButton.styleFrom(
              primary: _flag ? Colors.grey : Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(40.0))),
          // style: ButtonStyle(
          //     overlayColor: getColor(Colors.white, Colors.teal),
          //     backgroundColor: getColor(Colors.blue, Colors.red)),
        ),
      );
    }
    return buttonsList;
  }

  MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
  }

  @override
  Widget build(BuildContext context) {
    List<ElevatedButton> buttonsList = [];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Press bubbles",
          style: TextStyle(fontSize: 25.0, fontFamily: 'IndieFlower'),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Text(
            pressedText,
            style: TextStyle(
              fontSize: 30.0,
            ),
          ),
          Expanded(
            // child: Center(
            //     child: InkWell(
            //   onTap: () {
            //     setState(() {
            //       pressedText = pressedText;
            //     });
            //   },
            //   child: Wrap(
            //     children: _buildButtonsWithNames(),
            //   ),
            // )),
            child: Center(
              child: Wrap(
                children: _buildButtonsWithNames(),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              bool f = checkpressedText(pressedText);
              if (f == true) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Result',
                      style: TextStyle(
                          fontFamily: 'IndieFlower',
                          fontSize: 20.0,
                          color: Colors.black),
                    ),
                    content: const Text(
                      'Correct',
                      style: TextStyle(
                          fontFamily: 'IndieFlower',
                          fontSize: 20.0,
                          color: Colors.black),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              } else {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Result',
                      style: TextStyle(
                          fontFamily: 'IndieFlower',
                          fontSize: 20.0,
                          color: Colors.black),
                    ),
                    content: const Text(
                      'Incorrect',
                      style: TextStyle(
                          fontFamily: 'IndieFlower',
                          fontSize: 20.0,
                          color: Colors.black),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text(
              "Check",
              style: TextStyle(
                  fontFamily: 'IndieFlower',
                  fontSize: 40.0,
                  color: Colors.black),
            ),
          )
        ],
      ),
      // Center(
      //   child:
      //   Wrap(
      //     children: _buildButtonsWithNames(),
      //   ),

      // )
      // Center(
      //   child: Text(
      //     pressedText,
      //     // text,
      //     style: TextStyle(fontSize: 24),
      //   ),

      // ),
    );
  }
}
