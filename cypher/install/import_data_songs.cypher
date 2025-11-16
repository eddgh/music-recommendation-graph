// Executa a importação das músicas
CALL
  apoc.periodic.iterate(
    '
  LOAD CSV WITH HEADERS FROM "https://drive.google.com/uc?export=download&id=1kjCHTIVo8gmeqthARwG0c8fI-CqkmErM" AS row
  RETURN row
  LIMIT 5000

  ',
    '
  MERGE (s:Song {songId: row.track_id})
  SET s.name = row.name,
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
  ',
    {batchSize: 1000, parallel: false}
  )