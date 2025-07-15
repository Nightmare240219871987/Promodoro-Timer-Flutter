import 'package:flutter/material.dart';
import 'package:in_time/pages/add_page.dart';
import 'package:in_time/pages/settings_page.dart';
import 'package:in_time/widgets/timer_widget.dart';

Color primary = Color.fromARGB(255, 191, 153, 210);
Color secondary = Color.fromARGB(255, 124, 4, 184);

class StartPage extends StatefulWidget {
  final List<Widget> widgets = [];
  StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: secondary,
        title: ListTile(leading: Icon(Icons.alarm), title: Text("In Time")),
        actions: [
          TextButton(
            onPressed: onPressedAdd,
            child: Icon(Icons.add, color: Colors.white),
          ),
          TextButton(
            onPressed: onPressedSettings,
            child: Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.widgets.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsetsGeometry.all(5),
            child: widget.widgets[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: onPressed),
    );
  }

  void onPressed() {
    setState(() {
      widget.widgets.add(
        TimerWidget(timeTarget: 1, task: "Timer Widget schreiben."),
      );
    });
  }

  void onPressedSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }

  void onPressedAdd() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()));
  }
}
