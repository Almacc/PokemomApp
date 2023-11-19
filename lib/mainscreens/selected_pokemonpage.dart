import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  var pokemon010; // Store Pokemon #010 data

  @override
  void initState() {
    super.initState();
    fetchPokemon010(); // Fetch Pokemon #010 data
  }

  Future<void> fetchPokemon010() async {
    var url = Uri.https(
        "raw.githubusercontent.com", "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        var pokemon010Data = data['pokemon']
            .firstWhere((pokemon) => pokemon['num'] == '010', orElse: () => {});

        setState(() {
          pokemon010 = pokemon010Data;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Display selected Pokemon details
            Text(
              'Selected Pokemon',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            // Display the selected Pokemon in a box-like format
            _buildPokemonBox(
              widget.name,
              widget.num,
              widget.type,
              widget.img,
            ),
            SizedBox(height: 40.0),
            // Display Pokemon #010 for battle
            Text(
              'Battle against Pokemon #010 (Caterpie)',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            if (pokemon010 != null)
            // Display Pokemon #010 in a box-like format for battle
              _buildPokemonBox(
                pokemon010['name'],
                pokemon010['num'],
                pokemon010['type'][0],
                pokemon010['img'],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonBox(
      String name,
      String num,
      String type,
      String img,
      ) {
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
                Image.network(
                  img,
                  height: 120,
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