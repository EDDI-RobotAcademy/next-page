package kr.eddi.demo.novel.request;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class EpisodeModifyRequest {
    private final Long episodeNumber;
    private final String episodeTitle;
    private final String text;
    private final Boolean needToBuy;


}
