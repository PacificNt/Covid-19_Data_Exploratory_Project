This is a Data Exploratory/Exploration(DE) Project using SQL. SQL Server is the platfrom used to perform the queries in this project. The project explores Covid-19 data. Two tables are used in this project; the "CovidDeaths" table and the "CovidVaccinations" table.  The two tables were extracted from the Covid-19 data from the "Our World in Data" website (https://ourworldindata.org/covid-deaths) ,and then modified and seperated in two tables using Microsoft Excel.

Some of the columns in the two tables are :

- "iso_code"
- "continent"
- "date"
- "total_cases"
- "total_deaths"
- "population" (only found in the "CovidDeaths" table)

To see the names of all the columns, please check the folder "files" to check te two tables.



**Note:** The data contained in the two tables are slightly diffeent from the data that can be downladed currently from the "Our World in Data" website because the two tables were created with data downloaded on the website in 2021.


Here are some of the queries made in this project with the insight  extracted from them (To see all the queries, please check the "Covid-19_Project") :


**1. Tables Check**



<img width="768" alt="CovidDeath" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/876e8a5d-a27a-4f19-ac1e-cfe3cfdc4c19">









<img width="765" alt="CovidVacc" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/559734f2-81d2-40cf-b46f-938025090b49">











This is just to check if the two tables were loaded properly.










**2. Data Type Check**



<img width="766" alt="Data Types Check" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/2b3c2b12-bdc0-47c2-878b-f3f03aebfa0c">










The data type can also be checked through the pane on the left side of the query pane.










<img width="960" alt="Data Types pane" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/e94c6edd-cc9a-4c1c-bec0-a7ea76b757a8">










**3. Number of entries.**



<img width="765" alt="Number of Entries" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/5d3df504-1ce6-4028-8d22-141c472faaa2">










**Insight:** The two tables both have the same number of entries(85171)










**4. Timeframe.**



<img width="764" alt="Timeframe" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/30aa5152-b7e9-46cd-8d3f-151c168cd62c">










**Insight:** The result shows that the data covers the period from 2020-01-01 to 2021-04-30. As mentionned earlier, to get hte latest the data, please the "Our World in Data" website.










**5. Countries with most Covid-19 cases and deaths.**



**5.1. Most cases**



<img width="871" alt="Countries with most cases" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/c72f1abb-9a42-444f-ae8b-cc61fb0aaf89">










**Insight:**  The result shows that the top 10 countries with most Covid-19 cases  are the United States with 5,094,206,089 cases; India with 2,522,239,196; Brazil with 2,202,143,586; Russia with 789,144,701; France 687,236,610 ;the United Kingdom with 653,726,018 ;Spain with 544,513,797 ;Italy with 516,610,240 ;Turkey 471,419,383 ;Colombia with 425,503,004.










**5.2. Least cases.**



<img width="871" alt="Countries with least case" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/cf8351e9-5475-4748-a20d-ba74a21ff744">










**Insignt:** In the countries with the least cases, the top 10(Falkland Islands, Montserrat, Saint Helena, Nauru, Anguilla, Gibraltar, Northern Cyprus, Turks and Caicos Islands, Faeroe Islands and Greenland) shows display "NULL" in the "total_cases" Column. This can either mean these countries didn't have any Covid-19 cases or either that the data wasn't available/collected when the data set was compiled.










To get countries with least cases with only non-null values, we have to filter out the null values. That can be done the following way :





**5.2.1. Non-Null least cases.**



<img width="872" alt="Screenshot 2024-01-05 031255" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/eb1c58a6-c0ef-43b8-93ef-49caf9361278">










**Insight:**  With null values filtered out, Micronesia (country), Vanuatu, Samoa, Marshall Islands, Solomon Islands, Vatican, Saint Kitts and Nevis, Fiji, Laos and Dominica are the top 10 countries with the least Covid-19 cases, with rescpectiely 100, 290, 394, 688, 3238, 7669, 9788, 15274, 15439 and 25942 cases.










**6. Countries with most deaths.**



<img width="872" alt="Countries with most death" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/9cd48cc9-8640-4f65-8f48-9f65e3fe47c1">










**Insight:** The result shows that the top 10 countries with most Covid-19 deaths are the United States wit 106,611,210 deaths; Brazil with 60,047,815; Mexico with 36,622,615; India with 36,578,144; United Kingdom with 25,219,149; Italy with 22,409,670; France with 19,603,382; Spain with 16,767,799; Russia with 15,069,275; Iran with 13,528,093.










**7. Death Percentage.**



<img width="872" alt="Screenshot 2024-01-05 034129" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/71a1053c-5d8e-45ca-a865-61e0c1be8881">








This shows the daily death percentage(total_deaths/total_cases) per country along the total cases and total deaths.










**8. Dates when the firsts Covid-19 cases and deaths were detected in the world.**



**8.1. First Covid-19 cases.**



<img width="872" alt="First Covid Case" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/dd46992e-fbd7-4694-8d23-abb163749210">









**Insight:** The result shows that the firsts Covid-19 cases were detected on January the 22nd 2020 in South Korea(1), Taiwan(1), United States(1), Japan(2), Thailand(4) and in China(548)










**8.2. First Covid-19 deaths.**



<img width="872" alt="First Covid Death" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/c8794b92-b102-4b8c-946a-4dfd2433c828">










**Insight:**  The result shows that the first few death cases were all registered in China - from the 22nd of January 2020(with 17 cases) to the 1st of Febuary 2020(259 cases). It's only until the 2nd of Febuary where deaths cases were registered in a country other than China(Phillipines with 1 death case).










**8.2.1. Dates when the firt cases and deaths occurred in South Africa.**



<img width="872" alt="Screenshot 2024-01-05 040709" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/db8c4603-7f28-4cf5-9ea6-75dc792b5da4">









**Insight:** The result shows that the first Covid-19 case in South Africa was detected on March the 5th,2020 and the first death was registered on March the 27th, 2020.









**9. Infection Percentage in South Africa.**



<img width="874" alt="Infection Percent SA" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/d57cf5b2-5395-4fc5-8b09-2f74ee18c6e9">










**Insight:** The result shows the daily infection percentage ordered from the highest to the lowest. From it we can see that the highest infection percentage in South Africa was registered on the 31st pf April 2021









**10. Continents with highest death counts.**



<img width="873" alt="Death Count Continent" src="https://github.com/PacificNt/PortfolioProjects/assets/112112663/734030af-7de2-4a44-90eb-7a91dad39bb1">










**Insight:**  The result shows that Europe had the highest deaths with 160,813,747 deaths followed by North America with 153,596,231 deaths, then South America with 105,595,385 deaths, then Asia with 87,116,891 deaths, Africa with 19,064,924 and finally Oceania 256,504 deaths.






_**Reminder:**_  As mentionned earlier, these are just some of the queries made in this project, the see all the queries, please check the SQL Code file(named "Covid-19_Project").




