import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/offer_response.dart';
import 'package:flutter_ecommerce/service/authorization.dart';
import 'package:flutter_ecommerce/utils.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OfferTab extends StatefulWidget {
  const OfferTab({Key? key}) : super(key: key);

  @override
  OfferTabState createState() => OfferTabState();
}

class OfferTabState extends State<OfferTab> with AutomaticKeepAliveClientMixin{
  bool isProgress = false,
      isMainViewVisible = false,
      isLoadMoreProgress = false,
      mIsLastPage = false;
  int offset = 0;
  OfferResponse? offerResponse;

  @override
  void initState() {
    showProgress();
    getOffersResponse();
    super.initState();
  }

  Future<void> _pullRefresh() async {
    print("Pull to refresh");
    offset = 0;
    getOffersResponse();
  }

  Future loadMore() async {
    print("loadMore");
    if (!mIsLastPage && !isLoadMoreProgress) {
      isLoadMoreProgress = true;
      setState(() {});
      getOffersResponse();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  Column(
                    children: [
                      Divider(
                        color: Colors.black26,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                          child: ListView.builder(
                            itemCount: offerResponse?.Data! == null
                                ? 0
                                : offerResponse?.Data!.length,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(12, 3, 12, 3),
                                child: Card(
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.width / 2.8,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6.0),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        offerResponse?.Data![i].image ?? '',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
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

  void getOffersResponse() async {
    OfferResponse? response = await RemoteService().getOffersData(10, offset);
    hideProgress();
    if (response != null) {
      print(response.toJson().toString());
      if (response.isSuccess) {
        if (offset == 0) {
          print("c0nd1");
          offerResponse = response;
          isMainViewVisible = true;
        } else if (response.Data!.isNotEmpty) {
          print("c0nd2");
          offerResponse?.Data?.addAll(response.Data!);
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

  @override
  bool get wantKeepAlive => true;
}
