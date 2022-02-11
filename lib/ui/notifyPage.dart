import 'package:flutter/material.dart';

class NotifyPage extends StatelessWidget {
  final String? body;
  const NotifyPage({Key? key,
        required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xFF2f3542),

      appBar: AppBar(
        backgroundColor: Color(0xFF2f3542) ,
        title: const Text('مسار الملف'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        Padding(
        padding: const EdgeInsets.all(8.0),
           child:  Text(
              body ?? "",

              style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,
              color: Colors.white),
              textAlign: TextAlign.left,
            ),
        ),

          ],
        )


      ),
    );
  }
}