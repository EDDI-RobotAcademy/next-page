import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_theme.dart';
import '../../utility/providers/episode_provider.dart';
import '../../widgets/custom_title_appbar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../forms/episode_modify_form.dart';

class EpisodeModifyScreen extends StatefulWidget {
  final dynamic episode;

  const EpisodeModifyScreen({Key? key, required this.episode})
      : super(key: key);

  @override
  State<EpisodeModifyScreen> createState() => _EpisodeModifyScreenState();
}

class _EpisodeModifyScreenState extends State<EpisodeModifyScreen> {
  EpisodeProvider? _episodeProvider;

  @override
  void initState() {
    _episodeProvider = Provider.of<EpisodeProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: customTitleAppbar(context, '에피소드 수정', 99),
        body: Stack(children: [
          EpisodeModifyForm(episode: widget.episode),
          SlidingUpPanel(
              backdropEnabled: true,
              collapsed: Container(
                color: AppTheme.viewerAppbar,
                child: Center(
                    child: Text(
                  '등록된 현재 에피소드의 내용입니다.',
                  style: TextStyle(fontSize: _size.width * 0.04),
                )),
              ),
              panel: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: _size.height * 0.01,
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
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
                        '${widget.episode['episodeNumber']}화 본문',
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
                      widget.episode['episodeTitle'],
                      style: TextStyle(
                          fontSize: _size.width * 0.05,
                          fontWeight: FontWeight.w500),
                    )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(_size.width * 0.05,
                          _size.width * 0.05, _size.width * 0.05, 0),
                      child: Text(
                        widget.episode['text'],
                        style: TextStyle(fontSize: _size.width * 0.04),
                      ),
                    )
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
