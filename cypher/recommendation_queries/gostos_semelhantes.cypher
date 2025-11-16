// Músicas curtidas por usuários semelhantes

// Seleciona a pessoa-alvo e as músicas compartilhadas
MATCH (p:Person {name: "Olivia Martinez"})-[:LIKED]->(shared:Song)

// Seleciona os usuarios que gostam das mesmas musicas(shared)
MATCH (influencer:Person)-[:LIKED]->(shared)
WHERE influencer <> p
WITH p, shared, influencer

// Encontrar as músicas que esses outros usuários gostam e vai ser recomendado para Olivia Martinez
MATCH (influencer)-[:LIKED]->(recommended:Song)
WHERE NOT EXISTS { (p)-[:LIKED]->(recommended) }
ORDER BY rand()
LIMIT 5

WITH
  p,
  shared,
  influencer,
  recommended

// Cria ou reutiliza o nó do algoritmo
MERGE (algo:Algorithm {tipo: "ShareTaste"})
SET
  algo.descricao = "recomenda com base nos usuarios com gostos semelhantes",
  algo.versao = "1.0",
  algo.releaseDate = "2025-11-08"

// Cria o nó de recomendação
CREATE
  (rec:Rec
    {
      id: randomUUID(),
      data: date(),
      tipo: "baseado_em_gostos_semelhantes",
      influenciadoPor: influencer.name,
      recomendadoPara: p.name
    })

WITH
  p,
  shared,
  influencer,
  algo,
  recommended,
  rec,
  datetime() AS agora

// Cria relacionamentos
MERGE (algo)-[r1:RECOMMENDED_BY]->(rec)
MERGE (rec)-[r2:TARGETED_TO]->(p)
MERGE (rec)-[r3:SUGGESTS]->(recommended)
MERGE (recommended)-[r4:INFLUENCED_BY]->(influencer)
SET influencer: InfluencerP
SET influencer.influencerScore = coalesce(influencer.influencerScore, 0) + 1
SET influencer.lastInfluence = agora
SET
  influencer.influenceHistory =
    coalesce(influencer.influenceHistory, []) + [agora]

// Retorna tudo
RETURN algo, rec, p, influencer, recommended, r1, r2, r3, r4