<p align="center">
    <img width="150" src="./assets/banner.svg">
</p>


<p align="center">


# music-recommendation-graph
Projeto de Sistema de Recomendação Musical com Grafos usando Neo4j e Cypher!

&nbsp;
>🎶 O sistema identifica padrões de escuta e sugere músicas com base em gênero, artistas seguidos e comportamento de outros usuários. 

>🔍 Usei dados reais do Spotify e consultas avançadas para gerar recomendações personalizadas.

&nbsp;

# 🎵 Sistema de Recomendação Musical com Grafos

Este projeto utiliza **Neo4j** e **consultas Cypher** para recomendar músicas com base em padrões de escuta, afinidade por gênero, artistas seguidos e comportamento de outros usuários.

## 🚀 Funcionalidades

- Representação de usuários, músicas, artistas e gêneros como nós em um grafo
- Interações como curtir e seguir modeladas como arestas com propriedades
- Consultas Cypher para gerar recomendações personalizadas
- Importação de dados reais do Spotify via CSV

## 🧠 Exemplos de Recomendação

| RECOMENDAÇÃO                                                              | DESCRIÇÃO                                                                                                                                                                                                                   |
|---------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Músicas curtidas por usuários semelhantes                                 | O sistema recomenda ao usuário músicas de gêneros que ele já aprecia, com base nas preferências de outros usuários que também demonstram afinidade por esses mesmos gêneros. Ou seja, ele recebe sugestões de faixas que ainda não ouviu, mas que foram bem avaliadas por pessoas com gostos musicais parecidos. |
| Músicas de artistas seguidos ainda não curtidas                           | Sugestões de faixas de artistas que o usuário já acompanha, mas que ainda não curtiu — revelando obras que passaram despercebidas e incentivando uma exploração mais profunda dos artistas favoritos.                        |
| Músicas do mesmo gênero que o usuário costuma curtir                      | Faixas pertencentes aos gêneros que o usuário já demonstrou interesse, mas que ainda não foram curtidas. A ideia é ampliar o repertório dentro dos estilos que ele aprecia, revelando novas músicas alinhadas ao seu gosto. |
| Músicas com perfil sonoro semelhante (dançabilidade, energia)            | Recomendações baseadas na média de atributos sonoros das músicas curtidas pelo usuário, como dançabilidade e energia. O sistema sugere faixas que mantêm o mesmo clima e vibração sonora que ele costuma apreciar.           |

## 📦 Como rodar

1. Instale o Neo4j Desktop ou use o Neo4j Aura
2. Crie um banco e execute os scripts em `cypher/`
3. Importe o CSV com `apoc.load.csv`
4. Teste as consultas de recomendação
5. Na pasta [data](/data/) você encontra os csv utilizados.
6. Na pasta [assets](/assets/) você encontra a imagem do Knowledge Graph, a imagem do passo a passo que deve seguir se optar pela instalação simplificada explicada no passo 7, os arquivos do Dashboard para importar, uma cópia do projeto (backup) completo para importar em uma instância vazia do Neo4j e um arquivo de importação com as pastas de query (em csv) para importar na Query Saved Cypher Panel!
7. Você também pode instalar de forma mais simplificada rodando cada um dos passos na sequência em que aparecem na pasta INSTALAÇÃO do arquivo neo4j_query_saved_cypher, que você pode importar na sua área de query saved do Browser do Neo4j.

## 🎥 Demonstração

Veja o projeto funcionando: [link para os vídeos](https://drive.google.com/drive/folders/1llyh6813P70lt0YzvAjxurDuKZN2PdFC?usp=sharing)

## 🛠️ Tecnologias

- Neo4j
- Cypher
- APOC
- Spotify Dataset (Kaggle)

## 👨‍💻 Autor

<p>
    <img 
      align=left 
      margin=10 
      width=80 
      src="https://avatars.githubusercontent.com/u/72671378?v=4"
    />
    <p>&nbsp&nbsp&nbspEdmundo Batista<br>
    &nbsp&nbsp&nbsp
    <a 
        href="https://github.com/eddgh">
        GitHub
    </a>
    &nbsp;|&nbsp;
    <a 
        href="https://linkedin.com/in/edmundo-jos%C3%A9-3660b76a">
        LinkedIn
    </a>
</p>
</p>
<br/><br/>
<p>

---

⌨️ com 💜 por [Edmundo Batista](https://github.com/eddgh)
