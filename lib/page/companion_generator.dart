import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'interest_page.dart';
import 'thanks_page.dart';

class CompanionGenerator {
  static Future<String> generateCompanionName(
      String selectedRegion, String selectedQuality) async {
    final String data = await loadJsonData();
    final jsonData = json.decode(data);

    final Map<String, dynamic> regionsData = jsonData['companion_names'];

    if (regionsData.containsKey(selectedRegion)) {
      final Map<String, dynamic> companionsData = regionsData[selectedRegion];

      if (companionsData.containsKey(selectedQuality)) {
        final String companionName = companionsData[selectedQuality];

        if (companionName.isNotEmpty) {
          return companionName;
        }
      }
    }

    return '';
  }

  static Future<String> loadJsonData() async {
    // Charger les données à partir du fichier JSON
    String data = await rootBundle.loadString('assets/data/compagnons.json');
    return data;
  }
}

class CongratulationPage extends StatefulWidget {
  @override
  _CongratulationPageState createState() => _CongratulationPageState();
}

class _CongratulationPageState extends State<CongratulationPage>
    with SingleTickerProviderStateMixin {
  String selectedRegion = 'Alsace';
  String selectedQuality = 'Prise d’initiative';
  String companionName = '';
  String pageTitle = 'Félicitations pour avoir terminé le quiz ! Choisissez maintenant votre région préférée et une de vos qualités.';
  bool isFinished = false;

  List<String> regions = [
    "-",
    "Alsace",
    "Aquitaine",
    "Auvergne",
    "Normandie",
    "Bourgogne",
    "Bretagne",
    "Centre-Val de Loire",
    "Champagne-Ardenne",
    "Corse",
    "Franche-Comté",
    "Île-de-France",
    "Languedoc-Roussillon",
    "Limousin",
    "Lorraine",
    "Midi-Pyrénées",
    "Nord-Pas-de-Calais",
    "Pays de la Loire",
    "Picardie",
    "Poitou-Charentes",
    "Provence-Alpes-Côte d'Azur",
    "Rhône-Alpes"
  ];

  List<String> qualities = [
    "-",
    "Prise d’initiative",
    "Loyauté",
    "Sympathie",
    "Bienveillance",
    "Empathie",
    "Honnêteté",
    "Altruisme",
    "Esprit d’équipe",
    "Diplomatie",
    "Enthousiasme",
    "Rigueur",
    "Sincérité",
    "Curiosité",
    "Ouverture d’esprit",
    "Adaptabilité",
    "Créativité",
    "Intégrité",
    "Autonomie",
    "Ambition",
    "Patience",
    "Capacité d’écoute"
  ];

  void generateCompanionName() async {
    final String name = await CompanionGenerator.generateCompanionName(
        selectedRegion, selectedQuality);
    setState(() {
      companionName = name;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF327E89),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  isFinished ? 'Voici votre nom de compagnon' : 'Félicitations ! Vous avez un nouveau compagnon',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                if (isFinished)
                  Text(
                    companionName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                if (!isFinished) Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: selectedRegion,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRegion = newValue!;
                          generateCompanionName();
                        });
                      },
                      items: regions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4, // Largeur basée sur la largeur de l'écran
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    DropdownButton<String>(
                      value: selectedQuality,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedQuality = newValue!;
                          generateCompanionName();
                        });
                      },
                      items: qualities.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4, // Largeur basée sur la largeur de l'écran
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (!isFinished) {
                      generateCompanionName();
                      setState(() {
                        isFinished = true;
                      });
                    } else {
                      showConfirmationDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFEE7203),
                  ),
                  child: Text(
                    isFinished ? 'Intéressé(e) par une newsletter ou une formation?' : 'Valider',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmation'),
        content: const Text(
          'Voulez-vous vous inscrire à notre newsletter ou à une formation?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThankYouPage()),
              );
            },
            child: Text('Non'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InterestPage()),
              );
            },
            child: Text('Oui'),
          ),
        ],
      );
    },
  );
}

