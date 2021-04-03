import 'package:custom_tab/custom_tab.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lifestyle/userAccount.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lifestyle/mainHome.dart';
import 'package:lifestyle/settings.dart';

import 'home.dart';
import 'main.dart';

class shopping extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return shoppingState();
  }
}

class shoppingState extends State<shopping> {
  List<ShopingPojo> pojo = [];
  var man = "assets/Men.jpg";
  var woman = "assets/Women.jpg";
  var kid = "assets/Kids.jpg";
  Widget _child;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  List<Brand> brands = [];
    brands.add(Brand(
        wear: "assets/shopping_image/american_eagle_outfit.jpg",
        site: "https://www.americaneagle.ae/en/",
        name: "American Eagle"));
    brands.add(Brand(
        wear: "assets/shopping_image/georgio_armani_logo.png",
        site: "https://www.armani.com/wx/armanicom",
        name: "Armani"));
    brands.add(Brand(
        wear: "assets/shopping_image/max_logo.png", site: "https://www.maxfashion.com/ae/en", name: "Max Fashion"));
    brands.add(Brand(
        wear: "assets/shopping_image/splash_logo.png", site: "https://www.splashfashions.com/ae/en", name: "Splash"));
    brands
        .add(Brand(wear: "assets/Tommy_Hilfiger_logo.png", site: "https://usa.tommy.com/en/", name: "Tommy Hilfiger"));
    brands.add(Brand(wear: "assets/HM_logo.png", site: "https://www.hm.com/entrance.ahtml?orguri=%2F", name: "H&M"));
    pojo.add(ShopingPojo(gender: "MEN", img: man, brands: brands)); //add

   brands = [];
    brands.add(Brand(wear: "assets/Sephora_Logo.png", site: "https://www.sephora.com/", name: "Sephora"));
    brands.add(Brand(wear: "assets/MAC_logo.jpg", site: "https://www.maccosmetics.com/", name: "MAC"));
    brands.add(Brand(
        wear: "assets/daniel_wellington_logo.jpg",
        site:
            "https://www.danielwellington.com/global/?gclid=CjwKCAjwpKCDBhBPEiwAFgBzjyP4NKQ1MLKjKmRw0QR3SCOjMmb8PauIX0M2TZRPjikAaFVs5sOhQRoCyWoQAvD_BwE",
        name: "Daniel Wellington"));
    brands.add(Brand(
        wear: "assets/next_logo.jpg",
        site:
            "https://www.akgalleria.com/brands/all-brands/next.html?gclid=CjwKCAjwpKCDBhBPEiwAFgBzjwMgnqbergiknrAOEZ_XMtmi8f8PrpqOrzmIGLur4G4XGx4DcycdLRoCxOIQAvD_BwE",
        name: "Next"));
    brands.add(Brand(
        wear: "assets/Bloomingdales_Logo.png",
        site:
            "https://www.bloomingdales.com/?&cm_mmc=google-_-Brand+Terms+-+Main+-+targetroas-_-Brand+Terms+-+Bloomingdale%27s-_-s_bloomingdales_e_477308772914&gclid=CjwKCAjwpKCDBhBPEiwAFgBzj1rEpjYmfKyLbJD_huIf_ZbSZwZ3AWCT-5DN8KyaXPql1wXxhYex3hoCzcAQAvD_BwE",
        name: "Bloomingdales"));
    brands.add(Brand(
        wear: "assets/asos_logo.png",
        site:
            "https://www.asos.com/?channelref=paid+search&affid=12496&ppcadref=9834579591%7c105424652132%7ckwd-344023769643&gclid=CjwKCAjwpKCDBhBPEiwAFgBzjwz5bb2IVFWQVlYCNGgojvEU66717FBPb77k5Gg12UHLqyfMO2bk-hoCxtQQAvD_BwE&gclsrc=aw.ds",
        name: "ASOS"));
    pojo.add(ShopingPojo(gender: "WOMEN", img: woman, brands: brands)); //add

   brands = [];
    brands.add(Brand(wear: "assets/mothercare_logo.png", site: "https://www.mothercare.in/", name: "Mothercare"));
    brands.add(Brand(wear: "assets/firstcry_logo.jpg", site: "hhttps://www.firstcry.com/", name: "First Cry"));
    brands.add(Brand(wear: "assets/HM_logo.png", site: "https://www.hm.com/entrance.ahtml?orguri=%2F", name: "H&M"));
    brands.add(Brand(
        wear: "assets/nickis_logo.jpg",
        site:
            "https://www.nickis.com/en/?utm_source=google&utm_medium=cpc&utm_campaign=Brand_CC&utm_term=nickis&gclid=CjwKCAjwpKCDBhBPEiwAFgBzjzxUWEzCnikhr-ihdfMHHSAJzOlqVBCq8wJ9Bc6YMlTBE59qgulDShoCX00QAvD_BwE",
        name: "Nickis "));
    pojo.add(ShopingPojo(gender: "KIDS", img: kid, brands: brands)); //add
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shopping"),
        ),
        body: CustomTab(
          3,
          (i) => new ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: new Stack(fit: StackFit.expand, children: [
              Image.asset(
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
              itemBuilder: (context, j) {
                print("i:$i j:$j ");
                return Column(
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
                );
              }),
          indicatorColor: Colors.blue,
        ),
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(icon: Icons.settings, backgroundColor: Colors.blue, extras: {"label": "settings"}),
            FluidNavBarIcon(icon: Icons.home, backgroundColor: Colors.blue, extras: {"label": "home"}),
            FluidNavBarIcon(
                icon: Icons.supervised_user_circle_outlined, backgroundColor: Colors.blue, extras: {"label": "account"})
          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(iconUnselectedForegroundColor: Colors.white, barBackgroundColor: Colors.grey[200]),
          scaleFactor: 1.5,
          defaultIndex: 1,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = settings();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => mainHome(index: 0)), (Route<dynamic> route) => false);
          break;

        case 1:
          _child = Home();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => mainHome(index: 1)), (Route<dynamic> route) => false);
          break;

        case 2:
          _child = userAccount();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => mainHome(index: 2)), (Route<dynamic> route) => false);
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
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
