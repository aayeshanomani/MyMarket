import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Services', 
                  style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Noto_Serif',
                    fontWeight: FontWeight.bold,
                    color: Color(0xff654236)
                  )),
              ),
            ),
          ),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 4.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: Ink.image(
                          image: AssetImage('assets/image/gro.png'),
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                          child: InkWell(
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                    Text('Graocery',
                        style: TextStyle(
                            color: Color(0xffDB995A),fontSize: 12, fontFamily: 'Noto_Serif')),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 4.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: Ink.image(
                          image: AssetImage('assets/image/sta.png'),
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                          child: InkWell(
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                    Text('Stationery',
                        style: TextStyle(
                            color: Color(0xffDB995A),fontSize: 12, fontFamily: 'Noto_Serif')),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 4.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: Ink.image(
                          image: AssetImage('assets/image/lap.png'),
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                          child: InkWell(
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                    Text('Electronic',
                        style: TextStyle(
                            color: Color(0xffDB995A),fontSize: 12, fontFamily: 'Noto_Serif')),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 4.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: Ink.image(
                          image: AssetImage('assets/image/res.png'),
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                          child: InkWell(
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                    Text('Restaurant',
                        style: TextStyle(
                            color: Color(0xffDB995A),fontSize: 12, fontFamily: 'Noto_Serif')),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 4.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: Ink.image(
                          image: AssetImage('assets/image/bea.png'),
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                          child: InkWell(
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                    Text('Beauty',
                        style: TextStyle(
                            color: Color(0xffDB995A),fontSize: 12, fontFamily: 'Noto_Serif')),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        elevation: 4.0,
                        shape: CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: Ink.image(
                          image: AssetImage('assets/image/ref.png'),
                          fit: BoxFit.cover,
                          width: 50.0,
                          height: 50.0,
                          child: InkWell(
                            onTap: () {},
                          ),
                        ),
                      ),
                    ),
                    Text('Refurbished',
                        style: TextStyle(
                            color: Color(0xffDB995A),fontSize: 12, fontFamily: 'Noto_Serif')),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                items: [
                  //1st Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://blog.cambly.com/wp-content/uploads/2017/02/advertising-word-block.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //2nd Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://previews.123rf.com/images/dizanna/dizanna1511/dizanna151100567/47606903-advertisement-word-cloud-business-concept.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //3rd Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://readingielts.b-cdn.net/wp-content/uploads/2021/04/IELTS-Speaking-Part-3-topic-Advertisement-1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //4th Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://thumbs.dreamstime.com/z/marketing-advertising-cloud-word-19099279.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //5th Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://media.gettyimages.com/vectors/brand-storytelling-vector-id1159807141?s=612x612"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],

                //Slider Container properties
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                    //print(_current);
                  },
                ),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (int i = 0; i < 5; i++)
              Icon(
                FontAwesomeIcons.dotCircle,
                color: i == _current ? Color(0xffF0F4EF) : Color(0xffBFCC94),
              )
          ]),
        ],
      )),
    );
  }
}
