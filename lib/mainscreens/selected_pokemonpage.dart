import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class SelectedPokemonPage extends StatefulWidget {
  final String name;
  final String num;
  final String type;
  final String img;

  SelectedPokemonPage({
    required this.name,
    required this.num,
    required this.type,
    required this.img,
  });

  @override
  _SelectedPokemonPageState createState() => _SelectedPokemonPageState();
}

class _SelectedPokemonPageState extends State<SelectedPokemonPage> {
  var enemy;
  int pokemonHP = 100;
  int enemyHP = 100;
  int attack = 70; // Default attack value for your Pokemon
  int defense = 40; // Default defense value for your Pokemon
  int level = 1;
  final List<String> pokemonSequence = ['010', '013', '016', '019','014','011',
    '001','007','020','005','017','012','018','015','003','009','006'  ];
  int currentPokemonIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchPokemon();
  }

  Future<void> fetchPokemon() async {
    String nextPokemonNum = pokemonSequence[currentPokemonIndex];
    await fetchPokemonByNumber(nextPokemonNum);
  }

  Future<void> fetchPokemonByNumber(String num) async {
    var url = Uri.https(
      "raw.githubusercontent.com",
      "/Biuni/PokemonGO-Pokedex/master/pokedex.json",
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        var enemyData =
        data['pokemon'].firstWhere((pokemon) => pokemon['num'] == num, orElse: () => {});

        setState(() {
          enemy = enemyData;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void battle() {
    final rng = Random();
    bool isAttack = rng.nextBool();

    if (enemy != null) {
      if (isAttack) {
        setState(() {
          enemyHP -= attack;
        });
      } else {
        setState(() {
          if(enemy['num'] == '010' ){
          pokemonHP -= 10;
          }
          if(enemy['num'] == '013' ){
            pokemonHP -= 20;
          }
          if(enemy['num'] == '016' ){
            pokemonHP -= 30;
          }
          if(enemy['num'] == '019' ){
            pokemonHP -= 40;
          }
          if(enemy['num'] == '014' ){
            pokemonHP -= 40;
          }
          if(enemy['num'] == '011'  ){
            pokemonHP -= 50;
          }
          if(enemy['num'] == '007' || enemy['num'] == '020' || enemy['num'] == '001' ){
            pokemonHP -= 70;
          }
          if(enemy['num'] == '005'  ){
            pokemonHP -= 80;
          }
          if(enemy['num'] == '017' || enemy['num'] == '012'|| enemy['num'] == '018' || enemy['num'] == '015'  ){
            pokemonHP -= 90;
          }
          if(enemy['num'] == '003'|| enemy['num'] == '009' ){
            pokemonHP -= 100;
          }
          if(enemy['num'] == '006'){
            pokemonHP -= 120;
          }



        });
      }

      if (enemyHP <= 0) {
        if (currentPokemonIndex < pokemonSequence.length - 1) {
          currentPokemonIndex++;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Congratulations!',
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Well Done! You Have Defeted ${enemy['name']}!',
                      style: TextStyle(
                        fontSize: 16.0, // Adjust the font size as needed
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              );
            },
          );
          fetchPokemon();


          setState(() {
            enemyHP = 100;

          });
          setState(() {
            pokemonHP += 20;
            level ++;
          });
          if(enemy['num'] == '019' || enemy['num'] == '020'||
              enemy['num'] == '018'|| enemy['num'] == '009'){
            showDialog(
              context: context,
              builder: (BuildContext context)  {
                return AlertDialog(
                  title: Text(
                    'Welcome to Pokemon Center!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You Pokemon Will Randomly Increment HP Between',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '15% to 50%',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          List<double> percentages = [0.15, 0.20, 0.30, 0.50];
                          for (double percentage in percentages) {
                            pokemonHP += (pokemonHP * percentage).round();
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );

          }
        } else {

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Victory!'),
                content: Text('You have defeated all the Pokemon!'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pop(context);

                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    }

    if (pokemonHP <= 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Defeated!'),
            content: Text('You have been defeated by ${enemy['name']}!'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Pokemon #${widget.num}'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/poke.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.1),
              child: Center(
                child: Container(
                  height: kToolbarHeight,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Selected Pokemon',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                _buildPokemonBox(
                  widget.name,
                  widget.num,
                  widget.type,
                  widget.img,
                  hp: pokemonHP,
                  attack: attack,
                  defense: defense,
                ),
                SizedBox(height: 40.0),
                Text(
                  'Battle against Pokemon',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                if (enemy != null)
                  _buildPokemonBox(
                    enemy['name'],
                    enemy['num'],
                    enemy['type'][0],
                    enemy['img'],
                    hp: enemyHP,
                  ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    battle();
                  },
                  child: Text('Battle'),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Lv. $level',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonBox(
      String name,
      String num,
      String type,
      String img, {
        int hp = 100,
        int attack = 0,
        int defense = 0,
      }) {
    if (num.toLowerCase() == '010') {
      attack = 10;
      defense = 20;
    }
    else if (num == '013'){
      attack = 20;
      defense = 30;
    }
    else if (num == '016'){
      attack = 30;
      defense = 30;
    }
    else if (num == '019'){
      attack = 40;
      defense = 40;
    }
    else if (num == '014'){
      attack = 50;
      defense = 40;
    }
    else if (num == '011'){
      attack = 50;
      defense = 50;
    }
    else if (num == '007'){
      attack = 70;
      defense = 40;
    }
    else if (num == '005'){
      attack = 80;
      defense = 40;
    }
    else if (num == '020' || num == '001'){
      attack = 80;
      defense = 50;
    }
    else if (num == '017' || num == '012'|| num == '018' || num == '015'){
      attack = 90;
      defense = 60;
    }
    else if (num == '003' || num == '009'){
      attack = 100;
      defense = 90;
    }
    else if (num == '006'){
      attack = 120;
      defense = 100;
    }

    {
      return Container(
        decoration: BoxDecoration(
          color: type == 'Grass'
              ? Colors.greenAccent
              : type == 'Water'
              ? Colors.lightBlueAccent
              : type == 'Fire'
              ? Colors.redAccent
              : type == 'Bug'
              ? Colors.orange
              : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: -10,
              right: -10,
              child: Image.asset(
                'images/poke.png',
                height: 100,
                fit: BoxFit.fitHeight,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    num,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    type,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'HP: $hp',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Attack: $attack', // Display Attack attribute
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Defense: $defense', // Display Defense attribute
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  Image.network(
                    img,
                    height: 100,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
      );
    }
  }
}