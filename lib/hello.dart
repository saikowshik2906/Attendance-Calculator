import 'package:hi/widgets/app_button_widget.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Attendance'),
        ),
        body: Hello(),
      ),
    );
  }
}

class Hello extends StatefulWidget {
  @override
  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  TextEditingController totalClasses = TextEditingController();
  TextEditingController classesAttended = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("photos/logo.jpg"),
              ],
            ),
            SizedBox(height: 30,),
            Text(
              "",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: totalClasses,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "Total number of classes attended",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10,),
            TextFormField(
              controller: classesAttended,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            ),
            SizedBox(height: 30,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButtonWidget(
                  title: "GO!",
                  titleColor: Colors.white,
                  buttonBackgroundColor: Color.fromRGBO(0, 0, 255, 1),
                  buttonBorderColor: Color.fromRGBO(0, 0, 255, 1),
                  onPressed: () {
                    calculateResult(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void calculateResult(BuildContext context) {
    double totalClassesValue = double.tryParse(totalClasses.text) ?? 0;
    double classesAttendedValue = double.tryParse(classesAttended.text) ?? 0;

    if (classesAttendedValue > totalClassesValue || classesAttendedValue < 0 || totalClassesValue < 0) {
      showErrorDialog(context, 'ERROR! Please enter valid values.');
      return;
    }

    int a = 0;
    double b = (classesAttendedValue / totalClassesValue) * 100;

    if (b >= 75) {
      while (b > 75) {
        a++;
        totalClassesValue++;
        b = (classesAttendedValue / totalClassesValue) * 100;
      }
      a--;
      if (a < 0) {
        a = 0;
      }
      showResultDialog(context, 'You can bunk $a classes');
    } else {
      while (b < 75) {
        a++;
        totalClassesValue++;
        classesAttendedValue++;
        b = (classesAttendedValue / totalClassesValue) * 100;
      }
      showResultDialog(context, 'You should attend $a classes');
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showResultDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Result'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
