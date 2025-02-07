-- 問1
-- 国名を全て抽出してください。
SELECT 
    name
FROM
    cities
;

-- 問2
-- ヨーロッパに属する国をすべて抽出してください。
SELECT
    *
FROM
    countries
WHERE
    continent IN ('Europe')
;

-- 問3
-- ヨーロッパ以外に属する国をすべて抽出してください。
SELECT
    *
FROM
    countries
WHERE
    continent NOT IN ('Europe')
;

-- 問4
-- 人口が10万人以上の国をすべて抽出してください。
SELECT
    *
FROM
    countries
WHERE
    population >= 100000
;

-- 問5
-- 平均寿命が56歳から76歳の国をすべて抽出してください。
SELECT
    *
FROM
    countries
WHERE 
	life_expectancy >= 56
AND  life_expectancy  <=76
;

-- 問6
-- 国コードがNLB,ALB,DZAのもの市区町村をすべて抽出してください。
SELECT
    district
FROM
    cities
WHERE
    country_code IN ('NLB','ALB','DZA');

-- 問7
-- 独立独立記念日がない国をすべて抽出してください。
SELECT * FROM countries WHERE indep_year IS NULL;

-- 問8
-- 独立独立記念日がある国をすべて抽出してください。
SELECT * FROM countries WHERE indep_year IS NOT NULL;

-- 問9
-- 名前の末尾が「ia」で終わる国を抽出してください。
SELECT * FROM countries WHERE name LIKE '%ia';

-- 問10
-- 名前の中に「st」が含まれる国を抽出してください。
SELECT * FROM countries WHERE name LIKE '%st%';

-- 問11
-- 名前が「an」で始まる国を抽出してください。
SELECT * FROM countries WHERE name LIKE 'an%';

-- 問12
-- 全国の中から独立記念日が1990年より前または人口が10万人より多い国を全て抽出してください。
SELECT * FROM countries 
WHERE indep_year <= 1900 
OR population >=100000;

-- 問13
-- コードがDZAもしくはALBかつ独立記念日が1990年より前の国を全て抽出してください。
SELECT * FROM countries 
WHERE code = 'DZA' OR code = 'ALB'
AND indep_year <= 1900;

-- 問14
-- 全ての地方をグループ化せずに表示してください。
SELECT DISTINCT region FROM countries
;

-- 問15
-- 国名と人口を以下のように表示させてください。シングルクォートに注意してください。
-- 「Arubaの人口は103000人です」
SELECT name,'の人口は',population,'人です' 
FROM countries;

-- 問16
-- 平均寿命が短い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT name,life_expectancy 
FROM countries
WHERE NOT life_expectancy IS NULL
ORDER BY life_expectancy ASC;

-- 問17
-- 平均寿命が長い順に国名を表示させてください。ただしNULLは表示させないでください。
SELECT name,life_expectancy 
FROM countries
WHERE NOT life_expectancy IS NULL
ORDER BY life_expectancy DESC;

-- 問18
-- 平均寿命が長い順、独立記念日が新しい順に国を表示させてください。
SELECT name,life_expectancy,indep_year
FROM countries
ORDER BY indep_year ASC, life_expectancy DESC;

-- 問19
-- 全ての国の国コードの一文字目と国名を表示させてください。
SELECT name, 
SUBSTRING(code,1,1) AS code 
FROM countries;

-- 問20
-- 国名が長いものから順に国名と国名の長さを出力してください。
SELECT name, length(name)
FROM countries
ORDER BY length(name) DESC;

-- 問21
-- 全ての地方の平均寿命、平均人口を表示してください。(NULLも表示)
SELECT 
     region,
     AVG(life_expectancy), 
     AVG(population) 
FROM countries
GROUP BY region;

-- 問22
-- 全ての地方の最長寿命、最大人口を表示してください。(NULLも表示)
SELECT 
        region,
        MAX(life_expectancy) ,
        MAX(population)
FROM countries
GROUP BY region;

-- 問23
-- アジア大陸の中で最小の表面積を表示してください
SELECT MIN(surface_area)
FROM countries
WHERE continent = 'Asia';

-- 問24
-- アジア大陸の表面積の合計を表示してください。
SELECT SUM(surface_area)
FROM countries
WHERE continent ='Asia';

-- 問25
-- 全ての国と言語を表示してください。一つの国に複数言語があると思いますので同じ国名を言語数だけ出力してください。
SELECT name,language
FROM country_languages;

-- 問26
-- 全ての国と言語と市区町村を表示してください。
SELECT countries.name, cities.name, country_languages.language
FROM countries
JOIN cities
ON (countries.code = cities.country_code)
JOIN country_languages
ON (countries.code = country_languages.country_code)
;

-- 問27
-- 全ての有名人を出力してください。左側外部結合を使用して国名なし（country_codeがNULL）も表示してください。
SELECT celebrities.name, countries.name
FROM countries
LEFT OUTER JOIN celebrities
ON countries.name = celebrities.name;

-- 問28
-- 全ての有名人の名前,国名、第一言語を出力してください。
SELECT celebrities.name, countries.name, country_languages.language
FROM celebrities 
JOIN countries
ON (celebrities.country_code = countries.code)
JOIN country_languages
ON (celebrities.country_code = country_languages.country_code)
where country_languages.is_official = 'T'
;

-- 問29
-- 全ての有名人の名前と国名をに出力してください。 ただしテーブル結合せずサブクエリを使用してください。
SELECT celebrities.name AS name,
    (
        SELECT
            countries.name
        FROM
            countries
        WHERE countries.code = country_code
    )AS country_name
FROM celebrities
;

-- 問30
-- 最年長が50歳以上かつ最年少が30歳以下の国を表示させてください。
SELECT 
    country_code,
    age
FROM
    celebrities
where
    age<=30 
UNION
select
	country_code ,
	age
FROM celebrities
where 
 age >= 50
;

-- 問31
-- 1991年生まれと、1981年生まれの有名人が何人いるか調べてください。ただし、日付関数は使用せず、UNION句を使用してください。
SELECT
    COUNT(*)
FROM
    celebrities  
WHERE
    age < (2023 - 1991)
UNION
SELECT
    COUNT(*)
FROM
    celebrities
WHERE
     age > (2023 - 1981)
;

-- 問32
-- 有名人の出身国の平均年齢を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。
SELECT countries.name, AVG(celebrities.age) AS average_age
FROM countries
JOIN celebrities ON (countries.code = celebrities.country_code)
GROUP BY countries.name
ORDER BY average_age DESC;