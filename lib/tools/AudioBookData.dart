class AudioBookData {
  final String day;
  final String rawWord;
  final String previousStory;
  final List sentences;
  AudioBookData({ this.day, this.rawWord, this.previousStory, this.sentences});

  factory AudioBookData.fromJSON(Map<String, dynamic> json) {
    return AudioBookData(
      day: json['day'],
      rawWord: json['raw_word'],
      previousStory: json['previous_story'],
      sentences: json['sentences']
    );
  }
}