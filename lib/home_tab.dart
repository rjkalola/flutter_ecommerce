import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ecommerce/model/dashboard_response.dart';
import 'package:flutter_ecommerce/model/product_info.dart';
import 'package:flutter_ecommerce/service/authorization.dart';
import 'package:flutter_ecommerce/utils.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  HomeTabState createState() => HomeTabState();
}

class HomeTabState extends State<HomeTab> {
  bool isProgress = false,
      isMainViewVisible = false,
      isLoadMoreProgress = false,
      mIsLastPage = false;
  int activePage = 0, offset = 0;
  List<ProductInfo> productsList = [];
  late PageController _pageController;
  DashboardResponse? dashboardResponse;

  @override
  void initState() {
    _pageController = PageController();
    showProgress();
    getDashboardResponse();
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

  Future loadMore() async {
    print("loadMore");

    if(!mIsLastPage && !isLoadMoreProgress){
      isLoadMoreProgress = true;
      setState(() {
      });
      getDashboardResponse();
    }


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
    final orientation = MediaQuery.of(context).orientation;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isProgress,
        child: Visibility(
          visible: isMainViewVisible,
          child: LazyLoadScrollView(
            onEndOfPage: () {
              loadMore();
              print("onEndOfPage");
            },
            child: RefreshIndicator(
              onRefresh: _pullRefresh,
              child: Stack(
                children: [
                  SingleChildScrollView(
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
                            width: MediaQuery.of(context).size.width,
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
                  Visibility(
                    visible: isLoadMoreProgress,
                    child: Positioned(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget setPagerList() => SizedBox(
        height: 160,
        width: MediaQuery.of(context).size.width,
        child: PageView.builder(
            itemCount: dashboardResponse?.sliders! == null
                ? 0
                : dashboardResponse?.sliders!.length,
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
                  dashboardResponse?.sliders![pagePosition].image ?? '',
                  fit: BoxFit.cover,
                ),
              );
            }),
      );

  Widget setPagerDotsList() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(dashboardResponse?.sliders!.length ?? 0,
          (index) {
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

  Widget setCategoryGridList() => Padding(
        padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: dashboardResponse?.categories! == null
              ? 0
              : dashboardResponse?.categories!.length,
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
                          dashboardResponse?.categories![index].image ?? '',
                          fit: BoxFit.scaleDown,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 0),
                    child:
                        Text(dashboardResponse?.categories![index].name ?? '',
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

  Widget setProductsList() => Padding(
        padding: const EdgeInsets.fromLTRB(12, 16, 12, 4),
        child: AlignedGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            itemCount: dashboardResponse?.products! == null
                ? 0
                : dashboardResponse?.products!.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: (MediaQuery.of(context).size.width / 2) * 1.20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Image.network(
                            dashboardResponse?.products![index].image ?? '',
                            fit: BoxFit.cover,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ),
                      Positioned(
                          left: MediaQuery.of(context).size.width / 2 - 50,
                          top: (MediaQuery.of(context).size.width / 2) * 1.20 -
                              18,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child:
                                  (dashboardResponse?.products![index].liked ??
                                          false)
                                      ? SvgPicture.asset(
                                          'assets/images/ic_like.svg',
                                          width: 20)
                                      : SvgPicture.asset(
                                          'assets/images/ic_un_like.svg',
                                          width: 20),
                            ),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Row(
                      children: [
                        RatingBar.builder(
                          ignoreGestures: true,
                          initialRating: double.parse(
                              dashboardResponse?.products![index].review ??
                                  '0'),
                          minRating: 0,
                          glow: false,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 16,
                          unratedColor: Color(0xfff6e6e3),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                              dashboardResponse?.products![index].review ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black45,
                                fontFamily: 'Poppins',
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                      child:
                          Text(dashboardResponse?.products![index].name ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              )),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                          "Rs.${dashboardResponse?.products![index].price}" '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: 'Poppins',
                          )),
                    ),
                  )
                ],
              );
            }),
      );

  void showProgress() {
    setState(() {
      isProgress = true;
    });
  }

  void hideProgress() {
    setState(() {
      isProgress = false;
    });
  }

  void getDashboardResponse() async {
    DashboardResponse? response = await RemoteService().getDashboardData(10, offset);
    hideProgress();
    if (response != null) {
      print(response.toJson().toString());
      if (response.isSuccess) {
        if (offset == 0) {
          print("c0nd1");
          dashboardResponse = response;
          isMainViewVisible = true;
        } else if (response.products!.isNotEmpty) {
          print("c0nd2");
          dashboardResponse?.products?.addAll(response.products!);
          isLoadMoreProgress = false;
        } else if (response.offset == 0) {
          print("c0nd3");
          isLoadMoreProgress = false;
        }
        offset = response.offset;
        mIsLastPage = (offset == 0);

        print(mIsLastPage);
        print(offset);

        setState(() {});
      } else {
        if (!mounted) return;
        Utils.handleUnauthorized(context, response.Message);
      }
    }
  }
}
