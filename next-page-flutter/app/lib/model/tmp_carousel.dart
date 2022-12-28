class TmpCarousel {
  int id;
  String path;

  TmpCarousel({
    this.id = 0,
    this.path = '',
  });

  static List<TmpCarousel> carouselList = <TmpCarousel>[
    TmpCarousel(id: 1, path: 'assets/images/carousel/angel.png'),
    TmpCarousel(id: 2, path: 'assets/images/carousel/earth.png'),
    TmpCarousel(id: 3, path: 'assets/images/carousel/giant.png'),
    TmpCarousel(id: 4, path: 'assets/images/carousel/monalisa.png'),
  ];
}
