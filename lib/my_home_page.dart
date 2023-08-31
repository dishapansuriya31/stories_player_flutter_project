import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stories_player/detail_audio_page.dart';
import 'app_colors.dart' as AppColors;
import 'my_tabs.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late List popularstories;
  late List stories;
  late List trending;
  late ScrollController _scrollController;
  late TabController _tabController;
  late List audio;




  
  ReadData() async {
  await DefaultAssetBundle.of(context).loadString("json/popularstories.json").then((s){
     setState(() {
      popularstories = json.decode(s);
     });
   });
  await DefaultAssetBundle.of(context).loadString("json/stories.json").then((s){
    setState(() {
      stories = json.decode(s);
    });
  });
  await DefaultAssetBundle.of(context).loadString("json/treding.json").then((s){
    setState(() {
      trending = json.decode(s);
    });
  });

 }
  @override
 void initState(){
   super.initState();
   _tabController = TabController(length: 3, vsync: this);
   _scrollController = ScrollController();
   ReadData();
 }
  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColors.background,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.menu),
                        Row (
                          children: [
                            Icon(Icons.search),
                            SizedBox(width: 10,),
                            Icon(Icons.notifications)
                          ],
                        )
                      ],

                    ),
                ),
                 SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: const Text("popularstories" , style:TextStyle(fontSize: 30),),

                      )
                    ],
                  ),
                SizedBox(height: 20,),
                Container(
                  height: 180,
                  child: Stack(
                    children: [
                  Positioned(
                    top:0,
                    right: -20,
                    left: 0,
                  child: Container(
                  height: 180,
                    child: PageView.builder(
                        controller: PageController(viewportFraction: 0.8),
                        itemCount: popularstories==null?0:popularstories.length,
                        itemBuilder: (_, i){
                          return Container(
                            height: 180,
                            width: MediaQuery.of(context).size.width,
                           margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(popularstories[i]["img"]),
                                  fit:BoxFit.fill,
                                )
                            ),
                          );
                        }),
                  )
                  )
                    ],
                  )
                ),
                Expanded(child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool isScroll){

                    return[
                      SliverAppBar(
                        pinned: true,
                          backgroundColor: Colors.white,
                          bottom: PreferredSize(
                          preferredSize: Size.fromHeight(50),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20, left: 10),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10) ,
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 7,
                                    offset: Offset(0, 0),
                                  )
                                ]
                              ),
                              tabs: [
                              AppTabs(color:AppColors.manuColor, text:"Home"),
                              AppTabs(color:AppColors.manu2Color, text:"Popular"),
                              AppTabs(color:AppColors.manu3Color, text:"Trending"),
                              ],
                            ),
                          ),
                        )
                      )
                    ];
                  },
                  body:  TabBarView(
                    controller: _tabController,
                    children: [
                    ListView.builder(
                        itemCount: stories==null?0:stories.length,
                        itemBuilder: (_,i){
                      return
                      GestureDetector(
                        onTap: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>DetailAudioPage(storiesData: stories, index:i)
                        )
                        );
                        },
                        child:
                          Container(
                            margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.tabVarViewColor,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: Offset(0,0),
                                      color: Colors.grey.withOpacity(0.2),
                                    )
                                  ]
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(stories[i]["img"]),
                                          )

                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.star, size: 24, color: AppColors.starColor),
                                            const SizedBox(width: 5,),
                                            Text(stories[i]["rating"], style: TextStyle(
                                                color:AppColors.manu2Color
                                            ),),
                                          ],
                                        ),
                                        Text(stories[i]["title"],style: TextStyle(fontSize: 16, fontFamily: "Avenir", fontWeight: FontWeight.bold ),),
                                        Text(stories[i]["text"],style: TextStyle(fontSize: 16, fontFamily: "Avenir", color: AppColors.subTitleText),),


                                        Container(
                                          width: 60,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3),
                                            color: AppColors.loveColor,
                                          ),
                                          child: Text("Love",style: TextStyle(fontSize: 12, fontFamily: "Avenir", color: Colors.white),),
                                          alignment: Alignment.center,
                                        )

                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                      );

                    }),
                      ListView.builder(
                          itemCount: popularstories==null?0:popularstories.length,
                          itemBuilder: (_,i){
                            return Container(
                              margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.tabVarViewColor,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: Offset(0,0),
                                        color: Colors.grey.withOpacity(0.2),
                                      )
                                    ]
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(popularstories[i]["img"]),
                                            )

                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star, size: 24, color: AppColors.starColor),
                                              const SizedBox(width: 5,),
                                              Text(popularstories[i]["rating"], style: TextStyle(
                                                  color:AppColors.manu2Color
                                              ),),
                                            ],
                                          ),
                                          Text(popularstories[i]["title"],style: TextStyle(fontSize: 16, fontFamily: "Avenir", fontWeight: FontWeight.bold ),),
                                          Text(popularstories[i]["text"],style: TextStyle(fontSize: 16, fontFamily: "Avenir", color: AppColors.subTitleText),),
                                          Container(
                                            width: 60,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(3),
                                              color: AppColors.loveColor,
                                            ),
                                            child: Text("Love",style: TextStyle(fontSize: 12, fontFamily: "Avenir", color: Colors.white),),
                                            alignment: Alignment.center,
                                          )

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                      ListView.builder(
                          itemCount: trending==null?0:trending.length,
                          itemBuilder: (_,i){
                            return Container(
                              margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.tabVarViewColor,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 2,
                                        offset: Offset(0,0),
                                        color: Colors.grey.withOpacity(0.2),
                                      )
                                    ]
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 120,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(trending[i]["img"]),
                                            )

                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.star, size: 24, color: AppColors.starColor),
                                              const SizedBox(width: 5,),
                                              Text(trending[i]["rating"], style: TextStyle(
                                                  color:AppColors.manu2Color
                                              ),),
                                            ],
                                          ),
                                          Text(trending[i]["title"],style: TextStyle(fontSize: 16, fontFamily: "Avenir", fontWeight: FontWeight.bold ),),
                                          Text(trending[i]["text"],style: TextStyle(fontSize: 16, fontFamily: "Avenir", color: AppColors.subTitleText),),


                                          Container(
                                            width: 60,
                                            height: 15,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(3),
                                              color: AppColors.loveColor,
                                            ),
                                            child: Text("Love",style: TextStyle(fontSize: 12, fontFamily: "Avenir", color: Colors.white),),
                                            alignment: Alignment.center,
                                          )

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                  ],
                ),

                ))
              ],
            )
          ),
        ),

    );
  }
}


