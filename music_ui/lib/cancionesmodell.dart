class cancion {
  final String titulo;
  final String imagen;
  final String audio;

  cancion({
    required this.titulo,
    required this.imagen,
    required this.audio,
  });
}

List<cancion> canciones = [
  cancion(
    titulo: 'MAGIG! - Rude(official video)',
    imagen: 'assets/rude.jpg',
    audio: 'rudede.mp3',
  ),
  cancion(
    titulo: 'Daddy Yankee - Con Calma )',
    imagen: "assets/daddy.jpg",
    audio: 'daddy.mp3',
  ),
  cancion(
    titulo: 'Bruno Mars Thats What ILike ',
    imagen: "assets/bruno.jpg",
    audio: 'brunomars.mp3',
  ),
  cancion(
    titulo: "BoyWithUke'Toxic'Open Mic",
    imagen: "assets/maxx.jpg",
    audio: 'boywith.mp3',
  ),
  cancion(
    titulo: ' Ozuna - DEPRIMIDA ',
    imagen: "assets/ozuna.png",
    audio: 'ozuna.mp3',
  ),
  cancion(
    titulo: 'BAD BUNNY - AMORFODA ',
    imagen: "assets/badbunny.jpg",
    audio: 'badbuny.mp3',
  ),
  cancion(
    titulo: 'the Walters--I LOVE YOU SO ',
    imagen: "assets/youso.jpg",
    audio: 'yousoo.mp3',
  ),
  cancion(
    titulo: 'KIDFLEX-Seguro Te Pierdo',
    imagen: "assets/seguro.jpg",
    audio: 'segur.mp3',
  ),
  cancion(
    titulo: 'Bad Bunny - Aguacero  ',
    imagen: "assets/agua.jpg",
    audio: 'aguacero.mp3',
  ),
];
