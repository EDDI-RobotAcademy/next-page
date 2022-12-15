package kr.eddi.demo.novel.request;


import kr.eddi.demo.novel.entity.NovelInformation;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class NovelInformationRequest {

    private final Long member_id;
    private final String category;
    private final String title;
    private final String introduction;
    private final String publisher;
    private final String author;
    private final Boolean openToPublic;
    private final Long purchasePoint;

    public NovelInformation toEntity() {
        return new NovelInformation(title, introduction, publisher, author, openToPublic, purchasePoint);
    }
}
