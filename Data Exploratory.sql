Select *
From CovidDeaths
Order By 3,4

Select *
From CovidVaccinations
Order By 3,4

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CovidVaccinations'

EXEC sp_help 'CovidVaccinations'  


SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths
ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths(Death Percentage or rate - it shows the likelihood od dying if you contract covid)
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths
WHERE location like '%South%Africa%'
ORDER BY 1,2

-- Looking at the Total cases vs Population(Shows the percentage of pupulation that contracted covid)
SELECT location, date, population, total_cases, (total_cases/population)*100 as ContractionPercentage
FROM CovidDeaths
WHERE location like '%South%Africa%'
ORDER BY 1,2


-- Looking at the highest contraction or infection rate that South Africa got within the timespan of this dataset
SELECT 
    MAX((total_cases / population) * 100) AS HighestContractionPercentage
FROM 
    CovidDeaths
WHERE 
    location LIKE '%South%Africa%'

SELECT location, date, population, total_cases, (total_cases/population)*100 as ContractionPercentage
FROM CovidDeaths
WHERE location LIKE '%South%Africa%'
AND (total_cases/population)*100 = (
    SELECT MAX((total_cases/population)*100) AS HighestContractionPercentage
    FROM CovidDeaths
    WHERE location LIKE '%South%Africa%'
)
ORDER BY 1, 2



-- Looking at Country with highest infection rate compared to Population
SELECT location, population, MAX(total_cases) as HighestCaseCount, MAX((total_cases/population)*100) as HighestInfectionPercentage
FROM CovidDeaths
GROUP BY location, population
ORDER BY HighestInfectionPercentage Desc

-- Countries with Highest Death Count per Population 
SELECT location, population, MAX(total_deaths) as HighestDeathCount
FROM CovidDeaths
GROUP BY location, population
ORDER BY 3 Desc

-- Cast "total_deaths" to integer
SELECT location, population, MAX(Cast(total_deaths as int)) as TotalDeathCount
FROM CovidDeaths
WHERE location NOT LIKE '%Europe%'
   AND location NOT LIKE '%America%'
   AND location NOT LIKE '%Asia%'
   AND location NOT LIKE '%World%'
   AND location <> 'Africa' -- Filtering out all continents from the location columns
GROUP BY location, population
ORDER BY 3 Desc

SELECT location, population, MAX(Cast(total_deaths as int)) as HighestDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY 3 Desc


-- Showing the continent with the highest death count
SELECT continent, SUM(Cast(total_deaths as int)) as HighestDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY 2 Desc


SELECT location, Max(Cast(total_deaths as int)) as HighestDeathCount
FROM CovidDeaths
WHERE continent is null
GROUP BY location
ORDER BY 2 Desc


-- Global Numbers(Number of new cases, new deaths and deaths percentage on the new cases per day)
SELECT Cast(date as date) as Date,SUM(new_cases) as TotalCases, SUM(Cast(new_deaths as int)) as TotalDeaths, SUM(Cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage --total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2


-- Looking at Total Population vs Vaccinations
SELECT Dea.continent, Dea.location, Dea.date, Dea.population, Vac.new_vaccinations, SUM(cast(vac.new_vaccinations as int)) OVER (Partition By Dea.location)
FROM CovidDeaths as Dea
JOIN CovidVaccinations as Vac
   ON Dea.location = Vac.location
   AND Dea.date = Vac.date
WHERE dea.continent is not null
ORDER BY 2,3


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

