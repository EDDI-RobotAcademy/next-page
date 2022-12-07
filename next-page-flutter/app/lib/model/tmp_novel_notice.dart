class TmpNovelNotice {
  String content;
  String title;
  String regDate;


  TmpNovelNotice(
      {
        this.content = '',
        this.title = '',
        this.regDate = '',
      });

  static List<TmpNovelNotice> noticeList = <TmpNovelNotice>[
    TmpNovelNotice(
      title: '(안내) 연재주기',
      content: '''
매주 월, 수, 금 0시에 연재됩니다. 
  ''',
      regDate: '2022.12.01',
    ),

    TmpNovelNotice(
      title: '(이벤트) ㄴㅇㄹㅁㄴㅇㄹㄴㅁㅇ',
      content: '''
(이벤트)
ㅁㅇㄴ러ㅏㅣㅗㅓㅁㅇㄴ;ㅣ러;ㅇㄴ미ㅏ럼인;ㅏㅓㄹ미ㅏㄴㅇ;ㅓㄹ;미ㅏㄴ얼;민얼
ㅎ로

ㄹㅎ

민;아ㅓ
  ''',
      regDate: '2022.12.02',
    ),
  ];
}
