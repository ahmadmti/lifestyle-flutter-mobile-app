import 'package:flutter/material.dart';

var url =
    "We are making changes to our Terms of Service and Privacy Policy that relate to messaging between businesses and their customers on WhatsApp. We are also providing more information about how we collect, share, and use data Our commitment to your privacy isn’t changing. Your personal conversations are still protected by end-to-end encryption, which means no one outside of your chats, not even WhatsApp or Facebook, can read or listen to them. \n\nIt’s our responsibility to explain these updates clearly. Here are some things you should know:" +
        "\n\nEvery day, millions of people use WhatsApp to communicate with businesses, large and small. You can message businesses to ask questions, make purchases, and get information. It's your choice whether you chat with a business on WhatsApp, and you can block or remove them from your contact list. Bigger businesses, like an airline or retailer, might hear from thousands of customers at a time - asking for information on a flight, or trying to track their order. To make sure they can respond quickly, these businesses may use Facebook as a technology provider to manage some of the responses on their behalf. We will clearly label chats to make you aware when that happens.";

class PrivacyPolicy extends StatelessWidget {
  final title;
  const PrivacyPolicy(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(children: <Widget>[
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(url),
          ),
        ),
      ]),
    );
  }
}
