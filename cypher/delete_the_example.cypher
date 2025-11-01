// Deletar o usuario e todos os dados de exemplo depois de popular o banco

MATCH (n) WHERE n.personId = 0 OR n.name STARTS WITH "Exemplo"
DETACH DELETE n