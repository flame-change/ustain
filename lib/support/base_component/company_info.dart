import 'package:aroundus_app/modules/mypage/external_link/external_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter_svg/svg.dart';

class CompanyInfo extends StatefulWidget {
  @override
  State<CompanyInfo> createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        color: Colors.black,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Wrap(children: [
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ExternalLink(
                              url:
                                  'https://rhinestone-gladiolus-89e.notion.site/b1425602b3864b129181151c266944a9/'))),
                  child: Text('이용 약관',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
              Text('     ', style: TextStyle(color: Colors.white)),
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ExternalLink(
                              url:
                                  'https://rhinestone-gladiolus-89e.notion.site/5a3f67e9cc7b4db7acf216a07b3559db/'))),
                  child: Text('개인정보 처리방침',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)))
            ]),
            GestureDetector(
                onTap: () => setState(() => isOpened = !isOpened),
                child: Wrap(children: [
                  Text('사업자 정보', style: TextStyle(color: Colors.white)),
                  Icon(
                    isOpened == true
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: Colors.white,
                    size: Adaptive.dp(13),
                  )
                ]))
          ]),
          if (isOpened == true)
            Column(children: [
              SizedBox(height: Adaptive.h(3)),
              RichText(
                  text: TextSpan(
                      style: TextStyle(color: Colors.white, height: 1.5),
                      children: [
                    TextSpan(text: '어라운드어스  대표 : 노종혁\n'),
                    TextSpan(text: '사업자등록번호: 211-36-08033 '),
                    WidgetSpan(
                        child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ExternalLink(
                                        url:
                                            'http://www.ftc.go.kr/bizCommPop.do?wrkr_no=2113608033/'))),
                            child: Text('정보 확인',
                                style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline)))),
                    TextSpan(text: '\n사업장 소재지: 서울시 마포구 성지길 25-11 지층 5호\n'),
                    // TextSpan(text: '통신판매업: 아직 안바꿔씀\n'),
                    TextSpan(text: '개인정보 관리 책임자: 김은지\n\n'),
                    TextSpan(
                        text:
                            '어라운드어스는 통신판매 중개자로서 통신 판매의 당사자가 아니므로 개별 판매자가 등록한 상품 정보에 대해서 책임을 지지 않습니다.',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.grey, fontSize: Adaptive.dp(10)))
                  ]))
            ]),
          SizedBox(height: Adaptive.h(3))
        ]));
  }
}
