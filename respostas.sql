-- DESAFIO 1: Vendedores ativos
SELECT id_vendedor AS id, nome, salario
FROM vendedores
WHERE inativo = FALSE
ORDER BY nome ASC;

-- DESAFIO 2: Funcionários com salário acima da média
SELECT id_vendedor AS id, nome, salario
FROM vendedores
WHERE salario > (
    SELECT AVG(salario)
    FROM vendedores
)
ORDER BY salario DESC;

-- DESAFIO 3: Resumo por cliente
SELECT c.id_cliente AS id, c.razao_social, 
       COALESCE(SUM(p.valor_total), 0) AS total
FROM clientes c
LEFT JOIN pedido p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.razao_social
ORDER BY total DESC;

-- DESAFIO 4: Situação por pedido
SELECT id_pedido AS id,
       valor_total AS valor,
       data_emissao AS data,
       CASE 
           WHEN data_cancelamento IS NOT NULL THEN 'CANCELADO'
           WHEN data_faturamento IS NOT NULL THEN 'FATURADO'
           ELSE 'PENDENTE'
       END AS situacao
FROM pedido;

-- DESAFIO 5: Produto mais vendido
SELECT 
    i.id_produto,
    SUM(i.quantidade) AS quantidade_vendida,
    SUM(i.quantidade * i.preco_praticado) AS total_vendido,
    COUNT(DISTINCT i.id_pedido) AS pedidos,
    COUNT(DISTINCT p.id_cliente) AS clientes
FROM itens_pedido i
JOIN pedido p ON i.id_pedido = p.id_pedido
GROUP BY i.id_produto
ORDER BY quantidade_vendida DESC, total_vendido DESC
LIMIT 1;
