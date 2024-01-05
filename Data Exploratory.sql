--Checking the Data set(Table)
Select *
From CovidDeaths

Select *
From CovidVaccinations

-- Checking the tables timeframe
Select Min(Cast(date as date)) as oldest_date, Max(Cast(date as date)) as latest_date
From CovidDeaths



--Number of entries in the two tables
SELECT COUNT(*) AS NumberOfEntries
FROM CovidVaccinations

SELECT COUNT(*) AS NumberOfEntries
FROM CovidDeaths








-- Cheching the data types.
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CovidDeaths'





Select *
From CovidDeaths
Order By 3,4

Select *
From CovidVaccinations
Order By 3,4


SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY 1,2

-- Countries with most cases in the tables timeframe(January 2020 to April 2021)
SELECT location, population, Sum(Cast(total_cases as bigint)) as TotalCases,
Sum(Cast(total_deaths as bigint)) as TotalDeaths
FROM CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY TotalCases Desc   



-- Countries with least cases.
SELECT location, population, Sum(Cast(total_cases as bigint)) as TotalCases,
Sum(Cast(total_deaths as bigint)) as TotalDeaths
FROM CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY TotalCases


-- Countries with least cases(with null values filtered out)
SELECT location, population, Sum(Cast(total_cases as bigint)) as TotalCases,
Sum(Cast(total_deaths as bigint)) as TotalDeaths
FROM CovidDeaths
WHERE continent is not null AND total_cases is not null
GROUP BY location, population
ORDER BY TotalCases



-- Countries with most deaths.
SELECT location, population, Sum(Cast(total_cases as bigint)) as TotalCases,
Sum(Cast(total_deaths as bigint)) as TotalDeaths
FROM CovidDeaths
WHERE continent is not null 
GROUP BY location, population
ORDER BY TotalDeaths Desc



-- Looking at Total Cases vs Total Deaths(Death Percentage or rate - it shows the likelihood od dying if you contract covid)
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths
ORDER BY 1,2 -- 1 and 2 represent the first and the second column, location and date respectively




-- Daily death percentage South Africa
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths
WHERE location like '%South%Africa%'
ORDER BY 1,2






-- Date when the first covid case was detected in the world
SELECT 
    MIN(CASE WHEN total_cases > 0 THEN date END) AS FirstCaseDate,
    location,
    total_cases
FROM CovidDeaths
WHERE total_cases IS NOT NULL AND continent IS NOT NULL 
GROUP BY location, total_cases
ORDER BY FirstCaseDate



-- Date when the first covid death was detected in the world
SELECT 
    MIN(CASE WHEN total_deaths > 0 THEN date END) AS FirstDeathDate,
    location,
    total_deaths
FROM CovidDeaths
WHERE total_deaths IS NOT NULL AND continent IS NOT NULL
GROUP BY location, total_deaths
ORDER BY FirstDeathDate







-- Dates when South Africa registered the first Covid-19 case and death
SELECT 
    MIN(CASE WHEN total_cases > 0 THEN Cast(date as date) END) AS FirstCaseDate,
    MIN(CASE WHEN total_deaths > 0 THEN Cast(date as date) END) AS FirstDeathDate
FROM CovidDeaths
WHERE location = 'South Africa'








-- Days with the highest covid-19 deaths and cases
SELECT location, date, Sum(Cast(total_cases as bigint)) as TotalCases,
Sum(Cast(total_deaths as bigint)) as TotalDeaths
FROM CovidDeaths
WHERE continent is not null
Group by location, date
ORDER BY 4 Desc









-- Infection Percetage in the world(Shows the daily percentage of pupulation that contracted or was infected by covid-19)
SELECT location, date, population, total_cases, Round((total_cases/population)*100, 2) as InfectionPercentage
FROM CovidDeaths
WHERE continent is not null AND total_cases is not null
ORDER BY 5 Desc -- 5 refers to the 5th column in the query ("InfectionPercentage")




-- Infection Percentage in South Africa(Shows the daily percentage of pupulation that contracted or was infected by covid-19)
SELECT location, date, population, total_cases, Round((total_cases/population)*100, 2) as InfectionPercentage
FROM CovidDeaths
WHERE location like 'South Africa' AND total_cases is not null
ORDER BY 5 Desc -- 5 refers to the 5th column in the query ("InfectionPercentage")




-- Another way to ge the day with the highest infection Percentage in South Africa.
SELECT location, date, population, total_cases, (total_cases/population)*100 as InfectionPercentage
FROM CovidDeaths
WHERE location LIKE '%South%Africa%'
AND (total_cases/population)*100 = (
    SELECT MAX((total_cases/population)*100) AS HighestContractionPercentage
    FROM CovidDeaths
    WHERE location LIKE '%South%Africa%'
)
ORDER BY 2



-- Looking at Country with highest infection rate compared to Population
SELECT location, population, MAX(total_cases) as HighestCaseCount, MAX((total_cases/population)*100) as HighestInfectionPercentage
FROM CovidDeaths
GROUP BY location, population
ORDER BY HighestInfectionPercentage Desc





-- Showing the continent with the highest death count
SELECT continent, SUM(Cast(total_deaths as int)) as HighestDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY 2 Desc




-- Highest Death Count in the world as well as in its diiferent continents and regions
SELECT location, Max(Cast(total_deaths as int)) as HighestDeathCount
FROM CovidDeaths
WHERE continent is null
GROUP BY location
ORDER BY 2 Desc


-- Global Numbers(Number of new cases, new deaths and deaths percentage on the new cases per day)
SELECT Cast(date as date) as Date,SUM(new_cases) as TotalCases, SUM(Cast(new_deaths as int)) as TotalDeaths, 
SUM(Cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage 
FROM CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2


-- Looking at Total Population vs Vaccinations


SELECT Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
SUM(Convert(int,vac.new_vaccinations)) OVER (Partition By Dea.location Order by Dea.location, Dea.Date) as PeopleVaccinated_Rolling
FROM CovidDeaths as Dea
JOIN CovidVaccinations as Vac
   ON Dea.location = Vac.location
   AND Dea.date = Vac.date
WHERE dea.continent is not null
ORDER BY 2,3


-- Use CTE

with PopVsVac (Continent, location, Date, Population,new_vaccinations, PeopleVaccinated_Rolling)

as 
(
SELECT Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
SUM(Convert(int,vac.new_vaccinations)) OVER (Partition By Dea.location Order by Dea.location, Dea.Date) as PeopleVaccinated_Rolling
FROM CovidDeaths as Dea
JOIN CovidVaccinations as Vac
   ON Dea.location = Vac.location
   AND Dea.date = Vac.date
WHERE dea.continent is not null
--ORDER BY 2,3
)

Select *, (PeopleVaccinated_Rolling/Population)*100 as VaccinationPercentage
FROM PopVsVac



--Temp Table
DROP Table if exists #PopulationVaccinatedPercent
Create Table #PopulationVaccinatedPercent
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
PeopleVaccinated_Rolling numeric
)


Insert Into #PopulationVaccinatedPercent
SELECT Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
SUM(Convert(int,vac.new_vaccinations)) OVER (Partition By Dea.location Order by Dea.location, Dea.Date) as PeopleVaccinated_Rolling
FROM CovidDeaths as Dea
JOIN CovidVaccinations as Vac
   ON Dea.location = Vac.location
   AND Dea.date = Vac.date
WHERE dea.continent is not null

Select *, (PeopleVaccinated_Rolling/Population)*100 as VaccinationPercentage
FROM #PopulationVaccinatedPercent


-- Creating view to store data for later visualisations

Create View PopulationVaccinatedPercent as
SELECT Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations,
SUM(Convert(int,vac.new_vaccinations)) OVER (Partition By Dea.location Order by Dea.location, Dea.Date) as PeopleVaccinated_Rolling
FROM CovidDeaths as Dea
JOIN CovidVaccinations as Vac
   ON Dea.location = Vac.location
   AND Dea.date = Vac.date
WHERE dea.continent is not null
--ORDER BY 2,3

