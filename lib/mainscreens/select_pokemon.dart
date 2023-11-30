import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app_beta/mainscreens/pokemon_detail_screen.dart';
import 'package:poke_app_beta/mainscreens/selected_pokemonpage.dart';
import 'main_screen.dart';
import 'pokemon_detail_screen.dart';

class SelectPokemon extends StatefulWidget {
  const SelectPokemon({Key? key}) : super(key: key);

  @override
  State<SelectPokemon> createState() => _SelectPokemonState();
}

class _SelectPokemonState extends State<SelectPokemon> {
  var pokapi = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  late List pokedex = [];
  var selectedPokemon; // Store the selected Pokemon

  void initState() {
    super.initState();
    if (mounted) {
      pullPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: null,
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Select a Pokemon',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Set the color of the text
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Display the initial three Pokemon
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var currentPokemon = pokedex.firstWhere(
                            (pokemon) => pokemon['num'] == ['001', '004', '007'][index],
                        orElse: () => {},
                      );

                      if (currentPokemon.isNotEmpty) {
                        var type = currentPokemon['type'][0];
                        return InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: type == 'Grass'
                                    ? Colors.greenAccent
                                    : type == 'Water'
                                    ? Colors.lightBlueAccent
                                    : type == 'Fire'
                                    ? Colors.redAccent
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
                                          currentPokemon['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          currentPokemon['num'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          type,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                        CachedNetworkImage(
                                          imageUrl: currentPokemon['img'],
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              selectedPokemon = currentPokemon;
                            });
                          },
                        );
                      } else {
                        return Container(); // Placeholder for empty case
                      }
                    },
                  ),
                  SizedBox(height: 20.0),

                  if (selectedPokemon != null)
                    Column(
                      children: [
                        Text(
                          "You have Selected",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: selectedPokemon['type'][0] == 'Grass'
                                    ? Colors.greenAccent
                                    : selectedPokemon['type'][0] == 'Water'
                                    ? Colors.lightBlueAccent
                                    : selectedPokemon['type'][0] == 'Fire'
                                    ? Colors.redAccent

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
                                          selectedPokemon['name'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          selectedPokemon['num'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          selectedPokemon['type'][0],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        CachedNetworkImage(
                                          imageUrl: selectedPokemon['img'],
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PokemonDetail(
                                  pokemonDetail: selectedPokemon,
                                  color: selectedPokemon['type'][0] == 'Grass'
                                      ? Colors.greenAccent
                                      : selectedPokemon['type'][0] == 'Water'
                                      ? Colors.lightBlueAccent
                                      : selectedPokemon['type'][0] == 'Fire'
                                      ? Colors.redAccent
                                      : Colors.grey.withOpacity(0.3),
                                  pokeTag: -1, // Use a unique tag for the selected Pokemon
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SelectedPokemonPage(
                                  name: selectedPokemon['name'],
                                  num: selectedPokemon['num'],
                                  type: selectedPokemon['type'][0],
                                  img: selectedPokemon['img'],
                                ),
                              ),
                            );
                            // Add your logic or navigation here
                          },
                          child: Text(
                            'Ready for the Tournament',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlueAccent,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
            child: Text(
              'Back',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  void pullPokemonData() {
    var url = Uri.https("raw.githubusercontent.com", "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        pokedex = decodedJsonData['pokemon'];
        print(pokedex[1]['name']);
        setState(() {});
      }
    });
  }
}