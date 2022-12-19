package kr.eddi.demo.novel.request;


import kr.eddi.demo.novel.entity.NovelEpisode;
import kr.eddi.demo.novel.entity.NovelInformation;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class NovelEpisodeRegisterRequest {
    private final Long information_id;
    private final Long episodeNumber;
    private final String episodeTitle;
    private final String text;
    private final Boolean needToBuy;

    public NovelEpisode toEntity(NovelInformation information) {
        return new NovelEpisode(episodeNumber, episodeTitle, text, needToBuy, information);
    }

}
