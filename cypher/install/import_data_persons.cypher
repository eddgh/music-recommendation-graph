// 1. Executa a importação dos usuários (Person)
CALL apoc.periodic.iterate(
  '
  LOAD CSV WITH HEADERS FROM "https://drive.google.com/uc?export=download&id=1QRPPNE7gOsRfqB_WAChyllL6L_7zD-HO" AS row
  RETURN row
  ',
  '
  MERGE (p:Person {personId: toInteger(row.personId)})
    ON CREATE SET
        p.name = row.name,
        p.email = row.email,
        p.age = toInteger(row.age),
        p.gender = row.gender,
        p.country = row.country,
        p.city = row.city,
        p.language = row.language,
        p.subscriber = toBoolean(row.subscriber),
        p.signupDate = date(row.signup_date),
        p.listeningTime = row.listening_time,
        p.device = row.device;
  ',
  {batchSize: 1000, parallel: false}
);