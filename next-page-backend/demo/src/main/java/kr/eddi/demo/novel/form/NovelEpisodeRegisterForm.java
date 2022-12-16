package kr.eddi.demo.novel.form;


import kr.eddi.demo.novel.request.NovelEpisodeRegisterRequest;
import lombok.Data;

@Data
public class NovelEpisodeRegisterForm {
    private Long information_id;
    private Long episodeNumber;
    private String episodeTitle;
    private String text;
    private Boolean needToBuy;

    public NovelEpisodeRegisterRequest toRequest() {
        return new NovelEpisodeRegisterRequest(information_id, episodeNumber, episodeTitle, text, needToBuy);
    }

}
