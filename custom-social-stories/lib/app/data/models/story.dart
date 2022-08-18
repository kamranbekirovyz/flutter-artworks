class Story {
  final String mediaUrl;

  final bool _isVideo;

  const Story.image({
    required this.mediaUrl,
  }) : _isVideo = false;

  const Story.video({
    required this.mediaUrl,
  }) : _isVideo = true;

  bool get isVideo => _isVideo;
}
