import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "A Simple Intrest Calculator Application",
      home: SIForm(),
      theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent,
          brightness: Brightness.dark),
    ),
  );
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _currencies = ['Rupees', 'Dollar', 'Pound'];
  final _minimumPadding = 5.0;

  // ignore: non_constant_identifier_names
  var _new_dropdown_selected_value = 'Rupees';
  var simple_intrest_value = "";

  TextEditingController principalController = TextEditingController();
  TextEditingController intrestController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: Container(
        margin: EdgeInsets.all(_minimumPadding * 2.0),
        child: ListView(
          children: [
            getAssetImage(),
            Padding(
                padding: EdgeInsets.only(bottom: _minimumPadding * 2.0),
                child: TextField(
                  controller: principalController,
                  // style: textStyle,
                  decoration: InputDecoration(
                      labelText: "Principal",
                      labelStyle: textStyle,
                      hintText: "Enter the Principal Amount",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  keyboardType: TextInputType.number,
                )),
            Padding(
                padding: EdgeInsets.only(bottom: _minimumPadding * 2.0),
                child: TextField(
                  controller: intrestController,
                  decoration: InputDecoration(
                      labelText: "Rate of Intrest",
                      labelStyle: textStyle,
                      hintText: "Enter the Rate of Intrest",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  keyboardType: TextInputType.number,
                )),
            Padding(
                padding: EdgeInsets.only(bottom: _minimumPadding * 2.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: timeController,
                      decoration: InputDecoration(
                          labelText: "Term",
                          hintText: "Enter time",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.number,
                    )),
                    Container(
                      width: _minimumPadding * 3.0,
                    ),
                    Expanded(
                        child: DropdownButton(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _new_dropdown_selected_value,
                      onChanged: (String newValueSelected) {
                        setState(() {
                          _new_dropdown_selected_value = newValueSelected;
                        });
                      },
                    ))
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(bottom: _minimumPadding * 2.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            simple_intrest_value = calculateSimpleIntrest();
                          });
                        },
                      ),
                    ),
                    Container(
                      width: _minimumPadding * 3.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text("Reset", textScaleFactor: 1.5),
                        onPressed: () {
                          setState(() {
                            reset();
                          });
                        },
                      ),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(bottom: _minimumPadding * 2.0),
                child: Center(
                    child: Text(
                      simple_intrest_value,
                  style: textStyle,
                )))
          ],
        ),
      ),
    );
  }

  Widget getAssetImage() {
    AssetImage assetImage = AssetImage('images/money_2.png');
    Image image = Image(
      image: assetImage,
      width: 200.0,
      height: 170.0,
    );
    return Container(
      margin: EdgeInsets.all(_minimumPadding * 10.0),
      child: image,
    );
  }

  String calculateSimpleIntrest() {
    double principal = double.parse(principalController.text);
    String pri = principalController.text;
    debugPrint(pri);
    double interest = double.parse(intrestController.text);
    double time = double.parse(timeController.text);
    double simpleInterest = (principal*time*interest)/100;
    return "The Simple Interest: $simpleInterest $_new_dropdown_selected_value";
  }

  void reset() {
    principalController.text = '';
    intrestController.text = '';
    timeController.text = '';
    _new_dropdown_selected_value = _currencies[0];
    simple_intrest_value = '';
  }
}
