part of 'pages.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  initialize() async{
    Timer(Duration(seconds: 3), (){
      Fn.navigate(context, AnavaPage());
    });
  }

  @override
  void initState() { 
    super.initState(); SystemChrome.setEnabledSystemUIOverlays([]);
    // initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageAsset+'varash.png')
                )
              ),
            ),

            Text('Welcome to Anava\'s App', style: gfont)
          ],
        ),
      ),
    );
  }
}