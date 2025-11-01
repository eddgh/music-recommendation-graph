//Cria os relacionamentos LIKE_ARTISTS entre Persons e Artist em massa para popular o banco
MATCH (p:Person {name: "Emily Johnson"}), (a:Artist)
WHERE a.name IN ["Coldplay", "Radiohead", "Muse", "Queen", "Snow Patrol", "The Killers", "Blur", "Oasis", "Led Zeppelin", "Gorillaz"]
MERGE (p)-[:LIKES_ARTIST]->(a);

MATCH (p:Person {name: "Michael Smith"}), (a:Artist)
WHERE a.name IN ["Nirvana", "Foo Fighters", "Red Hot Chili Peppers", "Linkin Park", "System of a Down", "Kings of Leon", "Franz Ferdinand", "The White Stripes", "Goo Goo Dolls", "The Cranberries"]
MERGE (p)-[:LIKES_ARTIST]->(a);

MATCH (p:Person {name: "Sophia Davis"}), (a:Artist)
WHERE a.name IN ["Gorillaz", "Coldplay", "Muse", "Queen", "Blur", "Radiohead", "Snow Patrol", "Foo Fighters", "Led Zeppelin", "Oasis"]
MERGE (p)-[:LIKES_ARTIST]->(a);

MATCH (p:Person {name: "James Wilson"}), (a:Artist)
WHERE a.name IN ["System of a Down", "Linkin Park", "Red Hot Chili Peppers", "Nirvana", "The Killers", "Franz Ferdinand", "Kings of Leon", "The White Stripes", "Goo Goo Dolls", "Led Zeppelin"]
MERGE (p)-[:LIKES_ARTIST]->(a);

MATCH (p:Person {name: "Olivia Martinez"}), (a:Artist)
WHERE a.name IN ["Queen", "The Cranberries", "Snow Patrol", "Coldplay", "Muse", "Radiohead", "Blur", "Foo Fighters", "Oasis", "Led Zeppelin"]
MERGE (p)-[:LIKES_ARTIST]->(a);