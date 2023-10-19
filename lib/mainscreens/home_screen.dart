import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text('Pokedex'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: pokedex != null
                    ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: pokedex.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white38,
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: -10,
                            right: -10,
                            child: Image.asset('images/poke.png', height: 100, fit: BoxFit.fitHeight,),
                          ),
                          Column(
                            children: [
                              Text(pokedex[index]['name']),
                              Text(pokedex[index]['num']),Text(pokedex[index]['type'][0]),
                              CachedNetworkImage(imageUrl: pokedex[index]['img']),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
                    : Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.0), // Add some space between the grid and the button
          ElevatedButton(
            onPressed: () {
              // Add the function you want to execute when the button is pressed
            },
            child: Text('Explore'),
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
