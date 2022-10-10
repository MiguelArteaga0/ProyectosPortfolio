--Miguel Arteaga Lopez Sept. - Oct. 2022

SELECT *
From Proyecto1..CovidDeaths
order by 3,4

--SELECT *
--From Proyecto1..CovidVaccinations
--order by 3,4

--Seleccionar data de Mexico y el porcentaje de morir si contratas Covid-19

SELECT Location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From Proyecto1..CovidDeaths
Where location like '%Mexico%'
order by 1,2


SELECT Location, date, total_cases, population, (total_cases/population)*100 as DeathPercentage
From Proyecto1..CovidDeaths
Where location like '%Mexico%'
order by 1,2



--En esta parte muestra el porcentaje de población que tiene Covid-19, Mexico en su punto mayor llegaba al 1.81%

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From Proyecto1..CovidDeaths
order by 1,2


--Cifras Globales

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Proyecto1..CovidDeaths
where continent is not null 
--Group By date
order by 1,2


--Cifras por continente

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Proyecto1..CovidDeaths
Where continent is not null 
Group by continent
order by TotalDeathCount desc


--Cifras por país. Lo preocupante es que Mexico tuvo uno de las cifras mas altas del mundo ocupando el numero #9 en el total (A), y el numero #1 en el total (B). 

--(A)
Select location, MAX(cast(Total_deaths as int)) as TotalDeathCount
From Proyecto1..CovidDeaths
Where location is not null 
Group by location
order by TotalDeathCount desc

--(B)
Select location, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Proyecto1..CovidDeaths
--Where location like '%states%'
Where total_deaths >100000
Group By location
order by DeathPercentage desc


--Join muertes y vacunaciones

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Proyecto1..CovidDeaths dea
Join Proyecto1..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3

-- Temp table para calcular el porcentaje de poblacion vacunado

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Proyecto1..CovidDeaths dea
Join Proyecto1..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated