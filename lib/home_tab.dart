import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/model/product_info.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  bool isLoadingVertical = false;
  int activePage = 0;
  List<ProductInfo> productsList = [];
  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg"
  ];
  final List<String> items = <String>[
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
  ];
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  Future<void> _pullRefresh() async {
    print("Pull to refresh");
    // List<String> freshNumbers = await NumberGenerator().slowNumbers();
    setState(() {
      // numbersList = freshNumbers;
    });
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }

  Future _loadMoreVertical() async {
    setState(() {
      isLoadingVertical = true;
    });

    /* // Add in an artificial delay
    await new Future.delayed(const Duration(seconds: 2));

    productsList.addAll(
        List.generate(increment, (index) => verticalData.length + index));

    setState(() {
      isLoadingVertical = false;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery
        .of(context)
        .orientation;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: LazyLoadScrollView(
          onEndOfPage: () {},
          child: SingleChildScrollView(
              child: Column(
                children: [
                  Divider(
                    color: Colors.black26,
                  ),
                  setPagerList(),
                  setPagerDotsList(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Category",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text("More Category",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffFFBA49),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ))
                      ],
                    ),
                  ),
                  setCategoryGridList(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                    child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 220,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://magasin.workpotency.com//public//images//recommended.jpeg"),
                          ),
                        )),
                  ),
                  setProductsList()
                ],
              )),
        ),
      ),
    );
  }

  Widget setPagerList() =>
      SizedBox(
        height: 160,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: PageView.builder(
            itemCount: images.length,
            pageSnapping: true,
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                activePage = page;
                print(activePage.toString());
              });
            },
            itemBuilder: (context, pagePosition) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Image.network(
                  images[pagePosition],
                  fit: BoxFit.cover,
                ),
              );
            }),
      );

  Widget setPagerDotsList() =>
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(images.length, (index) {
            return Container(
              margin: EdgeInsets.all(3),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                  color:
                  activePage == index ? Color(0xffFFBA49) : Color(0xffFFE2DD),
                  shape: BoxShape.circle),
            );
          }));

  Widget setCategoryGridList() =>
      Padding(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: items.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GridTile(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white54,
                        child: SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              "https://cdn-icons-png.flaticon.com/512/24/24697.png",
                              fit: BoxFit.scaleDown,
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: Text("Mobile Accessories",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            )),
                      )
                    ],
                  ),
                ));
          },
        ),
      );

  Widget setProductsList() =>
      Padding(
          padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
          child: AlignedGridView.count(crossAxisCount: 4,
              mainAxisSpacing: 4,
              itemCount: 5,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 4, itemBuilder: (context, index) {
                return GridTile(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                      child: Column(
                        children: [
                          Card(
                            color: Colors.white54,
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(
                                  "https://cdn-icons-png.flaticon.com/512/24/24697.png",
                                  fit: BoxFit.scaleDown,
                                  height: 24,
                                  width: 24,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                            child: Text("Mobile Accessories",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                )),
                          )
                        ],
                      ),
                    ));
      })
  ,

  );
}
