## Výzkumné otázky

1. **Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**
2. **Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**
3. **Která kategorie potravin zdražuje nejpomaleji (má nejnižší percentuální meziroční nárůst)?**
4. **Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**
5. **Má výška HDP vliv na změny ve mzdách a cenách potravin? Tedy, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?**

**Datové podklady** k odpovědím na otázky jsou součástí repozitáře ve formátu XLSX.

---

## Odpověď na výzkumnou otázku č. 1

Ve sledovaném období 2007–2018 došlo v téměř všech z 19 sledovaných odvětví alespoň jednou k meziročnímu snížení průměrných mezd nebo platů v dostupných datech. 

Odvětví, která během sledovaného období nezaznamenala ani jeden pokles průměrné mzdy/platu, jsou:  
- Ostatní činnosti  
- Zpracovatelský průmysl  
- Zdravotní a sociální péče  

Odvětví **dopravy a skladování** sem nepatří, protože v roce 2011 klesla průměrná mzda/plat oproti roku 2010 o 0,5 Kč.

Největší absolutní pokles mezd a platů nastal mezi lety 2012 a 2013 v odvětví **Peněžnictví a pojišťovnictví**, kde došlo k poklesu o 4 484 Kč.

---

## Odpověď na výzkumnou otázku č. 2

První srovnatelné období je rok 2006, poslední srovnatelné období je rok 2018.

Za průměrnou mzdu v roce 2006 bylo možné si koupit:  
- 1 312,98 kg chleba  
- 1 465,73 litrů polotučného mléka  

V roce 2018 bylo za průměrnou mzdu možné koupit:  
- 1 365,18 kg chleba  
- 1 669,6 litrů mléka

---

## Odpověď na výzkumnou otázku č. 3

Některé průměrné ceny potravin za sledované období 2006–2018 dokonce klesly. Největší pokles zaznamenal **cukr krystal**, jehož cena klesla o 2,29 %. Pro **jakostní víno** nejsou k dispozici data.

---

## Odpověď na výzkumnou otázku č. 4

V datech není rok, ve kterém by byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (přes 10 %).

---

## Odpověď na výzkumnou otázku č. 5

Pro odpověď na tuto otázku byla na datové výstupy z SQL aplikována funkce korelace v MS Excel.

### Funkce KORELACE v Excelu

Funkce **`=KORELACE()`** vypočítá korelační koeficient mezi dvěma oblastmi dat.

- **oblast1** a **oblast2**: Oblasti dat pro výpočet korelace.

### Výsledek:
- **1**: Perfektní pozitivní korelace.
- **-1**: Perfektní negativní korelace.
- **0**: Žádná lineární korelace.

### Korelace v datech:
- **Korelace HDP s cenami**: 0,49
- **Korelace HDP s mzdou**: 0,44

Lze konstatovat, že HDP koreluje s cenami a mzdami přibližně stejně. Jelikož je korelační koeficient výrazně menší než 1, je patrné, že růst HDP se neprojeví v cenách a mzdách okamžitě a lineárně.
