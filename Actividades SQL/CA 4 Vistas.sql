-- todos los clientes
SELECT cl.ruc, cl.nombre, SUM(p.total) AS TotalPedidos
FROM clientes cl JOIN pedidos p ON cl.ruc = p.ruc
GROUP BY cl.ruc, cl.nombre
ORDER BY 3 DESC;

-- si quiero eso para reporte se usa una vista 
CREATE VIEW vClientesPedidos AS
SELECT cl.ruc, cl.nombre, SUM(p.total) AS TotalPedidos
FROM clientes cl JOIN pedidos p ON cl.ruc = p.ruc
GROUP BY cl.ruc, cl.nombre
ORDER BY 3 DESC;

-- uso de la vista (se puede hacer join tambien)
SELECT * FROM vClientesPedidos WHERE nombre LIKE "Lopez";
