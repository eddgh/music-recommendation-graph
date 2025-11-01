// Criação dos Nós
MERGE (p:Person {personId: 0}) SET p.name = "Exemplo"
MERGE (s:Song {name: "Música Exemplo"})
MERGE (a:Artist {name: "Artista Exemplo"})
MERGE (g:Genre {name: "Gênero Exemplo"})
MERGE (t:Tag {name: "Tag Exemplo"})

// Criação dos Relacionamentos
MERGE (p)-[:LIKED]->(s)
MERGE (p)-[:LIKES_ARTIST]->(a)
MERGE (s)-[:BY_ARTIST]->(a)
MERGE (a)-[:HAS_STYLE]->(g)
MERGE (s)-[:HAS_GENRE]->(g)
MERGE (s)-[:TAGGED]->(t)