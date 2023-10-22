import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poke_app_beta/mainscreens/pokemon_detail_screen.dart';
import 'pokemon_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pokapi = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  late List pokedex = [];
  void initState(){
    super.initState();
    if(mounted){
      pullPokemonData();
    }
  }
  //get http => null;
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
              'Pokedex',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Set the color of the text
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: pokedex != null
                    ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: pokedex.length,
                  itemBuilder: (context, index) {
                    var type = pokedex[index]['type'][0];
                    return InkWell( child: Padding(

                      padding: EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                          type == 'Grass'? Colors.greenAccent :
                          type == 'Water'? Colors.lightBlueAccent :
                          type == 'Fire'? Colors.redAccent :
                          type == 'Electric'? Colors.yellow :
                          type == 'Rock' ? Colors. blueGrey:
                          type == 'Ground'? Colors.brown :
                          type == 'Bug'? Colors.orange :
                          type == 'Poison'? Colors.deepPurple :
                          type == 'Psychic'? Colors.purpleAccent :
                          type == 'Ghost'? Colors.lightGreenAccent :
                          type == 'Dragon'? Colors.redAccent.shade100 :
                          type == 'Fighting'? Colors.grey.shade500 :
                          type == 'Ice'? Colors.blue.shade200 :
                          Colors.grey.withOpacity(0.3),
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
                                    pokedex[index]['name'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    pokedex[index]['num'],
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
                                    imageUrl: pokedex[index]['img'],
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
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => PokemonDetail(
                            pokemonDetail: pokedex[index],
                            color: type == 'Grass'? Colors.greenAccent :
                            type == 'Water'? Colors.lightBlueAccent :
                            type == 'Fire'? Colors.redAccent :
                            type == 'Electric'? Colors.yellow :
                            type == 'Rock' ? Colors. blueGrey:
                            type == 'Ground'? Colors.brown :
                            type == 'Bug'? Colors.orange :
                            type == 'Poison'? Colors.deepPurple :
                            type == 'Psychic'? Colors.purpleAccent :
                            type == 'Ghost'? Colors.lightGreenAccent :
                            type == 'Dragon'? Colors.redAccent.shade100 :
                            type == 'Fighting'? Colors.grey.shade500 :
                            type == 'Ice'? Colors.blue.shade200 :
                            Colors.grey.withOpacity(0.3),
                            pokeTag: index)));
                      },
                    );

                  },
                )
                    : Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Add the function you want to execute when the button is pressed
            },
            child: Text(
              'Explore',
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

  void pullPokemonData(){
    var url = Uri.https("raw.githubusercontent.com", "/Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value){
     if(value.statusCode == 200){
      var decodedJsonData = jsonDecode(value.body);
      pokedex = decodedJsonData['pokemon'];
      print(pokedex[1]['name']);
      setState(() {

      });
    }
    });

  }
}
