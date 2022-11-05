-- Conseguir dato de Casas 2022

SELECT
Municipio,
Inmueble, 
ROUND(AVG(Precio),2) as Avg_Precio_MXN,
COUNT(Inmueble) as Count_Inmueble
FROM
Portfolio2..Venta2022
WHERE Inmueble = 'Casa'
Group by Municipio, Inmueble
Order by Municipio ASC



-- Conseguir dato de Departamentos 2022

SELECT
Municipio,
Inmueble, 
ROUND(AVG(Precio),2) as Avg_Precio_MXN,
COUNT(Inmueble) as Count_Inmueble
FROM
Portfolio2..Venta2022
WHERE Inmueble = 'Departamento'
Group by Municipio, Inmueble
Order by Municipio ASC
