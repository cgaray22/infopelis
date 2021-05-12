class Credits {

  List<ActorCredits> items = new List();

  Credits();

  Credits.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList  ) {
      final pelicula = new ActorCredits.fromJsonMap(item);
      items.add( pelicula );
    }

  }

}
class ActorCredits {
  int id;
  bool video;
  int voteCount;
  double voteAverage;
  String title;
  String releaseDate;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String posterPath;
  double popularity;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  ActorCredits({
    this.id,
    this.video,
    this.voteCount,
    this.voteAverage,
    this.title,
    this.releaseDate,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.posterPath,
    this.popularity,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  ActorCredits.fromJsonMap( Map<String, dynamic> json ) {

    voteCount        = json['vote_count'];
    id               = json['id'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;
    title            = json['title'];
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalTitle    = json['original_title'];
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    adult            = json['adult'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];


  }
  
  getPosterImg(){

    if(posterPath == null){
      return 'https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg';
    }

  
    return 'https://image.tmdb.org/t/p/w500/$posterPath';

  }

  getBackGroundImg(){

    if(posterPath == null){
      return 'https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg';
    }

  
    return 'https://image.tmdb.org/t/p/w500/$backdropPath';

  }
}