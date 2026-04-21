USE sistema_pedidos;

INSERT INTO usuarios (nome, email) VALUES
    ('Ana Souza', 'ana.souza@gmail.com'),
    ('Bruno Lima', 'bruno.lima@yahoo.com'),
    ('Carla Mendes', 'carla.mendes@outlook.com'),
    ('Diego Ferreira', 'diego.ferreira@gmail.com'),
    ('Elisa Rocha', 'elisa.rocha@hotmail.com');

INSERT INTO produtos (nome, preco) VALUES
    ('Notebook Dell Inspiron 15', 3499.90),
    ('Mouse Sem Fio Logitech', 89.90),
    ('Teclado Mecanico Redragon', 249.90),
    ('Monitor LG 24 Polegadas', 799.90),
    ('Headset Gamer HyperX', 319.90),
    ('Cadeira de Escritorio Ergonomica', 649.90);

INSERT INTO pedidos (usuario_id, produto_id, quantidade) VALUES
    (1, 2, 1),
    (1, 5, 2),
    (2, 1, 1),
    (2, 3, 1),
    (2, 2, 3),
    (3, 4, 2),
    (3, 6, 1),
    (4, 5, 1),
    (4, 2, 2),
    (4, 3, 4);
