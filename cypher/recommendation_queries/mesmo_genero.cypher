// Músicas do mesmo gênero que o usuário costuma curtir

// Identifica gêneros(g) que Olivia costuma curtir
MATCH (p:Person {name: "Olivia Martinez"})-[:LIKED]->(:Song)-[:HAS_GENRE]->(g:Genre)
// Embaralha os gêneros para que nao fixe no primeiro gênero encontrado
WITH DISTINCT p, g
ORDER BY rand()

// Busca músicas do mesmo gênero que ainda não foram curtidas nem recomendadas
MATCH (recommended:Song)-[:HAS_GENRE]->(g)
WHERE NOT (p)-[:LIKED]->(recommended) AND NOT (p)-[:TARGETED_TO]->(recommended)

// Cria ou mescla o nó do algoritmo específico
MERGE (algo:Algorithm {tipo: "LikedGenre"})
SET
  algo.descricao =
    "recomenda com base nos gêneros das músicas que o usuário curte",
  algo.versao = "1.0",
  algo.releaseDate = "2025-11-08"

WITH p, g, recommended, algo
ORDER BY rand()
LIMIT 5

// Cria o nó de recomendação
CREATE
  (rec:Rec
    {
      id: randomUUID(),
      data: date(),
      tipo: "baseado_em_generos_curtidos",
      influenciadoPor: g.name,
      recomendadoPara: p.name
    })

// Criar os relacionamentos:
WITH p, g, recommended, algo, rec

// Relaciona o algoritmo à recomendação
MERGE (algo)-[rb:RECOMMENDED_BY]->(rec)

// Relaciona a recomendação à pessoa-alvo
MERGE (rec)-[rt:TARGETED_TO]->(p)

// Relaciona a recomendação com cada música recomendada
MERGE (rec)-[rs:SUGGESTS]->(recommended)

// Relaciona cada música recomendada ao gênero que influenciou a recomendação
MERGE (recommended)-[ri:INFLUENCED_BY]->(g)
SET g: InfluencerG // Rotula o gênero com a qualificação de Influencer

// Retorna os nós e relacionamentos
RETURN p, g, recommended, algo, rec, rb, rt, rs, ri