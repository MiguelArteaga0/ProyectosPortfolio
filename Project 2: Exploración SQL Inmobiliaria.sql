SELECT
Municipio,
Inmueble, 
AVG(Precio) as Avg_Precio,
COUNT(Inmueble) as Count_Inmueble
FROM
Portfolio2..Venta2022
Group by Municipio, Inmueble
Order by Municipio ASC
