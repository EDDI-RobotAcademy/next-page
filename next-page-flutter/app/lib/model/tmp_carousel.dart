class TmpCarousel {
  int id;
  String path;

  TmpCarousel({
    this.id = 0,
    this.path = '',
  });

  static List<TmpCarousel> carouselList = <TmpCarousel>[
    TmpCarousel(id: 1, path: 'assets/images/carousel/action.png'),
    TmpCarousel(id: 2, path: 'assets/images/carousel/level.png'),
    TmpCarousel(id: 3, path: 'assets/images/carousel/change.png'),
    TmpCarousel(id: 4, path: 'assets/images/carousel/book.png'),
    TmpCarousel(id: 5, path: 'assets/images/carousel/crazy.png'),


  ];
}
