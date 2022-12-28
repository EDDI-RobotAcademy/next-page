package kr.eddi.demo.novel.form;

import kr.eddi.demo.novel.request.NovelInformationModifyRequest;
import kr.eddi.demo.novel.request.NovelInformationRegisterRequest;
import lombok.Data;


@Data
public class NovelInformationModifyForm {

    private String category;
    private String title;
    private String introduction;
    private String publisher;
    private String author;
    private Boolean openToPublic;
    private Long purchasePoint;


    public NovelInformationModifyRequest toRequest() {
        return new NovelInformationModifyRequest(category, title, introduction, publisher, author, openToPublic, purchasePoint);
    }


}
