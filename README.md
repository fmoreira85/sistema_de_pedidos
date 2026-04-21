# sistema_de_pedidos

## Planejamento do banco de dados MySQL

Este projeto pode começar com um banco de dados simples, mas bem organizado. A ideia e separar o sistema em tabelas que representam:

- quem compra
- o que e vendido
- o pedido realizado
- os itens que fazem parte de cada pedido

## Tabelas necessarias

### 1. `clientes`

Guarda os dados do cliente que faz o pedido.

Campos sugeridos:

- `id` - identificador unico do cliente
- `nome` - nome do cliente
- `telefone` - telefone para contato
- `email` - email do cliente
- `endereco` - endereco para entrega

### 2. `produtos`

Guarda os produtos vendidos pelo sistema.

Campos sugeridos:

- `id` - identificador unico do produto
- `nome` - nome do produto
- `descricao` - descricao curta
- `preco` - preco atual do produto
- `estoque` - quantidade disponivel

### 3. `pedidos`

Guarda as informacoes principais de cada pedido.

Campos sugeridos:

- `id` - identificador unico do pedido
- `cliente_id` - cliente que fez o pedido
- `data_pedido` - data e hora do pedido
- `status` - situacao do pedido, como `pendente`, `pago` ou `entregue`
- `valor_total` - valor final do pedido

### 4. `itens_pedido`

Guarda os produtos que pertencem a cada pedido.

Campos sugeridos:

- `id` - identificador unico do item
- `pedido_id` - pedido ao qual o item pertence
- `produto_id` - produto escolhido
- `quantidade` - quantidade comprada
- `preco_unitario` - preco do produto no momento da compra
- `subtotal` - resultado de `quantidade x preco_unitario`

## Relacionamentos

Os relacionamentos ficam assim:

- Um `cliente` pode ter varios `pedidos`
- Um `pedido` pertence a apenas um `cliente`
- Um `pedido` pode ter varios `itens_pedido`
- Um `item_pedido` pertence a apenas um `pedido`
- Um `produto` pode aparecer em varios `itens_pedido`
- Um `item_pedido` usa apenas um `produto`

Forma simples de visualizar:

```text
clientes -> pedidos -> itens_pedido <- produtos
```

## Explicacao simples

A tabela `pedidos` nao guarda diretamente todos os produtos comprados. Isso acontece porque um pedido pode ter varios produtos, e um mesmo produto pode aparecer em muitos pedidos diferentes.

Por isso existe a tabela `itens_pedido`. Ela funciona como uma ponte entre `pedidos` e `produtos`.

Pensando de forma pratica:

- `clientes` = quem compra
- `produtos` = o que a loja vende
- `pedidos` = a compra feita
- `itens_pedido` = os produtos dentro da compra

## Ordem de criacao no MySQL

A ordem correta e importante por causa das chaves estrangeiras.

1. Criar `clientes`
2. Criar `produtos`
3. Criar `pedidos`
4. Criar `itens_pedido`

## Por que essa ordem?

- `pedidos` precisa de `clientes`, porque usa `cliente_id`
- `itens_pedido` precisa de `pedidos` e `produtos`, porque usa `pedido_id` e `produto_id`

## Exemplo SQL

```sql
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco VARCHAR(200)
);

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(200),
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0
);

CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) NOT NULL DEFAULT 'pendente',
    valor_total DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);
```
