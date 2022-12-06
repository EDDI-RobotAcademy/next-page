class TmpNovelModel {
  int episode;
  String title;
  String content;
  double rating;
  String writer;
  String regDate;
  String category;
  String thumbnail;
  bool isLike;
  String introduction;

  TmpNovelModel(
      {this.episode = 0,
      this.title = '',
      this.content = '',
      this.rating = 0.0,
      this.writer = '',
      this.category = '',
      this.regDate = '',
      this.thumbnail = '',
      this.isLike = false,
      this.introduction = ''});

  static List<TmpNovelModel> novelList = <TmpNovelModel>[
    TmpNovelModel(
        episode: 1,
        title: '근육조선',
        content: """   본문 시작
      
      으ㅡ아ㅣㄹㅁㄴ어;ㅣ런ㅁㅇ
      ㅇㄹ
      ㄴㅁㅇ
      ㄹㅁㅇㄴ
      ㄹ
      
      
      ㅇㄹㅎㅁㄴ아ㅣ험ㄴㅇ;ㅣ러민;아
      
      ㅓㅏㅗㅎㅇ라ㅣㄴ;호아ㅣ로히ㅏ
      ㅇㄴ마ㅣㅓㅁㅇ노라ㅣ;ㅁㄴ어
      df
      d
      fa
      dsf
      ads
      fads
      f
      asdf
      asd
      fasd
      f
      asdf
      asd
      f
      adsf
      sadf
      ads
      f
      adsf
      sdaf
      adsf
      asdf
      sa
      fas
        
page
0jdhdshfasddsfsadfasdfadsfadsfadsfasdfasddsfasdfasdfads
dfafds
fsad
fsad
fsd

fd
fdfdf
df

dsf
sdf
sdf
dsf

dsafadsf
dsfadsfdsfdsafdsaf
sadfdsafdsfdsa

fdsfadsf
dsafdsfdsf

hfgdfgdfhdsfg
dsfgdfsgdfgdfsgdsfg
dfgdsfgdfsdsf



dsfsadfdsafdsa
d
fsadfadsfdsa
dsf
d
d
fds
f
dsf
dsf
sd

f
sd
f
sdf
f

ds
fsd
f
sf
sf
ds




본문 끝
                       """,
        rating: 9.7,
        writer: '차돌박E',
        regDate: '2022.12.01',
        category: '판타지',
        thumbnail: 'assets/images/thumbnail/tmpThumbnail1.png',
        isLike: true,
      introduction: '''
        
안타까운 역사라 한탄한 적도 있었다.
그러나 한탄은 사라지고 몸이 재산이라는 사실을 깨달았다. 그렇게 몸을 길러 나름 성공하였더니 이런 일이 일어나다니.
                            
\"설마 아니겠지. 내가 꿈을 꾸는 거겠지. 이게 대체 뭐야?\"
   
한때는 사학과를 나왔고, 피트니스 센터 코치로 일하는 내가 누군가의 몸에 들어왔다.
권력의 화신, 조카를 죽인 자. 그리고 왕위를 빼앗은 자.
수양대군의 몸으로
   
\"그러니까 세종대왕님이 운동하셔서 오래 사시면 끝나는 일 아닌가?\"
   
이제 조선은 변할 것이다.
다른 어떠한 것도 아닌 근육으로 시작되어.
모두 변할 것이다.'''

    ),
    TmpNovelModel(
      episode: 2,
      rating: 8.0,
    ),
    TmpNovelModel(
      episode: 3,
      rating: 9.1,
    ),
  ];
}
