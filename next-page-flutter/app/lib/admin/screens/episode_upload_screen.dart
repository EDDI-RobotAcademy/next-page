import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_theme.dart';
import '../../utility/providers/episode_provider.dart';
import '../../widgets/custom_title_appbar.dart';
import '../forms/episode_upload_form.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EpisodeUploadScreen extends StatefulWidget {
  final String title;
  final String thumbnail;
  final int novelId;

  const EpisodeUploadScreen(
      {Key? key, required this.title, required this.thumbnail, required this.novelId})
      : super(key: key);

  @override
  State<EpisodeUploadScreen> createState() => _EpisodeUploadScreenState();
}

class _EpisodeUploadScreenState extends State<EpisodeUploadScreen> {
  EpisodeProvider? _episodeProvider;

  @override
  void initState() {
    _episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customTitleAppbar(context, '에피소드 등록'),
      body: Stack(children: [
        EpisodeUploadForm(
          novelId: widget.novelId,
          title: widget.title,
          thumbnail: widget.thumbnail,
        ),
        SlidingUpPanel(
            backdropEnabled: true,
            collapsed: Container(
              color: AppTheme.viewerAppbar,
              child: Center(
                  child: Text(
                '등록된 최신화의 내용입니다.',
                style: TextStyle(fontSize: _size.width * 0.04),
              )),
            ),
            panel: _episodeProvider!.latestEpisode != null
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: _size.height * 0.01,
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(9)
                            ),
                            child: Container(
                                height: _size.height * 0.008,
                                width: _size.width * 0.2,
                                color: Colors.grey[400]),
                          ),
                        ),
                        Center(
                            child: Padding(
                          padding: EdgeInsets.only(
                            top: _size.width * 0.05,
                          ),
                          child: Text(
                            '${_episodeProvider!.latestEpisode['episodeNumber']}화 본문',
                            style: TextStyle(
                                fontSize: _size.width * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                        SizedBox(
                          height: _size.height * 0.01,
                        ),
                        Center(
                            child: Text(
                          _episodeProvider!.latestEpisode['episodeTitle'],
                          style: TextStyle(
                              fontSize: _size.width * 0.05,
                              fontWeight: FontWeight.w500),
                        )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(_size.width * 0.05,
                              _size.width * 0.05, _size.width * 0.05, 0),
                          child: Text(
                            _episodeProvider!.latestEpisode['text'],
                            style: TextStyle(fontSize: _size.width * 0.04),
                          ),
                        )
                      ],
                    ),
                  )
                : Column(
                  children: [
                    SizedBox(
                      height: _size.height * 0.01,
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(9)
                        ),
                        child: Container(
                            height: _size.height * 0.008,
                            width: _size.width * 0.2,
                            color: Colors.grey[400]),
                      ),
                    ),
                    SizedBox(height: _size.height * 0.23,),
                    Center(
                        child: Text('등록된 에피소드가 없습니다.'),
                      ),
                  ],
                ))
      ]),
    );
  }
}
