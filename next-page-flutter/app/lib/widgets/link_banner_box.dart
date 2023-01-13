import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkBannerBox extends StatefulWidget {
  const LinkBannerBox({Key? key}) : super(key: key);

  @override
  State<LinkBannerBox> createState() => _LinkBannerBoxState();
}

class _LinkBannerBoxState extends State<LinkBannerBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(9),
      child: Container(
        width: size.width * 0.91,
        height: size.height * 0.1,
        child: InkWell(
          onTap: () async{
            print('ddd');
            final url = Uri.parse('http://localhost:8080/');
            if(await canLaunchUrl(url)){
              launchUrl(url, mode: LaunchMode.inAppWebView);
            }
          },
          child: Image.asset('assets/images/banner/banner3.png',
            fit: BoxFit.fill,),
        ),
      ),
    );
  }
}
