USE sistema_pedidos;

INSERT INTO usuarios (nome, email, telefone) VALUES
    ('Ana Souza', 'ana.souza@gmail.com', '(65) 99911-1001'),
    ('Bruno Lima', 'bruno.lima@yahoo.com', '(65) 99911-1002'),
    ('Carla Mendes', 'carla.mendes@outlook.com', '(65) 99911-1003'),
    ('Diego Ferreira', 'diego.ferreira@gmail.com', '(65) 99911-1004'),
    ('Elisa Rocha', 'elisa.rocha@hotmail.com', '(65) 99911-1005');

INSERT INTO enderecos (
    usuario_id,
    apelido,
    cep,
    logradouro,
    numero,
    bairro,
    cidade,
    estado,
    principal
) VALUES
    (1, 'Casa', '78000-001', 'Rua das Acacias', '120', 'Centro Norte', 'Cuiaba', 'MT', 1),
    (1, 'Trabalho', '78000-045', 'Avenida do CPA', '1500', 'Bosque da Saude', 'Cuiaba', 'MT', 0),
    (2, 'Casa', '78000-120', 'Rua das Palmeiras', '55', 'Jardim Europa', 'Cuiaba', 'MT', 1),
    (3, 'Casa', '78000-210', 'Rua Sao Benedito', '340', 'Dom Aquino', 'Cuiaba', 'MT', 1),
    (4, 'Casa', '78000-320', 'Avenida Miguel Sutil', '980', 'Despraiado', 'Cuiaba', 'MT', 1),
    (5, 'Casa', '78000-410', 'Rua dos Ipes', '77', 'Santa Rosa', 'Cuiaba', 'MT', 1);

INSERT INTO categorias (nome) VALUES
    ('Computadores'),
    ('Perifericos'),
    ('Escritorio');

INSERT INTO produtos (categoria_id, nome, descricao, preco, estoque) VALUES
    (1, 'Notebook Dell Inspiron 15', 'Notebook para estudo e trabalho com 16GB de RAM', 3499.90, 12),
    (2, 'Mouse Sem Fio Logitech', 'Mouse ergonomico com conexao USB', 89.90, 60),
    (2, 'Teclado Mecanico Redragon', 'Teclado mecanico ABNT2 com iluminacao', 249.90, 30),
    (1, 'Monitor LG 24 Polegadas', 'Monitor Full HD para escritorio e home office', 799.90, 20),
    (2, 'Headset Gamer HyperX', 'Headset com microfone e som surround', 319.90, 25),
    (3, 'Cadeira de Escritorio Ergonomica', 'Cadeira com apoio lombar e regulagem de altura', 649.90, 10);

INSERT INTO pedidos (
    usuario_id,
    endereco_id,
    data_pedido,
    status,
    valor_total,
    observacoes
) VALUES
    (1, 1, '2026-04-10 09:15:00', 'entregue', 729.70, 'Entrega realizada no periodo da tarde'),
    (2, 3, '2026-04-11 14:20:00', 'entregue', 3839.70, 'Cliente pediu nota fiscal no email'),
    (2, 3, '2026-04-13 10:05:00', 'separando', 1599.80, 'Aguardando conferencia do estoque'),
    (3, 4, '2026-04-15 16:40:00', 'enviado', 1449.80, 'Pedido enviado pela transportadora'),
    (4, 5, '2026-04-17 11:25:00', 'pendente', 1179.30, 'Pagamento PIX ainda nao confirmado'),
    (4, 5, '2026-04-18 18:00:00', 'cancelado', 649.90, 'Pedido cancelado por solicitacao do cliente');

INSERT INTO itens_pedido (
    pedido_id,
    produto_id,
    quantidade,
    preco_unitario,
    subtotal
) VALUES
    (1, 2, 1, 89.90, 89.90),
    (1, 5, 2, 319.90, 639.80),
    (2, 1, 1, 3499.90, 3499.90),
    (2, 3, 1, 249.90, 249.90),
    (2, 2, 1, 89.90, 89.90),
    (3, 4, 2, 799.90, 1599.80),
    (4, 6, 1, 649.90, 649.90),
    (4, 4, 1, 799.90, 799.90),
    (5, 3, 2, 249.90, 499.80),
    (5, 5, 1, 319.90, 319.90),
    (5, 2, 4, 89.90, 359.60),
    (6, 6, 1, 649.90, 649.90);

INSERT INTO pagamentos (
    pedido_id,
    forma_pagamento,
    status,
    valor,
    transacao_codigo,
    data_pagamento
) VALUES
    (1, 'pix', 'aprovado', 729.70, 'PIX-20260410-0001', '2026-04-10 09:20:00'),
    (2, 'cartao_credito', 'aprovado', 3839.70, 'CC-20260411-0002', '2026-04-11 14:25:00'),
    (3, 'boleto', 'aprovado', 1599.80, 'BOL-20260413-0003', '2026-04-13 10:10:00'),
    (4, 'pix', 'aprovado', 1449.80, 'PIX-20260415-0004', '2026-04-15 16:45:00'),
    (5, 'pix', 'pendente', 1179.30, 'PIX-20260417-0005', NULL),
    (6, 'boleto', 'estornado', 649.90, 'BOL-20260418-0006', NULL);
