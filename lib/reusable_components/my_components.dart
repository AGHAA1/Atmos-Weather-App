import 'package:flutter/material.dart';






class CreateAlertDialog extends StatelessWidget {
  const CreateAlertDialog({super.key, required this.onChangedFunc, required this.onPressedFunc});
  final ValueChanged<String> onChangedFunc;
  final VoidCallback onPressedFunc;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: TextField (
            decoration: InputDecoration(
                hint: Text('City name'),
                border: OutlineInputBorder()
            ),

            onChanged: onChangedFunc
        ),


        actions: [
          TextButton(
            onPressed: onPressedFunc,
            child: Text('Add', style: TextStyle(fontSize: 15)),
          )
        ]
    );
  }
}


class CreateWeatherDetails extends StatelessWidget {
   const CreateWeatherDetails({super.key, required this.data1 , required this.data2,
     required this.weatherPara1, required this.weatherPara2, required this.unit1,
   required this.unit2});
  final dynamic data1;
  final dynamic data2;
  final String weatherPara1;
  final String weatherPara2;
  final String unit1;
  final String unit2;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Flexible(child: Text(weatherPara1, style: TextStyle(fontSize: 15, color: Colors.grey))),
                  Flexible(child: Text('$data1 $unit1')),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Flexible(child: Text(weatherPara2, style: TextStyle(fontSize: 15, color: Colors.grey))),
                  Flexible(child: Text('$data2 $unit2')),
                ],
              ),
            ),
          ]
      ),
    );
  }
}