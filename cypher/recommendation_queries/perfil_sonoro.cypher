// Músicas com perfil sonoro semelhante (dançabilidade, energia)

// Compara atributos como dançabilidade e energia para sugerir músicas com perfil parecido
// Avalia dançabilidade e energia, e ainda pode incluir outras medidas e pesos
// É a que mais se aproxima do gosto real da Pessoa.
// Permite encontrar músicas que combinam com o estilo da pessoa
// É como dizer: “Essa música está bem pertinho do seu gosto no mapa musical!”

// Etapa 1: calcular perfil médio do usuário
MATCH (p:Person {name: "Olivia Martinez"})-[:LIKED]->(s:Song)
WITH p, avg(s.danceability) AS avgDance, avg(s.energy) AS avgEnergy

// Etapa 2: selecionar músicas não curtidas nem recomendadas
MATCH (recommended:Song)
WHERE
  NOT (p)-[:LIKED]->(recommended) AND
  NOT EXISTS {
    MATCH (recommended)-[:SUGGESTS]-(rec:Rec)-[:TARGETED_TO]->(p)
  }

// Etapa 3: calcular distância euclidiana
WITH
  p,
  avgDance,
  avgEnergy,
  avg(recommended.danceability) AS recAvgDance,
  avg(recommended.energy) AS recAvgEnergy,
  recommended,
  sqrt(
    (recommended.danceability - avgDance) ^ 2 +
    (recommended.energy - avgEnergy)
    ^
    2) AS distancia

// Etapa 4: Ordenar, sortear e limitar depois de calcular a distância, para diminuir a possibilidade de se recomendar muitas músicas de Baixa ou MuitoBaixa compatibilidade
WITH p, recommended, distancia, avgDance, avgEnergy, recAvgDance, recAvgEnergy
ORDER BY rand()
LIMIT 5

// Etapa 5: Buscar o gênero e o artista de cada música recomendada para compor o grafo.
MATCH (recommended)-[r1:HAS_GENRE]->(g:Genre)
MATCH (recommended)-[r2:BY_ARTIST]->(a:Artist)

// Etapa 6: Classificar as músicas por compatibilidade e retornar os dados
WITH
  p,
  avgDance,
  avgEnergy,
  recAvgDance,
  recAvgEnergy,
  recommended,
  distancia,
  r1,
  g,
  r2,
  a,
  CASE
    WHEN distancia <= 0.10 THEN 'MuitoAlta'
    WHEN distancia <= 0.25 THEN 'Alta'
    WHEN distancia <= 0.40 THEN 'Media'
    WHEN distancia <= 0.60 THEN 'Baixa'
    ELSE 'MuitoBaixa'
  END AS compatPerfil
//ORDER by compatPerfil

// Etapa 7: Cria ou mescla o nó do algoritmo específico
WITH
  p,
  recommended,
  distancia,
  r1,
  g,
  r2,
  a,
  compatPerfil,
  avgDance,
  avgEnergy,
  recAvgDance,
  recAvgEnergy
MERGE (algo:Algorithm {tipo: "SoundProfile"})
SET
  algo.descricao = "recomenda com base no perfil sonoro que o usuário curte",
  algo.versao = "1.0",
  algo.releaseDate = "2025-11-11"


// Etapa 8: Cria ou mescla o nó de Compatibilidade
MERGE
  (comp:Compatibility
    {descricao: "nivel de compatibilidade", nivel: compatPerfil})
SET
  comp.profileDance = toFloat(apoc.number.format(avgDance, "#.000")),
  comp.avgRecDance = toFloat(apoc.number.format(recAvgDance, "#.000")),
  comp.profileEnergy = toFloat(apoc.number.format(avgEnergy, "#.000")),
  comp.avgRecEnergy = toFloat(apoc.number.format(recAvgEnergy, "#.000")),
  comp.distancia = toFloat(apoc.number.format(distancia, "#.000"))


// Etapa 9: Cria o nó de recomendação
CREATE
  (rec:Rec
    {
      id: randomUUID(),
      data: date(),
      tipo: "baseado_em_perfil_sonoro",
      recomendadoPara: p.name
    })

// Etapa 10: Criar os relacionamentos:
WITH p, recommended, r1, g, r2, a, algo, comp, rec

// Relaciona o algoritmo à recomendação
MERGE (algo)-[rb:RECOMMENDED_BY]->(rec)

// Relaciona a recomendação à pessoa-alvo
MERGE (rec)-[rt:TARGETED_TO]->(p)

// Relaciona a recomendação com cada música recomendada
MERGE (rec)-[rs:SUGGESTS]->(recommended)

// Relaciona cada música recomendada à sua respectiva compatibilidade
MERGE (recommended)-[ri:INFLUENCED_BY]->(comp)
//SET g: InfluencerC // Rotula o gênero com a qualificação de Influencer

// Etapa 11: Retorna o Grafo
RETURN algo, rec, p, recommended, g, a, comp, r1, r2, rb, rt, rs, ri