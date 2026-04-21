# sistema_de_pedidos

## Visao geral

Este projeto agora usa um modelo de banco mais proximo do mercado. Em vez de guardar um unico produto direto na tabela de pedidos, o sistema separa:

- quem compra
- onde sera feita a entrega
- quais produtos existem
- qual pedido foi criado
- quais itens fazem parte de cada pedido
- como o pagamento foi registrado

Essa separacao deixa o banco mais organizado e permite que um pedido tenha varios produtos.

## Tabelas principais

### `usuarios`

Guarda os dados do cliente.

Campos principais:

- `id`
- `nome`
- `email`
- `telefone`
- `ativo`

### `enderecos`

Guarda um ou mais enderecos para cada usuario.

Campos principais:

- `id`
- `usuario_id`
- `apelido`
- `cep`
- `logradouro`
- `numero`
- `bairro`
- `cidade`
- `estado`
- `principal`

### `categorias`

Organiza os produtos por tipo.

Campos principais:

- `id`
- `nome`

### `produtos`

Guarda os produtos vendidos pelo sistema.

Campos principais:

- `id`
- `categoria_id`
- `nome`
- `descricao`
- `preco`
- `estoque`
- `ativo`

### `pedidos`

Guarda os dados gerais do pedido.

Campos principais:

- `id`
- `usuario_id`
- `endereco_id`
- `data_pedido`
- `status`
- `valor_total`
- `observacoes`

### `itens_pedido`

Guarda os produtos de cada pedido.

Campos principais:

- `id`
- `pedido_id`
- `produto_id`
- `quantidade`
- `preco_unitario`
- `subtotal`

### `pagamentos`

Guarda como o pedido foi pago.

Campos principais:

- `id`
- `pedido_id`
- `forma_pagamento`
- `status`
- `valor`
- `transacao_codigo`
- `data_pagamento`

## Relacionamentos

- Um `usuario` pode ter varios `enderecos`
- Um `usuario` pode ter varios `pedidos`
- Um `pedido` pertence a um `usuario`
- Um `pedido` pode ter varios `itens_pedido`
- Um `item_pedido` pertence a um `pedido`
- Um `produto` pode aparecer em varios `itens_pedido`
- Um `pedido` pode ter um `pagamento`
- Uma `categoria` pode ter varios `produtos`

Forma simples de visualizar:

```text
usuarios -> enderecos
usuarios -> pedidos -> itens_pedido <- produtos <- categorias
pedidos -> pagamentos
```

## Ordem de criacao

1. `usuarios`
2. `enderecos`
3. `categorias`
4. `produtos`
5. `pedidos`
6. `itens_pedido`
7. `pagamentos`

Essa ordem e importante porque as chaves estrangeiras dependem de tabelas criadas antes.

## Arquivos do projeto

- `schema.sql`: cria o banco e as tabelas
- `seeds.sql`: insere dados de exemplo
- `queries.sql`: consultas para estudo e relatorios basicos

## Fluxo de uso

1. Execute `schema.sql`
2. Execute `seeds.sql`
3. Execute `queries.sql`

## Melhorias reais que este modelo traz

- Um pedido pode ter varios produtos
- O preco fica salvo no item do pedido, mesmo se o produto mudar depois
- O endereco fica separado do usuario
- O pagamento tem status proprio
- Os produtos podem ser agrupados por categoria
- O banco ja nasce mais preparado para relatorios
