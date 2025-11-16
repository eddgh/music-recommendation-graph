// Músicas de artistas seguidos que ainda não foram curtidas

// Seleciona a pessoa alvo da recomendação e os artistas que ela segue
MATCH (p:Person {name: "Olivia Martinez"})-[:LIKES_ARTIST]->(a:Artist)

// Busca músicas criadas por esses artistas
MATCH (a)<-[:BY_ARTIST]-(s:Song)

// Filtra apenas as músicas que Olivia ainda não curtiu
WHERE NOT (p)-[:LIKED]->(s)

// Limita a 5 músicas aleatórias para recomendação
WITH p, a, s
ORDER BY rand()
LIMIT 5

// Cria ou mescla o nó do algoritmo específico
MERGE (algo:Algorithm {tipo: "LikeArtist"})
SET
  algo.descricao = "recomenda com base nos artistas que o usuário curte",
  algo.versao = "1.0",
  algo.releaseDate = "2025-11-08"

// Cria o nó de recomendação
CREATE
  (rec:Rec
    {
      id: randomUUID(),
      data: date(),
      tipo: "baseado_em_artista_seguido",
      influenciadoPor: a.name,
      recomendadoPara: p.name
    })

// Relaciona o algoritmo à recomendação
MERGE (algo)-[rb:RECOMMENDED_BY]->(rec)

// Relaciona a recomendação à pessoa
MERGE (rec)-[rt:TARGETED_TO]->(p)

// Relaciona cada música à recomendação
MERGE (rec)-[rs:SUGGESTS]->(s)

// Relaciona cada música ao artista que a influenciou
MERGE (s)-[ri:INFLUENCED_BY]->(a)
SET a: InfluencerA

// Retorna os elementos do grafo para visualização
RETURN algo, rec, p, s, a, rb, rt, rs, ri