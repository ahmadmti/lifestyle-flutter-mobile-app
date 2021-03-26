import 'package:custom_tab/custom_tab.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';

import 'main.dart';

class shopping extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return shoppingState();
  }
}

class shoppingState extends State<shopping> {
  List<ShopingPojo> pojo = [];
  List<Brand> brands = [];
  var man = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSuvpWGcijPlOi4c3KIbq7hkiIu5x7kY9x9w&usqp=CAU";
  var woman = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQxnm1NuCwL1NR6r4TlDV-aEbMOfsSCBAZIw&usqp=CAU";
  var kid = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPsHbpiok68WdJ2hEE5XPRUOKWg9w6IiDktA&usqp=CAU";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    brands.add(Brand(
        wear: "assets/shopping_image/gucci_shopping.jpg", site: "https://www.gucci.com/ae/en_gb/", name: "Gucci"));
    brands.add(Brand(
        wear: "assets/shopping_image/georgio_armani_logo.png",
        site: "https://www.armani.com/wx/armanicom",
        name: "Armani"));
    brands.add(Brand(
        wear: "assets/shopping_image/splash_logo.png", site: "https://www.splashfashions.com/ae/en", name: "Splash"));
    brands.add(Brand(
        wear: "assets/shopping_image/max_logo.png", site: "https://www.maxfashion.com/ae/en", name: "Max Fashion"));
    brands.add(Brand(
        wear: "assets/shopping_image/american_eagle_outfit.jpg",
        site: "https://www.americaneagle.ae/en/",
        name: "American Eagle"));
    brands.add(Brand(wear: "assets/shopping_image/nike_logo.png", site: "https://www.nike.com/ae/", name: "Nike"));
    brands.add(Brand(
        wear: "assets/shopping_image/gucci_shopping.jpg", site: "https://www.gucci.com/ae/en_gb/", name: "Gucci"));
    brands.add(Brand(
        wear: "assets/shopping_image/georgio_armani_logo.png",
        site: "https://www.armani.com/wx/armanicom",
        name: "Armani"));
    brands.add(Brand(
        wear: "assets/shopping_image/splash_logo.png", site: "https://www.splashfashions.com/ae/en", name: "Splash"));
    brands.add(Brand(
        wear: "assets/shopping_image/max_logo.png", site: "https://www.maxfashion.com/ae/en", name: "Max Fashion"));
    brands.add(Brand(
        wear: "assets/shopping_image/american_eagle_outfit.jpg",
        site: "https://www.americaneagle.ae/en/",
        name: "American Eagle"));
    brands.add(Brand(wear: "assets/shopping_image/nike_logo.png", site: "https://www.nike.com/ae/", name: "Nike"));
    pojo.add(ShopingPojo(gender: "MEN", img: man, brands: brands)); //add
    pojo.add(ShopingPojo(gender: "WOMEN", img: woman, brands: brands)); //add
    pojo.add(ShopingPojo(gender: "KIDS", img: kid, brands: brands)); //add
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("Shopping"),
            ),
          ),
          body: CustomTab(
            3,
            (i) => new ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: new Stack(fit: StackFit.expand, children: [
                Image.network(
                  pojo[i].img,
                  fit: BoxFit.fill,
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: new Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        pojo[i].gender,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            background: Paint()..color = Colors.black.withAlpha(900000),
                            fontWeight: FontWeight.bold),
                      ),
                    ))
              ]),
            ),
            (context, i) => new GridView.builder(
                padding: EdgeInsets.all(5.0),
                itemCount: pojo[i].brands.length,
                // shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemBuilder: (context, j) => Column(
                      // borderRadius: BorderRadius.circular(10.0),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => launchBrowser(pojo[i].brands[j].site),
                          child: Container(
                            height: 140,
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: new Image.asset(
                                pojo[i].brands[j].wear,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(pojo[i].brands[j].name),
                      ],
                    )),
            indicatorColor: Colors.blue,
          )),
    );
  }

  launchBrowser(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class ShopingPojo {
  String gender, img;
  List<Brand> brands;

  ShopingPojo({this.gender, this.img, this.brands});
}

class Brand {
  String wear, site, name;

  Brand({this.wear, this.site, this.name});
}
