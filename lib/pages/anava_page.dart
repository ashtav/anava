part of 'pages.dart';

class AnavaPage extends StatefulWidget {
  @override
  _AnavaPageState createState() => _AnavaPageState();
}

class _AnavaPageState extends State<AnavaPage> {

  Timer timer;

  double percent = 0;
  bool isDownload = false, hasDownload = false;

  Future _download() async{
    isDownload = true;

    timer = Timer.periodic(Duration(milliseconds: 100), (v){
      setState(() {
        if(percent < 250){
          percent = percent + 5;
        }else{
          hasDownload = true;
        }
      });
    });
  }

  @override
  void initState() { 
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() { 
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                !hasDownload ? ZoomIn(
                  child: Opacity(
                    opacity: isDownload ? 1 - (percent / 250) : 1,
                    child: Container(
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageAsset+'anava.png')
                        )
                      ),
                    ),
                  ),
                ) : ZoomIn(
                  child: Container(height: 250, child: Center(
                    child: Icon(La.check_circle, size: 100, color: Colors.green),
                  ),),
                ),

                SizedBox(height: 25),

                ZoomIn(
                  child: Stack(
                    children: [
                      Container(
                        height: 5, width: 250,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(50)
                        ),
                      ),

                      AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        height: 5, width: percent,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50)
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),

                Text('Gak punya duit tapi mau pakai Anava\'s Secret? \nTap download untuk mendapatkan Anava\'s Secret', style: gfont, textAlign: TextAlign.center,),
                
                SizedBox(height: 25),

                SlideUp(
                  delay: 200,
                  child: SplashButton(
                    onTap: hasDownload ? null : () async{
                      await _download();
                    },
                    color: hasDownload ? Colors.black38 : Colors.blue[300],
                    radius: BorderRadius.circular(50),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: !isDownload ? [
                          Icon(La.download, size: 20, color: Colors.white), SizedBox(width: 7),
                          Text('Download Anava', style: gfont.copyWith(color: Colors.white)),
                        ] : [
                          Text((percent / 250 * 100).toInt().toString()+'%', style: gfont.copyWith(color: Colors.white)),SizedBox(width: 7),
                          Text(hasDownload ? 'Berhasil!' : 'Sedang Mendownload', style: gfont.copyWith(color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 25),

                Text('From Varash, dari Cinta untuk Melayani\n© 2020 - by Ashta | P.T. Galkasoft', style: gfont.copyWith(color: Colors.blueGrey), textAlign: TextAlign.center,)
              ],
            ),
          ),

          Positioned.fill(
            child: !hasDownload ? SizedBox.fromSize() : Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.all(15),
                child: SplashButton(
                  onTap: (){
                    setState(() {
                      isDownload = false;
                      hasDownload = false;
                      percent = 0;
                      timer.cancel();
                    });
                  },
                  color: Colors.blue[200],
                  padding: EdgeInsets.all(10), radius: BorderRadius.circular(50),
                  child: Icon(Icons.refresh, size: 20, color: Colors.white),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}