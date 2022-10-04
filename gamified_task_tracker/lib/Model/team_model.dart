class Team {
  String id;
  final String name;
  final List members;
  final String admin;
  final int points;
  final List tasks;

  Team(
      {this.id = '',
      required this.name,
      required this.members,
      required this.admin,
      this.points = 0,
      required this.tasks});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'members': members,
        'admin': admin,
        'points': points,
        'tasks': tasks
      };
}

class Player {
  String id;
  final List teams;
  final int points;

  Player({required this.id, required this.teams, required this.points});

  Map<String, dynamic> toJson() => {
        'id': id,
        'teams': teams,
        'points': points,
      };
}

class Task {
  String id;
  final String name;
  final String description;
  final int value;
  final bool complete;
  final String teamid;
  final String userid;

  Task(
      {required this.id,
      required this.name,
      required this.description,
      required this.value,
      required this.complete,
      required this.teamid,
      required this.userid});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'value': value,
        'complete': complete,
        'teamid': teamid,
        'userid': userid
      };
}
