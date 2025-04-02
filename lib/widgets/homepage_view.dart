import 'package:flutter/material.dart';
import 'package:sezin_scp/utils/page_paddings.dart';
import 'package:sezin_scp/widgets/custom_card_widget.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});
  // final _test = "kart tasarım ve içerik test";
  // final _test2 = "kart tasarım ve içerik test2";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: PagePaddings().homePadding,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text(_test),
                Expanded(
                    flex: 1,
                    child: CustomCardWidget(
                      onPressed: () {},
                      cardName: "Akademi",
                      imgAsset: "assets/academy.jpg",
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                // Text(_test2),
                Expanded(
                    flex: 1,
                    child: CustomCardWidget(
                      onPressed: () {},
                      cardName: "Demirbaş Takip",
                      imgAsset: "assets/inventory.png",
                    )),
              ], //expanded ile kullanım ve yatay dikey duruş kontrol ve test et yatay 2li yapıyı oturt
              // void dispose ovverride ekle bütün controller sayfalarına
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: CustomCardWidget(
                      onPressed: () {},
                      cardName: "Finans",
                      imgAsset: "assets/finance.jpg",
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Expanded(
                    flex: 1,
                    child: CustomCardWidget(
                      onPressed: () {},
                      cardName: "İhale",
                      imgAsset: "assets/auction.png",
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: CustomCardWidget(
                      onPressed: () {},
                      cardName: "İstatistik",
                      imgAsset: "assets/statistic.jpg",
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Expanded(
                    flex: 1,
                    child: CustomCardWidget(
                      onPressed: () {},
                      cardName: "İnsan Kaynakları",
                      imgAsset: "assets/humanres.jpg",
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: CustomCardWidget(
                      onPressed: () {},
                      cardName: "Muhasebe",
                      imgAsset: "assets/accounting.png",
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Expanded(
                    flex: 1,
                    child: CustomCardWidget(
                      onPressed: () {},
                      cardName: "Satın Alma",
                      imgAsset: "assets/purchase.png",
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: CustomCardWidget(
                      onPressed: () {},
                      cardName: "Teknik Servis",
                      imgAsset: "assets/technic.jpg",
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Expanded(
                    flex: 1,
                    child: CustomCardWidget(
                      onPressed: () {},
                      cardName: "Sezin",
                      imgAsset: "assets/logo.jpg",
                    )),
              ],
            ),
            // Expanded(
            //   flex: 2,
            //   child: Row(
            //     children: [
            //       Expanded(child: CustomCardWidget(onPressed: (){},cardName: "denemeeee" * 15, imgAsset: "assets/academy.jpg",)),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
