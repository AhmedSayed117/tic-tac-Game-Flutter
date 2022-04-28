import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "X & O",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 40,
              ),
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: const MyGame(),
      ),
    );
  }
}


class MyGame extends StatefulWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  _MyGameState createState() => _MyGameState();
}

var _matrix = [
  ["", "", ""],
  ["", "", ""],
  ["", "", ""],
];
var countx = 0,county = 0;

class _MyGameState extends State<MyGame> {
  List<Color> arr = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Player 1 ",style:
                    TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                  SizedBox(width: 10),
                  Text("Player 2 ",style:
                  TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("$countx",style:
                  const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                  const SizedBox(width: 90),
                  Text("$county",style:
                  const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),),
                  const SizedBox(width: 10),
                ],
              )
            ],
          )),
          Expanded(
            flex: 3,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  bulidElement(0, 0,0),
                  bulidElement(0, 1,1),
                  bulidElement(0, 2,2)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  bulidElement(1, 0,3),
                  bulidElement(1, 1,4),
                  bulidElement(1, 2,5)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  bulidElement(2, 0,6),
                  bulidElement(2, 1,7),
                  bulidElement(2, 2,8)
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }

  String _char = "X";
  var background = Colors.white , color = Colors.white;
  Container bulidElement(int row, int col,int index) {
    return Container(
      width: 100,
      height: 100,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20.0),color: arr[index]),
      child: FlatButton(
        onPressed: () {
          if (_matrix[row][col].isEmpty) {
            setState(() {
              _matrix[row][col] = _char;
              if(_char == "X"){
                arr[index] = Colors.amber;

                // print(this.background);
              }else{
                arr[index] = Colors.red;
              }
              _char = _char == "X" ? "O" : "X";
              CheckWinner(row, col);
            });
          }
        },
        child: Text(
          _matrix[row][col],
          style: const TextStyle(fontSize: 60),
        ),
      ),
    );
  }

  var count = 0;
  CheckWinner(int x, int y) {
    //0 1
    count++;
    var col = 0,
        row = 0,
        diag = 0,
        rdiag = 0,
        n = _matrix.length - 1,
        player = _matrix[x][y]; //O

    for (int i = 0; i < _matrix.length; i++) {
      if (_matrix[x][i] == player) col++; // 1
      if (_matrix[i][y] == player) row++; // 1
      if (_matrix[i][i] == player) diag++; // 1
      if (_matrix[i][n - i] == player) rdiag++; //1
    }
    if (row == n + 1 || col == n + 1 || diag == n + 1 || rdiag == n + 1) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: const Text("Winner"), content: Text("$player won"));
          });
      if(player=="X") {
        countx++;
      } else {
        county++;
      }
      _matrix = [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""]
      ];
      _char = "X";
      count = 0;
      arr = [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
      ];
    } else if (count == 9) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
                title: Text("Draw"), content: Text("Game Draw"));
          });
      _matrix = [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""],
      ];
      _char = "X";
      count = 0;
      arr = [
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
        Colors.white,
      ];
    }
  }
}
