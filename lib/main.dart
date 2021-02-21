import 'dart:async';

import 'package:compasswithbloc/events/compass_event.dart';
import 'package:compasswithbloc/states/compass_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math'; // to calculate angles
import 'package:flutter_compass/flutter_compass.dart'; // this is mandatory package
import 'package:flutter/services.dart'; // to use device services we have to use this package
import 'blocs/compass_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(Compass());
  });
}

// class Compass extends StatefulWidget {
//   //vì hướng liên tục thay đổi, nên sử dụng stful widget để note và di chuyển compass theo
//   @override
//   _CompassState createState() => _CompassState();
// }
//
// class _CompassState extends State<Compass> {
//   double _direction;
//   Timer _timer;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     FlutterCompass.events.listen((double direction) {
//       // _timer = new Timer(const Duration(microseconds: 400), () {
//       //   setState(() {
//       //     _direction = direction;
//       //   });
//       // });
//       //
//       Future.delayed(const Duration(milliseconds: 100), () {
//
// // Here you can write your code
//
//         setState(() {
//           _direction = direction;
//         });
//
//       });
//       //
//       // setState(() {
//       //   _direction = direction;
//       // });
//     });
//
//     //print(_direction);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _timer.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: CompassRED(direction: _direction),
//     );
//   }
// }
//
// class CompassRED extends StatelessWidget {
//   final double _direction;
//   String get _readout => _direction.toStringAsFixed(0) + '°';
//
//   const CompassRED({Key key, @required double direction}): _direction = direction,
//         super(key:key);
//
//   @override
//   Widget build(BuildContext context) {
//     print(((_direction ?? 0) * (pi / 180) * -1));
//
//     String _readout = _direction != '' ? _direction.toStringAsFixed(0) + '°': 'Something went wrong';
//
//     print(_readout);
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Center(
//           child: Container(
//             color: Colors.black,
//             child: ListView(
//               shrinkWrap: true,
//               padding: const EdgeInsets.all(20.0),
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   color: Colors.black,
//                   child: Transform.rotate( // to get the angle deviation
//                     angle: ((_direction ?? 0) * (pi / 180) * -1),
//                     child: Image.asset('assets/compass_black.jpg'),
//                   ),
//                 ),
//
//                 Container(
//                   alignment: Alignment.center,
//                   child: Text(_readout, style: TextStyle(fontSize: 30, color: Colors.white),),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class Compass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider<CompassBloc>(
        create: (context) => CompassBloc(Success(0)),
        child: CompassRED(),
      ),
    );
  }
}
 class CompassRED extends StatefulWidget {
   @override
   _CompassREDState createState() => _CompassREDState();
 }

 class _CompassREDState extends State<CompassRED> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterCompass.events.listen((double direction) {
      BlocProvider.of<CompassBloc>(context).add(ChangeDirectionCompassEvent(direction));
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
   @override
   Widget build(BuildContext context) {
    final CompassBloc compassBloc = BlocProvider.of<CompassBloc>(context);
    //String get _readout => _direction.toStringAsFixed(0) + '°';
     return Scaffold(
       backgroundColor: Colors.black,
       body: SafeArea(
         child: Center(
           child: Container(
             color: Colors.black,
             child: ListView(
               shrinkWrap: true,
               padding: const EdgeInsets.all(20.0),
               children: [
                 Stack(
                   alignment: Alignment.center,
                   children: <Widget>[
                     Container(
                       color: Colors.black,
                       child: BlocBuilder<CompassBloc, CompassState>(
                         builder: (context, state) {
                           if (state is Success) {
                             return Transform.rotate( // to get the angle deviation
                               angle: ((state.direction ?? 0) * (pi / 180) * -1),
                               child: Image.asset('assets/compass_black.jpg'),
                             );
                           }
                         },
                       ),
                     ),
                     Container(
                       child: Image.asset(
                         'assets/red_direction.jpg',
                         width: 100.0,
                         height: 100.0,
                       ),
                     )
                   ],
                 ),

                 Container(
                   alignment: Alignment.center,
                   child: BlocBuilder<CompassBloc, CompassState>(
                     builder: (context, state) {
                       if (state is Success) {
                         return Text((state.direction.toStringAsFixed(0) != '360')? state.direction.toStringAsFixed(0) + '°' : "0" + '°', style: TextStyle(fontSize: 30, color: Colors.white),);
                       }
                     },
                   ),
                 ),

                 // Container(
                 //   alignment: Alignment.center,
                 //   child: Text(state.direction.toStringAsFixed(0) + '°', style: TextStyle(fontSize: 30, color: Colors.white),),
                 // ),
               ],
             ),
           ),
         ),
       ),
     );;
   }
 }






