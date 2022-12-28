package kr.eddi.demo.novel.request;


import lombok.Getter;
import lombok.RequiredArgsConstructor;


@Getter
@RequiredArgsConstructor
public class NovelInformationModifyRequest {

    private final String category;
    private final String title;
    private final String introduction;
    private final String publisher;
    private final String author;
    private final Boolean openToPublic;
    private final Long purchasePoint;


}
