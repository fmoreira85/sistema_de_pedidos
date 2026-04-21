USE sistema_pedidos;

-- 1. Listar todos os usuarios
SELECT id, nome, email, telefone, ativo
FROM usuarios
ORDER BY nome;

-- 2. Listar todos os produtos com categoria
SELECT
    p.id,
    p.nome,
    c.nome AS categoria,
    p.preco,
    p.estoque
FROM produtos p
INNER JOIN categorias c ON c.id = p.categoria_id
ORDER BY p.nome;

-- 3. Listar pedidos com nome do usuario
SELECT
    pe.id AS pedido_id,
    u.nome AS usuario,
    pe.status,
    pe.data_pedido,
    pe.valor_total
FROM pedidos pe
INNER JOIN usuarios u ON u.id = pe.usuario_id
ORDER BY pe.data_pedido DESC;

-- 4. Listar itens do pedido com usuario e produto
SELECT
    pe.id AS pedido_id,
    u.nome AS usuario,
    pr.nome AS produto,
    ip.quantidade,
    ip.preco_unitario,
    ip.subtotal
FROM itens_pedido ip
INNER JOIN pedidos pe ON pe.id = ip.pedido_id
INNER JOIN usuarios u ON u.id = pe.usuario_id
INNER JOIN produtos pr ON pr.id = ip.produto_id
ORDER BY pe.id, pr.nome;

-- 5. Mostrar usuarios que nao fizeram pedidos
SELECT
    u.id,
    u.nome,
    u.email
FROM usuarios u
LEFT JOIN pedidos pe ON pe.usuario_id = u.id
WHERE pe.id IS NULL
ORDER BY u.nome;

-- 6. Total gasto por usuario
SELECT
    u.id,
    u.nome,
    COALESCE(SUM(pe.valor_total), 0) AS total_gasto
FROM usuarios u
LEFT JOIN pedidos pe ON pe.usuario_id = u.id
WHERE pe.status <> 'cancelado' OR pe.status IS NULL
GROUP BY u.id, u.nome
ORDER BY total_gasto DESC, u.nome ASC;

-- 7. Quantidade de pedidos por usuario
SELECT
    u.id,
    u.nome,
    COUNT(pe.id) AS quantidade_pedidos
FROM usuarios u
LEFT JOIN pedidos pe ON pe.usuario_id = u.id
GROUP BY u.id, u.nome
ORDER BY quantidade_pedidos DESC, u.nome ASC;

-- 8. Usuarios que gastaram mais de 500
SELECT
    u.id,
    u.nome,
    SUM(pe.valor_total) AS total_gasto
FROM usuarios u
INNER JOIN pedidos pe ON pe.usuario_id = u.id
WHERE pe.status <> 'cancelado'
GROUP BY u.id, u.nome
HAVING SUM(pe.valor_total) > 500
ORDER BY total_gasto DESC, u.nome ASC;

-- 9. Produto mais vendido por quantidade
SELECT
    pr.id,
    pr.nome,
    SUM(ip.quantidade) AS total_vendido
FROM itens_pedido ip
INNER JOIN produtos pr ON pr.id = ip.produto_id
INNER JOIN pedidos pe ON pe.id = ip.pedido_id
WHERE pe.status <> 'cancelado'
GROUP BY pr.id, pr.nome
ORDER BY total_vendido DESC, pr.nome ASC
LIMIT 1;

-- 10. Media de gasto por usuario
SELECT
    AVG(gastos.total_por_usuario) AS media_gasto_por_usuario
FROM (
    SELECT
        u.id,
        COALESCE(SUM(pe.valor_total), 0) AS total_por_usuario
    FROM usuarios u
    LEFT JOIN pedidos pe
        ON pe.usuario_id = u.id
        AND pe.status <> 'cancelado'
    GROUP BY u.id
) AS gastos;

-- 11. IN -> usuarios que fizeram pedidos
SELECT
    id,
    nome,
    email
FROM usuarios
WHERE id IN (
    SELECT usuario_id
    FROM pedidos
)
ORDER BY nome;

-- 12. EXISTS -> usuarios com pedidos
SELECT
    u.id,
    u.nome,
    u.email
FROM usuarios u
WHERE EXISTS (
    SELECT 1
    FROM pedidos pe
    WHERE pe.usuario_id = u.id
)
ORDER BY u.nome;

-- 13. NOT EXISTS -> usuarios sem pedidos
SELECT
    u.id,
    u.nome,
    u.email
FROM usuarios u
WHERE NOT EXISTS (
    SELECT 1
    FROM pedidos pe
    WHERE pe.usuario_id = u.id
)
ORDER BY u.nome;

-- 14. Subquery -> usuarios que gastaram acima da media
SELECT
    gastos.id,
    gastos.nome,
    gastos.total_gasto
FROM (
    SELECT
        u.id,
        u.nome,
        COALESCE(SUM(pe.valor_total), 0) AS total_gasto
    FROM usuarios u
    LEFT JOIN pedidos pe
        ON pe.usuario_id = u.id
        AND pe.status <> 'cancelado'
    GROUP BY u.id, u.nome
) AS gastos
WHERE gastos.total_gasto > (
    SELECT AVG(media_gastos.total_por_usuario)
    FROM (
        SELECT
            u.id,
            COALESCE(SUM(pe.valor_total), 0) AS total_por_usuario
        FROM usuarios u
        LEFT JOIN pedidos pe
            ON pe.usuario_id = u.id
            AND pe.status <> 'cancelado'
        GROUP BY u.id
    ) AS media_gastos
)
ORDER BY gastos.total_gasto DESC, gastos.nome ASC;

-- 15. Resumo de pagamentos por pedido
SELECT
    pe.id AS pedido_id,
    u.nome AS usuario,
    pg.forma_pagamento,
    pg.status AS status_pagamento,
    pg.valor
FROM pagamentos pg
INNER JOIN pedidos pe ON pe.id = pg.pedido_id
INNER JOIN usuarios u ON u.id = pe.usuario_id
ORDER BY pe.id;
