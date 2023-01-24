package kr.eddi.demo.favorite.request;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@ToString
@Getter
@RequiredArgsConstructor
public class FavoriteRequest {
    final Long memberId;
    final Long novelId;
}
