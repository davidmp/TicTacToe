import 'dart:math';

import 'package:app_3raya/comp/CustomAppBar.dart';
import 'package:app_3raya/comp/CustomButton.dart';
import 'package:app_3raya/theme/AppTheme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToe());
}
class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicTacToePage(),
    );
  }
}

class TicTacToePage extends StatefulWidget {
  @override
  TicTacToeState createState() => TicTacToeState();
}

class TicTacToeState extends State<TicTacToePage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controllerJ1 = new TextEditingController();
  TextEditingController _controllerJ2 = new TextEditingController();
  final List<String> entries = <String>['1', '2', '3', '4'];
  final List<String> entries2 = <String>['Empate', 'Juan', 'xx', 'yy'];
  final List<String> entries3 = <String>['T', 'T', 'A', 'J'];
  final List<String> entries4 = <String>['0', '1', '0', '0'];
  List labelList = [" "," "," "," "," "," "," "," "," "];
  bool enableDisable=false;
  String turno="";
  String ganador="";
  bool clickTurno=false;
  int chance_flag=0;

  void accion() {
    setState(() {
      AppTheme.colorX=Colors.blue;
    });
  }

  void btnInicio(){
    labelList.replaceRange(0, 9, ["","","","","","","","",""]);
    ganador="";
    enableDisable=true;
    chance_flag=0;
    Random rnd = new Random();
    int min = 13, max = 42;
    int r = min + rnd.nextInt(max - min);
    if(r%2==0){
      turno="J1:${_controllerJ1.value.text}-(X)";
    }else{
      turno="J2:${_controllerJ2.value.text}-(O)";
    }
  }
  void btnAnular(){
    labelList.replaceRange(0, 9, ["","","","","","","","",""]);
    enableDisable=false;
    turno="";
  }

  void numClick(String text, int index) {
    setState((){
      if(text==""){
        chance_flag+=1;
      }
      start(index);
      matchCheck();
      print("ver txt: ${text} index: ${index} num val: ${labelList[index]} cant:${chance_flag}");
    });
  }
  void start(int index){
    var parts = turno.split(':');
    if(parts[0].trim()=="J1" && clickTurno==false){
      labelList[index]="X";
      clickTurno=true;
      turno="J2:${_controllerJ2.value.text}-(O)";
    }else{
      labelList[index]="O";
      clickTurno=false;
      turno="J1:${_controllerJ1.value.text}-(X)";
    }
  }
  void matchCheck() {
    if ((labelList[0]=="X") && (labelList[1]=="X") && (labelList[2]=="X")) {xWins();}
    else if ((labelList[0]=="X") && (labelList[4]=="X") && (labelList[8]=="X")) {xWins();}
    else if ((labelList[0]=="X") && (labelList[3]=="X") && (labelList[6]=="X")) {xWins();}
    else if ((labelList[1]=="X") && (labelList[4]=="X") && (labelList[7]=="X")) {xWins();}
    else if ((labelList[2]=="X") && (labelList[4]=="X") && (labelList[6]=="X")) {xWins();}
    else if ((labelList[2]=="X") && (labelList[5]=="X") && (labelList[8]=="X")) {xWins();}
    else if ((labelList[3]=="X") && (labelList[4]=="X") && (labelList[5]=="X")) {xWins();}
    else if ((labelList[6]=="X") && (labelList[7]=="X") && (labelList[8]=="X")) {xWins();}
    else if ((labelList[0]=="O") && (labelList[1]=="O") && (labelList[2]=="O")) {oWins();}
    else if ((labelList[0]=="O") && (labelList[3]=="O") && (labelList[6]=="O")) {oWins();}
    else if ((labelList[0]=="O") && (labelList[4]=="O") && (labelList[8]=="O")) {oWins();}
    else if ((labelList[1]=="O") && (labelList[4]=="O") && (labelList[7]=="O")) {oWins();}
    else if ((labelList[2]=="O") && (labelList[4]=="O") && (labelList[6]=="O")) {oWins();}
    else if ((labelList[2]=="O") && (labelList[5]=="O") && (labelList[8]=="O")) {oWins();}
    else if ((labelList[3]=="O") && (labelList[4]=="O") && (labelList[5]=="O")) {oWins();}
    else if ((labelList[6]=="O") && (labelList[7]=="O") && (labelList[8]=="O")) {oWins();}
    else if(chance_flag==9) {
      enableDisable=false;
      ganador="Empate";
      turno="Termino";
    }
  }
  void xWins(){
    ganador="J1:${_controllerJ1.value.text}-(X)";
    enableDisable=false;
    turno="Termino";//if(chance_flag==9){ turno="Termino";}
  }
  void oWins(){
    ganador="J2:${_controllerJ2.value.text}-(O)";
    enableDisable=false;
    turno="Termino";//if(chance_flag==9){ turno="Termino";}
  }

  @override
  Widget build(BuildContext context) {
    AppTheme.colorX=Colors.blue;
    List funx=[numClick,numClick, numClick,numClick , numClick,numClick, numClick,numClick , numClick];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UPeU',
      themeMode: AppTheme.useLightMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.themeData,//Fin Agregado
      home: Scaffold(
        appBar: CustomAppBar(accionx: accion as Function),
        //appBar: AppBar(title: Text("Holas")),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    '3 en Raya',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Paytone',
                    ),
                  ),
//Aqui
                  _buidForm(),
                  GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5
                    ),
                    children: [
                      ...List.generate(
                        labelList.length,
                            (indexx) => CustomButton(
                          text: labelList[indexx],
                          index: indexx,
                          buttonenabled: enableDisable,
                          callback: funx[indexx] as Function,
                        ),
                      ),
                    ],
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                  ),
                  SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.grey.shade800,
                            child: const Text('T:'),
                          ),
                          label: Text(turno)),
                      Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.grey.shade800,
                            child: const Text('G:'),
                          ),
                          label: Text(ganador))
                    ],
                  ),
                  SizedBox(height: 2),
                  Text("TABLA DE PUNTAJES", style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Paytone',
                  ),),
                  SizedBox(height: 2),
                  Container(
                    height: 200,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleChildScrollView(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Card(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: Text('Partido ${entries[index]}',
                                      style: Theme.of(context).textTheme.headline6),
                                  subtitle: Row(mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: AppTheme.themeData.colorScheme.primaryContainer),
                                        child: Text("Ganador: ${entries2[index]}"),
                                      )
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Chip(
                                          avatar: CircleAvatar(
                                            backgroundColor: Colors.grey.shade800,
                                            child: const Text('P:'),
                                          ),
                                          label: Text("${entries4[index]}")),
                                      SizedBox(width: 2,),
                                      Chip(
                                          avatar: CircleAvatar(
                                            backgroundColor: Colors.grey.shade800,
                                            child: const Text('E:'),
                                          ),
                                          label: Text("${entries3[index]}")),
                                    ],
                                  ),
                                )
                              ],
                            )),
                          );
                        }
                    ),
                  )
                ],
              )
          )
      ),
    );
  }


  Form _buidForm(){
    return Form(
        key: _formKey,
        child: Padding(
            padding:  EdgeInsets.only(left: 40, right: 40),
            child: Column(
              children:  <Widget>[
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre Jugador 1:',
                  ),
                  controller: _controllerJ1,
                ),
                SizedBox(height: 6),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre Jugador 2:',
                  ),
                  controller: _controllerJ2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(onPressed: () {setState((){
                      btnInicio();
                    });}, child: Text("Iniciar")),
                    ElevatedButton(onPressed: (){setState((){
                      btnAnular();
                    });}, child: Text("Anular")),
                  ],
                )
              ],
            )
        ));
  }
}