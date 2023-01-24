package kr.eddi.demo.favorite.service;

import kr.eddi.demo.favorite.request.FavoriteRequest;

import java.util.List;

public interface FavoriteService {
    Boolean pushLike(FavoriteRequest pushLikeRequest);

    Boolean getLikeStatus(FavoriteRequest likeStatusRequest);

    List<Long> getLikeNovelIdList(Long memberId);
}

