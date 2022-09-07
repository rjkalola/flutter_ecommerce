import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/offer_response.dart';
import 'package:flutter_ecommerce/service/authorization.dart';
import 'package:flutter_ecommerce/utils.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'model/categories_response.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({Key? key}) : super(key: key);

  @override
  CategoriesTabState createState() => CategoriesTabState();
}

class CategoriesTabState extends State<CategoriesTab>
    with AutomaticKeepAliveClientMixin {
  bool isProgress = false, isMainViewVisible = false;
  CategoriesResponse? categoriesResponse;

  @override
  void initState() {
    showProgress();
    getCategoriesResponse();
    super.initState();
  }

  Future<void> _pullRefresh() async {
    print("Pull to refresh");
    getCategoriesResponse();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: isProgress,
          child: Visibility(
            visible: isMainViewVisible,
            child: RefreshIndicator(
              onRefresh: _pullRefresh,
              child: Column(
                children: [
                  Divider(
                    color: Colors.black26,
                  ),
                  if (categoriesResponse != null &&
                      categoriesResponse!.info!.isNotEmpty)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                        child: ListView.builder(
                          itemCount: categoriesResponse?.info! == null
                              ? 0
                              : categoriesResponse?.info!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 9, 16, 9),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        categoriesResponse?.info![index].name ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Colors.black26,
                                        size: 22.0,
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.black12,
                                ),
                                if (categoriesResponse != null &&
                                    categoriesResponse!.info != null &&
                                    categoriesResponse!.info![index].child !=
                                        null &&
                                    categoriesResponse!
                                        .info![index].child!.isNotEmpty)
                                  ListView.builder(
                                    // ignore: unnecessary_null_comparison
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: categoriesResponse!
                                            .info![index].child!.isEmpty
                                        ? 0
                                        : categoriesResponse!
                                            .info![index].child?.length,
                                    itemBuilder: (context, j) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                32, 9, 16, 9),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  categoriesResponse!
                                                      .info![index].child![j].name ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black45,
                                                    fontWeight: FontWeight.normal,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.keyboard_arrow_right,
                                                  color: Colors.black26,
                                                  size: 22.0,
                                                )
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.black12,
                                          )
                                        ],
                                      );
                                    },
                                  )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
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

  void getCategoriesResponse() async {
    CategoriesResponse? response = await RemoteService().getCategoriesData();
    hideProgress();
    if (response != null) {
      print(response.toJson().toString());
      if (response.isSuccess) {
        categoriesResponse = response;
        isMainViewVisible = true;
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
