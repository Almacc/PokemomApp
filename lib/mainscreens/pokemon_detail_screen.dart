import 'package:cached_network_image/cached_network_image.dart';
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
        alignment: Alignment.center,
         children: [
           Positioned(
             top: 40,
             left: 1,
             child: IconButton(onPressed: (){Navigator.pop(context);},
               icon: Icon(Icons.arrow_back, color: Colors.white, size: 30,),
             ),
           ),

           Positioned(
               top: 80,
               left: 5,
               child: Text(widget.pokemonDetail['name'],
                 style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),


               ),
           ),
           Positioned(
             top: 80,
             right: 10,
             child: Text(widget.pokemonDetail['num'],
               style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
             ),
           ),

           Positioned(
             top: 120,
             left: 5,
             child: Text(widget.pokemonDetail['type'].join(', '),
               style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),

             ),
           ),
           Positioned(
             bottom: 0,
           child :Container(
              width: width,
             height: height *0.6,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
               color: Colors.white,
             ),
             child: Padding(
               padding: const EdgeInsets.all(20.0),
               child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 SizedBox(height: 50,),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children:[
                     Container(
                       width: width * 0.3,
                       child: Text('Name', style: TextStyle(color: Colors.blueGrey, fontSize: 18),),
                     ),
                         Container(
                           width: width * 0.3,
                           child: Text(widget.pokemonDetail['name'],
                               style: TextStyle(
                                   color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold)),
                         ),
                   ]),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children:[
                         Container(
                           width: width * 0.3,
                           child: Text('height', style: TextStyle(color: Colors.blueGrey, fontSize: 18),),
                         ),
                         Container(
                           width: width * 0.3,
                           child: Text(widget.pokemonDetail['height'],
                               style: TextStyle(
                                   color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold)),
                         ),
                       ]),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children:[
                         Container(
                           width: width * 0.3,
                           child: Text('Weight', style: TextStyle(color: Colors.blueGrey, fontSize: 18),),
                         ),
                         Container(
                           width: width * 0.3,
                           child: Text(widget.pokemonDetail['weight'],
                               style: TextStyle(
                                   color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold)),
                         ),
                       ]),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children:[
                         Container(
                           width: width * 0.3,
                           child: Text('Spawn Time', style: TextStyle(color: Colors.blueGrey, fontSize: 18),),
                         ),
                         Container(
                           width: width * 0.3,
                           child: Text(widget.pokemonDetail['spawn_time'],
                               style: TextStyle(
                                   color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold)),
                         ),
                       ]),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children:[
                         Container(
                           width: width * 0.3,
                           child: Text('Weakness', style: TextStyle(color: Colors.blueGrey, fontSize: 18),),
                         ),
                         Container(
                           width: width * 0.3,
                           child: Text(widget.pokemonDetail['weaknesses'].join(", "),
                               style: TextStyle(
                                   color: Colors.black54, fontSize: 18, fontWeight: FontWeight.bold)),
                         ),
                       ]),
                 ),

               ],
             ),
           ),

           ),
           ),
           Positioned(
             top: height * 0.16,
             right: -20,
             child: Align(
               alignment: Alignment.center,
               child: ColorFiltered(
                 colorFilter: ColorFilter.mode(
                   Colors.white.withOpacity(0.5), // Adjust opacity to control transparency
                   BlendMode.srcIn,
                 ),
                 child: Image.asset(
                   'images/poke.png',
                   height: 300,
                   fit: BoxFit.fitHeight,
                 ),
               ),
             ),
           ),
           Positioned(
               top: height * 0.16,
               left: (width/2) - 100,
               child: CachedNetworkImage(
             imageUrl: widget.pokemonDetail['img'],
                 height: 200,
                 fit: BoxFit.fitHeight,
           ))

         ],
      ),
    );
  }
}
