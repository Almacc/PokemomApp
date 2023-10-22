import 'package:flutter/material.dart';


class PokemonDetail extends StatefulWidget {
  final pokemonDetail;
  final Color color;
  final int pokeTag;

  const PokemonDetail({super.key, this.pokemonDetail, required this.color, required this.pokeTag});



  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: widget.color,
      body: Stack(
         children: [
           Positioned(
             bottom: 0,
           child :Container(
              width: width,
             height: height *0.6,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
               color: Colors.white,
             ),
           ),
           ),],
      ),
    );
  }
}
