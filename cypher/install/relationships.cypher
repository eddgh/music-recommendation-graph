// Faz os relacionamentos de pessoas com artistas e de pessoas com músicas

// Etapa 1: para cada usuário
MATCH (p:Person)
WITH p

// Etapa 2: filtra artistas com pelo menos 10 músicas
MATCH (a:Artist)<-[:BY_ARTIST]-(s:Song)
WITH p, a, count(s) AS totalMusicas
WHERE totalMusicas >= 10
WITH p, collect(DISTINCT a) AS artistasValidos

// Etapa 3: sorteia entre 10 e 20 artistas
WITH p, artistasValidos, toInteger(rand() * 11) + 10 AS qtdArtistas
WITH p, apoc.coll.randomItems(artistasValidos, qtdArtistas) AS artistasSorteados
UNWIND artistasSorteados AS artista
MERGE (p)-[:LIKES_ARTIST]->(artista) // Relaciona as pessoas com os artistas
WITH p, artistasSorteados

// Etapa 4: sorteia entre 5 e 15 artistas para curtir músicas
WITH p, artistasSorteados, toInteger(rand() * 11) + 5 AS qtdArtistasLikes
WITH p, apoc.coll.randomItems(artistasSorteados, qtdArtistasLikes) AS artistasParaLikes
UNWIND artistasParaLikes AS artistaLike

// Etapa 5: pega entre 1 e 5 músicas do artista que ainda não foram curtidas pelo usuário
MATCH (artistaLike)<-[:BY_ARTIST]-(s:Song)
WHERE NOT (p)-[:LIKED]->(s)
WITH p, artistaLike, collect(DISTINCT s) AS musicasPossiveis, toInteger(rand() * 5) + 1 AS qtdMusicas
WITH p, apoc.coll.randomItems(musicasPossiveis, qtdMusicas) AS musicasSorteadas
UNWIND musicasSorteadas AS musica
MERGE (p)-[:LIKED]->(musica) // Relaciona as pessoas com as músicas