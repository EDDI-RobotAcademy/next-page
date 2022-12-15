package kr.eddi.demo.novel.form;


import kr.eddi.demo.novel.request.NovelInformationRequest;
import lombok.Data;

@Data
public class NovelInformationForm {

    private Long member_id;
    private String category;
    private String title;
    private String introduction;
    private String publisher;
    private String author;
    private Boolean openToPublic;
    private Long purchasePoint;

    public NovelInformationRequest toRequest() {
        return new NovelInformationRequest(member_id, category, title, introduction, publisher, author, openToPublic, purchasePoint);
    }

}
