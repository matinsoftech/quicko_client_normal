import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  static const String phoneNum = "+9779806533330";
  static const String email = "quickonepal@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/1.png",
                      height: 100,
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          customSupportWidget(
                            title: "Call Us",
                            iconData: Icons.phone_forwarded,
                            color: Colors.orange,
                            onTap: () async {
                              try {
                                launch("tel:$phoneNum");
                              } catch (e) {
                                throw "cannot launch";
                              }
                            },
                          ),
                          customSupportWidget(
                            title: "Email Us",
                            iconData: Icons.email,
                            color: Colors.blue,
                            onTap: () {
                              sendEmail(context,
                                  emailTo: email,
                                  subject: "Quicko Support",
                                  body: "");
                            },
                          ),
                          customSupportWidget(
                            title: "WhatsApp",
                            iconData: Icons.message,
                            color: Colors.green,
                            onTap: () {
                              _launchWhatsapp();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customSupportTile(
                      title: "Mobile",
                      value: phoneNum,
                    ),
                    customSupportTile(
                      title: "Mail",
                      value: email,
                    ),
                    customSupportTile(
                      title: "WhatsApp",
                      value: phoneNum,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  customSupportWidget(
      {@required String title,
        @required IconData iconData,
        @required Color color,
        @required var onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 105,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(3, 3),
              color: Colors.grey.shade300,
            )
          ],
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              padding: const EdgeInsets.all(10),
              child: Icon(
                iconData,
                color: color,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  sendEmail(
      BuildContext context, {
        @required String emailTo,
        @required String subject,
        @required String body,
      }) async {
    String mail = "mailto:$emailTo?subject=$subject&body=$body";
    try {
      await launch(mail);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  _launchWhatsapp() async {
    try {
      var whatsapp = "+9779806533330";
      var whatsappAndroid = "https://wa.me/$whatsapp?text=";
      await launch(whatsappAndroid);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  customSupportTile({
    @required String title,
    @required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.blue, fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          color: AppColor.primaryColor,
        )
      ],
    );
  }
}
