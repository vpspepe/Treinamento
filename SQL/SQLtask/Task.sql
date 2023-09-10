/*markdown
<center><h1>TASK SQL</h1></center>
*/

/*markdown
### Salve salve família PJ! 

### Este notebook contém as perguntas do treinamento de SQL. Para ler corretamente o arquivo, você deve instalar a extensão SQL Notebook no seu VS Code. Caso não saiba como fazer isso, as instruções estão na parte de introdução no <a href=https://www.notion.so/pjnprod/Introdu-o-ao-SQL-e-Ferramentas-acdc66507ca14322b784a3a2805089bb#98539a2be5a84754b195075b457e6e60>Notion</a>. 
*/

/*markdown
### A base de dados utilizada para esta Task será a mesma que o vídeo de introdução faz referência, você pode baixá-la <a href=https://www.notion.so/pjnprod/Base-do-v-deo-de-introdu-o-6c50ad2e01674051b625198efe3cf02d>aqui</a>. O arquivo contém a base e uma imagem que ilustra as relações entre as tabelas presentes, esta imagem será muito útil para a execução da Task
*/

/*markdown
### Vamos às perguntas:
*/

/*markdown
### 1. Quais são os tipos de <i>ratings</i> de filmes existentes?

##### <i>Para essa questão utilize a tabela film</i>
*/

--Insira aqui seu código
SELECT DISTINCT rating FROM film;

/*markdown
### 2. Quem são os clientes da loja 2?

##### <i>Utilize a tabela customer para essa questão</i>
*/

--Insira aqui seu código
SELECT DISTINCT first_name 
FROM customer
WHERE store_id = 2;






/*markdown
### 3. Organize os clientes da loja 2 de acordo com seus nomes E sobrenomes em ordem alfabética

##### <i>Utilize a tabela customer para essa questão</i>
*/

--Insira aqui seu código
SELECT DISTINCT first_name 
FROM customer
WHERE store_id = 2
ORDER BY first_name, last_name;

/*markdown
### 4. Selecione os alugéis feitos nos meses de julho e agosto de 2005

##### <i> Utilize a tabela rental para a questão </i>
*/

--Insira aqui seu código
SELECT * 
FROM rental
WHERE rental_date >= "2005-07-01" and rental_date < "2005-09-01";

/*markdown
### 5. Selecione todas as cidade que começam com as letras "AL"

##### Utilize a tabela city para essa questão
*/

--Insira aqui seu código
SELECT city
FROM city
WHERE city LIKE "al%";

/*markdown
### 6. Faça uma consulta que contenha duas colunas, a primeira sendo o ID da loja e a segunda sendo a quantidade de clientes em cada uma delas. Renomeie as colunas para melhor entendimento

##### Utilize a tabela customer para essa questão
*/

--Insira aqui seu código
SELECT  COUNT(customer_id) as "Quantidade de clientes",
    store_id as "ID da Loja"
FROM customer
GROUP BY store_id;

/*markdown
### 7. Faça uma consulta com três colunas, senda a primeira delas o país, a segunda a cidade, e a ultima o endereço em questão. Renomeie-as para melhor entendimento

##### Utilize as tabelas country, city e address para essa questão
*/

--Insira aqui seu código
SELECT address, city,country
FROM address
JOIN city c 
ON address.city_id = c.city_id
JOIN country co
ON c.country_id = co.country_id;



/*markdown
### 8. Faça uma consulta que exiba o ID da loja e seu respectivo preço médio de aluguel.

##### Utilize as tabelas payment e customer para a questão
*/

--Insira aqui seu código
SELECT AVG(rental_id) as "Média de Aluguel", store_id as "ID da Loja"
FROM payment
JOIN customer
ON payment.customer_id = customer.customer_id
GROUP BY store_id;




/*markdown
### 9. Faça uma consulta que contenha três colunas: título do filme, nome de sua categoria e o nome do idioma. Ordenar esses dados do filme mais curto para o mais longo. Renomeie as colunas para melhor entendimento.

##### Utilize as tabelas category, film, language e film_category
*/

--Insira aqui seu código
SELECT film.title, language.name as "idioma", category.name as "Categoria"
FROM film_category, language, category
JOIN film 
ON film_category.film_id = film.film_id
JOIN language la 
on film.language_id = la.language_id
JOIN category cat  
on film_category.category_id = cat.category_id
ORDER BY film.length;

/*markdown
### 10. Crie uma tabela que contenha o título, o nome do idioma, a duração e a classificação dos filmes que possuam mais de 60 minutos de duração

##### Para criar a tabela, utilize as tabelas já existentes film e language
*/

--Insira aqui seu código
CREATE TABLE movies(
    title VARCHAR PRIMARY KEY,
    length FLOAT,
    idiom VARCHAR,
    rating INTEGER 
);


INSERT into movies(title, length, idiom, rating)
SELECT title, length,name, rating
FROM film 
JOIN language la 
ON film.language_id = la.language_id
WHERE length > 60;
select * from movies;

select * from movies;

/*markdown

### 11a. Insira na tabela criada os seguintes filmes:
- OS SETE SAMURAIS, Japanese, 207, PG
- LE PETIT NICOLAS, French, 91, G
- METROPOLIS, German, 153, G
*/

--Insira aqui seu código
INSERT INTO movies
VALUES("OS SETE SAMURAIS", "Japanese", 207, "PG"),
("LE PETIT NICOLAS", "French", 91, "G"),
("METROPOLIS", "German", 153, "G");

/*markdown
### 11b. Faça uma consulta da tabela criada mostrando os filmes cujo nome do idioma seja diferente de English 
*/

--Insira aqui seu código
SELECT * 
FROM movies 
WHERE idiom <> "English" ;

/*markdown
### 12. Estudos recentes mostraram que a classificação do filme ANGELS LIFE foi erroneamente feita. Especialistas aconselham classificar o filme como PG. Realize esse trabalho na tabela criada
*/

--Insira aqui seu código
UPDATE movies
SET rating = "PG"
WHERE title = "ANGELS LIFE";

SELECT * FROM movies
where title = "ANGELS LIFE";

/*markdown
### 13. DESAFIO 

### Crie uma coluna adicional na tabela informando o intervalo de horas de duração do filme. A classificação deve ser dividida entre:
- Menos de 2 horas
- De 2 a 3 horas
- Mais de 3 horas
*/

ALTER TABLE movies
ADD "Intervalo" VARCHAR;

--Insira aqui seu código

UPDATE movies
SET Intervalo = CASE 
WHEN  (length<120) THEN "Menos de 2 horas" 
WHEN  (length >= 120 and length <= 180) THEN "Entre 2 e 3 horas"  
WHEN  length > 180 THEN "Mais de 3 horas"
END;

select * from movies;