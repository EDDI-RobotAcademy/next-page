package kr.eddi.demo.comment.response;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@ToString

public class CommentAndEpisodeResponse {
    private Long commentNo;
    private String comment;
    private String nickName;
    private String regDate;
    private String novelTitle;
    private Long episodeNumber;
    private String episodeTitle;
}
