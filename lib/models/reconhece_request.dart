class ReconheceRequest {
  final String video;

  ReconheceRequest(this.video);

  Map<String, dynamic> toJson() => {'video': video};
}
