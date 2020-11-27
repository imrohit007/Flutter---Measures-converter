import 'package:flutter/material.dart';
import 'util/convert_util.dart';

void main() {
  runApp(MaterialApp(         //we are returning MaterialApp which has two properties title and home 
    title: 'Measures Converter',
    home: MyApp(),            //home is what the user see on screnn
  ));
}
//stateful widget is used because we allow user to change the data.

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  double _numberFrom = 0;
  String _startMeasure ;
  String _convertedMeasure ;
  double _result = 0;
  String _resultMessage = '';
  @override
  Widget build(BuildContext context) {
    double sizeX = MediaQuery.of(context).size.width;
    double sizeY = MediaQuery.of(context).size.height;
    final TextStyle inputStyle = TextStyle(   // styling of TextFields, DropdownButtons and Button
      fontSize: 20,
      color: Colors.blue[900],
    );
    final TextStyle labelStyle = TextStyle(    // we will use it for text styling
      fontSize: 24,
      color: Colors.grey[700],
    );

    final spacer = Padding(padding: EdgeInsets.only(bottom: sizeY/40));
    final List<String> _measures = [
      'meters',
      'kilometers',
      'grams',
      'kilograms',
      'feet',
      'miles',
      'pounds (lbs)',
      'ounces',
    ];
    return Scaffold(        //A scaffold widget represents a screen in materialApp widget. it allows us to add an application bar to the app.
      appBar: AppBar(
        title: Text('Measures Converter'),
      ),
      body: Container(       //we will return container which takes padding
        width: sizeX, 
        padding: EdgeInsets.all(sizeX/20),
        child: SingleChildScrollView(child: Column(
          children: [
            Text('Value', style: labelStyle,),
            spacer,
            TextField(            //It is used to take the user input.
              style: inputStyle,
              decoration: InputDecoration( 
                    hintText: "Please insert the measure to be converted", 
                  ), 
              onChanged: (text) {           //setState() methods tells the framework that the state of an object has changed, and the UI needs to be updated.
                setState(() {
                  _numberFrom = double.parse(text);
                });
              },
            ),
            spacer,
            Text('From', style: labelStyle,),
            spacer,
            DropdownButton(       // map the value in dropdown
              isExpanded: true,
              style: inputStyle,
              value: _startMeasure,
              items: _measures.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: inputStyle,),
                );
              }).toList(),
              onChanged: (value) {
                onStartMeasureChanged(value);
              },
            ),
            spacer,
            Text('To', style: labelStyle,),
            spacer,
            DropdownButton(
              isExpanded: true,
              style: inputStyle,
              value: _convertedMeasure,
              items: _measures.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: inputStyle,),
                );
              }).toList(),
              onChanged: (value) {
                onConvertedMeasureChanged(value);
              },
            ),
            spacer,
            RaisedButton(child:Text('Convert', style: inputStyle),
              onPressed: ()=>convert(),),
            spacer,
            Text(_resultMessage, style: labelStyle,)
          ],
        )),
      ),
    );
  }

  void onStartMeasureChanged(String value) {
    setState(() {
      _startMeasure = value;
    });
  }
  void onConvertedMeasureChanged(String value) {
    setState(() {
      _convertedMeasure = value;
    });
  }

  void convert() {
    if (_startMeasure.isEmpty || _convertedMeasure.isEmpty || _numberFrom==0) {
      return;
    }
    Conversion c = Conversion();
    double result = c.convert(_numberFrom, _startMeasure, _convertedMeasure);
    setState(() {
      _result = result;
      if (result == 0) {
        _resultMessage = 'This conversion cannot be performed';
      }
      else {
        _resultMessage = '${_numberFrom.toString()} $_startMeasure are ${_result.toString()} $_convertedMeasure';   
      }

    });
  }

}
