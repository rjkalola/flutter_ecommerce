import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OfferTab extends StatefulWidget {
  const OfferTab({Key? key}) : super(key: key);

  @override
  OfferTabState createState() => OfferTabState();
}

class OfferTabState extends State<OfferTab> {
  bool isProgress = false,
      isMainViewVisible = true,
      isLoadMoreProgress = false;

  Future<void> _pullRefresh() async {
    print("Pull to refresh");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Expanded(
                  child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, i) {
                      return SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width / 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://magasin.workpotency.com//storage//app//offers//offer.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
