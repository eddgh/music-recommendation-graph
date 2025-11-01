// 1. Executa a importação dos usuários (Person)
CALL apoc.periodic.iterate(
  '
  LOAD CSV WITH HEADERS FROM "https://drive.google.com/uc?export=download&id=1QRPPNE7gOsRfqB_WAChyllL6L_7zD-HO" AS row
  RETURN row
  ',
  '
  MERGE (p:Person {personId: toInteger(row.personId)})
    ON CREATE SET
        p.name = row.name,
        p.email = row.email,
        p.age = toInteger(row.age),
        p.gender = row.gender,
        p.country = row.country,
        p.city = row.city,
        p.language = row.language,
        p.subscriber = toBoolean(row.subscriber),
        p.signupDate = date(row.signup_date),
        p.listeningTime = row.listening_time,
        p.device = row.device;
  ',
  {batchSize: 1000, parallel: false}
);


// Eecuta a importação das músicas
CALL apoc.periodic.iterate(
  '
  LOAD CSV WITH HEADERS FROM "https://drive.google.com/uc?export=download&id=1vCKOeDZGjsmUCGGnzXQjEc9sUGK7RcLl" AS row
  RETURN row
  ',
  '
  MERGE (s:Song {songId: row.track_id})
  SET s.name = row.name,
      s.genre = row.genre,  // Armazena o gênero como propriedade
      s.spotifyPreviewUrl = row.spotify_preview_url,
      s.spotifyId = row.spotify_id,
      s.year = toInteger(row.year),
      s.durationMs = toInteger(row.duration_ms),
      s.danceability = toFloat(row.danceability),
      s.energy = toFloat(row.energy),
      s.key = toInteger(row.key),
      s.loudness = toFloat(row.loudness),
      s.mode = toInteger(row.mode),
      s.speechiness = toFloat(row.speechiness),
      s.acousticness = toFloat(row.acousticness),
      s.instrumentalness = toFloat(row.instrumentalness),
      s.liveness = toFloat(row.liveness),
      s.valence = toFloat(row.valence),
      s.tempo = toFloat(row.tempo),
      s.timeSignature = toInteger(row.time_signature)

  MERGE (a:Artist {name: row.artist})
  MERGE (s)-[:BY_ARTIST]->(a)

  WITH s, a, row
  WHERE row.genre IS NOT NULL AND TRIM(row.genre) <> ""
  MERGE (g:Genre {name: TRIM(row.genre)})
  MERGE (s)-[:HAS_GENRE]->(g)
  MERGE (a)-[:HAS_STYLE]->(g)

  WITH s, SPLIT(row.tags, ", ") AS tagList
  UNWIND tagList AS tagName
  WITH s, TRIM(tagName) AS tagName
  WHERE tagName IS NOT NULL AND tagName <> ""
  MERGE (t:Tag {name: tagName})
  MERGE (s)-[:TAGGED]->(t)
  ',
  {batchSize: 1000, parallel: false}
);

