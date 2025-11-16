// Deletar o usuario e todos os dados de exemplo depois de popular o banco
MATCH (n) WHERE n.name CONTAINS "Exemplo"
DETACH DELETE n