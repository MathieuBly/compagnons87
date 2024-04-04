import 'package:flutter/material.dart';
import './../page/language_selection.dart';

class ThankYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF327E89),
              ),
            ),
            const Text(
              'Merci d\'avoir participé à ce quiz. Nous espérons vous revoir au restaurant !',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LanguageSelection()),
                );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFFEE7203)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
