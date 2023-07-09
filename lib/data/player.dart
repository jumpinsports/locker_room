/// Model class for documents in the players collection
class Player {
  const Player({
    // required this.uid,
    required this.first,
    required this.last,
    required this.email,
    required this.teams,
  });

  // final String uid;
  final String first;
  final String last;
  final String email;
  final List teams;

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      // uid: map['uid'] as String,
      first: map['first'] as String,
      last: map['last'] as String,
      email: map['email'] as String,
      teams: map['teams'] as List,
    );
  }

  Map<String, dynamic> toMap() => {
    // 'uid': uid,
    'first': first,
    'last': last,
    'email': email,
    'teams': teams,
  };

  @override
  List<Object?> get props => [
    // uid,
    first,
    last,
    email,
    teams,
  ];
}