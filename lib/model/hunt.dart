class Hunt {
  String word;
  bool isFound;

  Hunt({
    this.word,
    this.isFound = false,
  });

  Hunt.fromJson(Map<String, dynamic> json) {
    word = json['word'] as String;
    isFound = json['isFound'] as bool;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['word'] = word;
    data['isFound'] = isFound;
    return data;
  }
}
