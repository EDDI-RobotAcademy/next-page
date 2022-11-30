import 'package:basic/home-screen.dart';
import 'package:flutter/material.dart';

class NovelReaderScreen extends StatefulWidget {
  const NovelReaderScreen({Key? key}) : super(key: key);

  @override
  State<NovelReaderScreen> createState() => _NovelReaderScreenState();
}

class _NovelReaderScreenState extends State<NovelReaderScreen> {

  double _cdx = 0;
  double _cdy = 0;

  double get cdx => _cdx;
  double get cdy => _cdy;

  @override
  void initState(){
    Future.microtask((){
      _cdx = MediaQuery.of(context).size.width/2;
      _cdy = MediaQuery.of(context).size.height/2;
    }).then((value) => setState((){
      print(_cdx);
      print(_cdy);
    }));
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE4E4E4),
        elevation: 0.0,
        title: Text("1화", style: TextStyle(
            color: Colors.black
        ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: (){
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                HomeScreen()), (Route<dynamic> route) => false);
          },
        ),

      ),
      body: GestureDetector(
        onTapDown: (TapDownDetails td){
          setState(() {
            this._cdx = td.globalPosition.dx;
            this._cdy = td.globalPosition.dy;
            print(_cdx);
            print(_cdy);
            print('-------');
          });
        },
        child: Container(
          child: PageView(
            children: [
              Container(
                child: Text(
                    'page 1'
                ),
              ),
              Container(
                child: Text(
                    'page 2'
                ),
              ),
              Container(
                child: Text(
                    'page 3'
                ),
              ),
              Container(
                child: Text(
                    'page 4'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
