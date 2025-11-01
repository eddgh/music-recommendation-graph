// Buscar músicas e distribuir aleatoriamente para cada pessoa, para efeito de testes, para popular o banco

MATCH (s:Song)
WITH collect(s.name) AS musicas,
     ["Emily Johnson", "Michael Smith", "Sophia Davis", "James Wilson", "Olivia Martinez", "Ethan Brown", "Ava Taylor", "William Anderson", "Isabella Thomas", "Daniel Moore"] AS pessoas
UNWIND pessoas AS pessoa
UNWIND apoc.coll.randomItems(musicas, 100) AS musica
MATCH (p:Person {name: pessoa})
MATCH (s:Song {name: musica})
MERGE (p)-[:LIKED]->(s);