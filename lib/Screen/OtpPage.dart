import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpPage extends StatefulWidget {
  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {
  List<TextEditingController> _controllers = [
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
    new TextEditingController(),
  ];

  TextEditingController _currentController = new TextEditingController();
  int _currentControllerIndex;
  List<Widget> widgetList;

  @override
  void dispose() {
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _currentControllerIndex = 0;
    _currentController = _controllers[0];

    widgetList = [
      _buildInputNumber(_controllers[0]),
      _buildInputNumber(_controllers[1]),
      _buildInputNumber(_controllers[2]),
      _buildInputNumber(_controllers[3]),
      _buildInputNumber(_controllers[4]),
      _buildInputNumber(_controllers[5]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Enter OTP"),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Color(0xFFeaeaea),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Verifying your number!",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, top: 4.0, right: 16.0),
                    child: Text(
                      "Please type the verification code sent to",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, top: 2.0, right: 30.0),
                    child: Text(
                      "+91 9876543210",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Image(
                      image: AssetImage('Assets/images/otp-icon.png'),
                      height: 120.0,
                      width: 120.0,
                    ),
                  )
                ],
              ),
              flex: 90,
            ),
            Flexible(
              child: _buildInputNumberFields(),
              flex: 20,
            ),
            Flexible(
              child: _buildKeyboard(),
              flex: 90,
            ),
          ],
        ),
      ),
    );
  }

  _buildKeyboardFieldWidget(String input) {
    return MaterialButton(
      onPressed: () {
        inputTextToField(input);
      },
      child: Text(
        input,
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _buildDeleteFieldWidget() {
    return MaterialButton(
      onPressed: () {
        deleteText();
      },
      child: Image.asset(
        'Assets/images/delete.png',
        width: 25.0,
        height: 25.0,
      ),
    );
  }

  _buildCheckWidget() {
    return MaterialButton(
      onPressed: () {
        matchOtp();
      },
      child: Image.asset(
        'Assets/images/success.png',
        width: 25.0,
        height: 25.0,
      ),
    );
  }

  _buildKeyboardInputRow(Widget widget1, Widget widget2, Widget widget3) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget1,
          widget2,
          widget3,
        ],
      ),
    );
  }

  _buildInputNumber(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 2.0,
        left: 2.0,
      ),
      child: new Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          border: new Border.all(
            width: 1.0,
            color: Color.fromRGBO(0, 0, 0, 0.1),
          ),
          borderRadius: new BorderRadius.circular(4.0),
        ),
        child: new TextField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
          enabled: false,
          controller: controller,
          autofocus: false,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _buildInputNumberFields() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: widgetList.length,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        primary: false,
        scrollDirection: Axis.vertical,
        children: List<Container>.generate(
          widgetList.length,
          (int index) => Container(
            child: widgetList[index],
          ),
        ),
      ),
    );
  }

  _buildKeyboard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildKeyboardInputRow(
          _buildKeyboardFieldWidget('1'),
          _buildKeyboardFieldWidget('2'),
          _buildKeyboardFieldWidget('3'),
        ),
        _buildKeyboardInputRow(
          _buildKeyboardFieldWidget('4'),
          _buildKeyboardFieldWidget('5'),
          _buildKeyboardFieldWidget('6'),
        ),
        _buildKeyboardInputRow(
          _buildKeyboardFieldWidget('7'),
          _buildKeyboardFieldWidget('8'),
          _buildKeyboardFieldWidget('9'),
        ),
        _buildKeyboardInputRow(
          _buildDeleteFieldWidget(),
          _buildKeyboardFieldWidget('0'),
          _buildCheckWidget(),
        ),
      ],
    );
  }

  void inputTextToField(String str) {
    TextEditingController controller = _controllers[_currentControllerIndex];
    controller.text = str;
    if (_currentControllerIndex != _controllers.length - 1) {
      _currentController = _controllers[_currentControllerIndex + 1];
      _currentControllerIndex += 1;
    }
  }

  void deleteText() {
    if (_currentController.text.length == 0) {
      if (_currentControllerIndex != 0) {
        _currentControllerIndex -= 1;
        _currentController = _controllers[_currentControllerIndex];
      }
      _currentController.text = '';
    } else {
      _currentController.text = '';
      if (_currentControllerIndex != 0) {
        _currentControllerIndex -= 1;
        _currentController = _controllers[_currentControllerIndex];
      }
    }
  }

  void matchOtp() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Successfully"),
          content: Text("Otp matched successfully."),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
