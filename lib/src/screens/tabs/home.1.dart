import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/helpers/fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(vsync: this, length: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.95),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ItemCarousel(),
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "POPULAR STORES",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: Fonts.titilliumWebLight,
                            ),
                          ),
                          Text(
                            "VIEW ALL",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                              fontSize: 16.0,
                              fontFamily: Fonts.titilliumWebRegular,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TopBrands(),
                  ],
                ),
                CategoryList(tabController: tabController),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(getOffers()),
          ),
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key key,
    @required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "BEST OFFERS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16.0,
                  fontFamily: Fonts.titilliumWebLight,
                ),
              ),
              Text(
                "VIEW ALL",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                  fontSize: 16.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: TabBar(
            controller: tabController,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: Colors.red,
              ),
            ),
            indicatorColor: Colors.transparent,
            labelColor: Colors.red,
            labelPadding: EdgeInsets.all(10.0),
            labelStyle: TextStyle(color: Colors.red),
            unselectedLabelColor: Colors.lightBlue.withOpacity(0.5),
            isScrollable: true,
            tabs: getCategory(),
          ),
        )
      ],
    );
  }
}

List<Widget> getCategory() {
  List<Widget> data = [];

  for (var i = 0; i < 5; i++) {
    data.add(
      Container(
        decoration: BoxDecoration(),
        child: Text(
          "Electronics",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18.0,
            fontFamily: Fonts.titilliumWebRegular,
          ),
        ),
      ),
    );
  }

  return data;
}

List<Widget> getOffers() {
  List<Widget> data = [];

  for (var i = 0; i < 5; i++) {
    data.add(
      Card(
        elevation: 1.0,
        child: Container(
          child: ListTile(
            contentPadding: EdgeInsets.all(10.0),
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                "https://services.tegrazone.com/sites/default/files/app-icon/amazon-video_appicon2_0.png",
              ),
            ),
            title: Container(
              margin: EdgeInsets.only(bottom: 5.0),
              child: Text(
                "Amazon",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 16.0,
                  fontFamily: Fonts.titilliumWebRegular,
                ),
              ),
            ),
            subtitle: Text(
              "flat rs 200 cashback on flipkart using net banking / cards. tca",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 14.0,
                fontFamily: Fonts.titilliumWebRegular,
              ),
              softWrap: true,
            ),
          ),
        ),
      ),
    );
  }

  return data;
}

class TopBrands extends StatelessWidget {
  const TopBrands({
    Key key,
  }) : super(key: key);

  List<Widget> getBrands() {
    List<Widget> data = [];

    for (var i = 0; i < 5; i++) {
      data.add(
        Card(
          elevation: 1.0,
          margin: EdgeInsets.only(right: 5.0, bottom: 5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            margin: EdgeInsets.all(1.0),
            child: Image(
              image: NetworkImage(
                "http://pluspng.com/img-png/logo-flipkart-png-flipkart-591.png",
              ),
            ),
          ),
        ),
      );
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10.0),
      height: 70.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: getBrands(),
      ),
    );
  }
}

class ItemCarousel extends StatelessWidget {
  const ItemCarousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: Container(
        width: 360,
        height: 180,
        child: Carousel(
          dotSize: 5.0,
          dotSpacing: 15.0,
          dotColor: Colors.lightGreenAccent,
          dotBgColor: Colors.black87.withOpacity(0.5),
          boxFit: BoxFit.contain,
          images: [
            ExactAssetImage("assets/images/photo_eraser.png"),
            ExactAssetImage("assets/images/photo_pencil.png"),
            ExactAssetImage("assets/images/photo_ruler.png"),
          ],
        ),
      ),
    );
  }
}
