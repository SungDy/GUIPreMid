import 'package:flutter/material.dart';

void main() {
  runApp(ConverterApp());
}

class ConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontSize: 16.0, color: Colors.black87),
          headline6: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
      ),
      home: ConverterScreen(),
    );
  }
}

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  TextEditingController _inputController = TextEditingController();
  String _result = '';
  String _fromUnit = 'Fahrenheit';
  String _toUnit = 'Celsius';

  void _convertTemperature() {
    String inputText = _inputController.text;
    double? inputValue = double.tryParse(inputText);

    if (inputValue == null) {
      setState(() {
        _result = 'Please enter a valid number';
      });
      return;
    }

    double result;
    if (_fromUnit == 'Fahrenheit') {
      if (_toUnit == 'Celsius') {
        result = (inputValue - 32) * 5 / 9;
      } else if (_toUnit == 'Kelvin') {
        result = (inputValue - 32) * 5 / 9 + 273.15;
      } else {
        result = inputValue;
      }
    } else if (_fromUnit == 'Celsius') {
      if (_toUnit == 'Fahrenheit') {
        result = (inputValue * 9 / 5) + 32;
      } else if (_toUnit == 'Kelvin') {
        result = inputValue + 273.15;
      } else {
        result = inputValue;
      }
    } else {
      if (_toUnit == 'Fahrenheit') {
        result = (inputValue - 273.15) * 9 / 5 + 32;
      } else if (_toUnit == 'Celsius') {
        result = inputValue - 273.15;
      } else {
        result = inputValue;
      }
    }

    setState(() {
      _result = '$_fromUnit: $inputValue\n$_toUnit: ${result.toStringAsFixed(2)}';
    });
  }

  void _clearInput() {
    setState(() {
      _inputController.clear();
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _inputController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter Temperature',
                        hintText: 'e.g., 98.6',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _fromUnit,
                            onChanged: (value) {
                              setState(() {
                                _fromUnit = value!;
                              });
                            },
                            items: ['Fahrenheit', 'Celsius', 'Kelvin']
                                .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                        value: value, child: Text(value)))
                                .toList(),
                            decoration: InputDecoration(
                              labelText: 'From',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: _toUnit,
                            onChanged: (value) {
                              setState(() {
                                _toUnit = value!;
                              });
                            },
                            items: ['Fahrenheit', 'Celsius', 'Kelvin']
                                .map<DropdownMenuItem<String>>(
                                    (value) => DropdownMenuItem<String>(
                                        value: value, child: Text(value)))
                                .toList(),
                            decoration: InputDecoration(
                              labelText: 'To',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _convertTemperature,
                      child: Text('Convert'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _clearInput,
                      child: Text('Clear'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      _result,
                      style: TextStyle(fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
