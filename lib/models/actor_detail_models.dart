class Detail {

  List<ActorDetail> items = new List();

  Detail();

  Detail.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final detalle = new ActorDetail.fromJsonMap(item);
      items.add( detalle );
    }

  }

}

class ActorDetail {
  bool adult;
  List<String> alsoKnownAs;
  String biography;
  String birthday;
  dynamic deathday;
  int gender;
  dynamic homepage;
  int id;
  String imdbId;
  String knownForDepartment;
  String name;
  String placeOfBirth;
  double popularity;
  String profilePath;

  ActorDetail({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  ActorDetail.fromJsonMap( Map<String, dynamic> json ) {
    alsoKnownAs           = json['also_known_as'];
    biography             = json['biography'];
    birthday              = json['birthday'];
    deathday              = json['deathday'];
    popularity            = json['popularity'] / 1;
    profilePath           = json['profile_path'];
    gender                = json['gender'];
    homepage              = json['homepage'];
    id                    = json['id'];
    imdbId                = json['imdb_id'];
    knownForDepartment    = json['known_for_department'];
    name                  = json['name'];
    placeOfBirth          = json['place_of_birth'];
  }
}