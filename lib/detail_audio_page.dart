import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart' as AppColors;
import 'audio_file.dart';


class DetailAudioPage extends StatefulWidget {
  final storiesData;
  final int index;
  const DetailAudioPage({Key? key, this.storiesData, required this.index}) : super(key: key);

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
 late AudioPlayer advancedPlayer;
  @override
 void initState(){
   super.initState();
   advancedPlayer= AudioPlayer();
 }
  @override
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;

    return  Scaffold(
      backgroundColor: AppColors.audioGreyBackground,
      body: Stack(
          children: [
            Positioned(
              top:0,
              left: 0,
              right: 0,
              height: screenheight/5,

              child: Container(
                color: AppColors.audioBlueBackground,

              )
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AppBar(
                  leading: IconButton(
                     icon: Icon(Icons.arrow_back_ios,),
                     onPressed: ()=>Navigator.of(context).pop(),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.search,), onPressed: () {  },
                    ),
                  ],
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
            ),
            Positioned(
                left: 0,
                right: 0,
                top: screenheight*0.2,
                height: screenheight*0.36,
                child: Container(

                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  ),
                  child: Column(

                    children: [
                      SizedBox(height: screenheight*0.1,),
                      Text(this.widget.storiesData[this.widget.index]["title"],
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: "Avenir"
                      ),),
                      Text(this.widget.storiesData[this.widget.index]["text"],style: TextStyle(
                        fontSize: 20,
                      ), ),
                      AudioFile(advancedPlayer:advancedPlayer, audiopath: this.widget.storiesData[this.widget.index]["audio"],),

                    ],
                  ),
                )),
            Positioned(
                top: screenheight*0.12,
                left: (screenwidth-150)/2,
                right: (screenwidth-150)/2,
                height: screenheight*0.16,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2),
                    color:AppColors.audioGreyBackground ,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(

                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                          image: AssetImage(this.widget.storiesData[this.widget.index]["img"],),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                  ),
            ))

          ],
      ),
    );
  }
}
