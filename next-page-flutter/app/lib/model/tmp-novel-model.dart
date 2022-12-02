class TmpNovelModel {
  int episode;
  String content;
  double rating;
  String writer;
  String regDate;
  String category;
  String thumbnail;

  TmpNovelModel(
      {this.episode = 0,
        this.content = '',
        this.rating = 0.0,
        this.writer = '',
        this.category = '',
        this.regDate = '',
        this.thumbnail = ''});

  static List<TmpNovelModel> episodeList = <TmpNovelModel>[
    TmpNovelModel(
        episode: 1,
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
        rating: 9.8,
        writer: '무명작가',
        regDate: '2022.12.01',
        thumbnail: ''
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
