class InviteData {
    int invited;
  final String code;

  InviteData(this.invited, this.code);

  InviteData.fromMap(Map<String, dynamic> data)
      : invited = data['invited'],
        code = data['code'];

  Map<String, dynamic> toMap() {
    return {
      'invited': invited,
      'code': code,
    };
  }

  void increment() {
    invited = invited + 1;
  }
}
