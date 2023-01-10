class NovelRequest {
  int page;
  int size;
  int memberId;

  NovelRequest(this.page, this.size, this.memberId);
}

class EpisodeRequest {
  int page;
  int size;
  int novelId;

  EpisodeRequest(this.page, this.size, this.novelId);
}

class PurchasedEpisodeRequest{
  int memberId;
  int novelId;

  PurchasedEpisodeRequest(this.novelId, this.memberId);
}