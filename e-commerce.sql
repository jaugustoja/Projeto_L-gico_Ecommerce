-- Criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente_PF

create table cliente_pf(
	idClient_PF int auto_increment primary key,
    Nome varchar(45),
    CPF char(11) not null,
    constraint unique_cpf_client unique(CPF),
    Endereço varchar(45),
    Forma_de_Pagamento enum('pix','débito','crédito'),
    Data_de_Nascimento date
);

-- criar tabela cliente_PJ

create table cliente_pj(
	idClient_PJ int auto_increment primary key,
    Razão_Social varchar(45) not null,
    constraint razao_social_clietepf unique(Razão_Social),
    Endereço varchar(45),
    Forma_de_Pagamento enum('pix','débito','crédito')
);

-- criar tabela pedido

create table pedido(
	idPedido int auto_increment primary key,
    idClient_PF_pedido int,
	idClient_PJ_pedido int,
    idEntrega_pedido int,
    Status_do_Pedido enum('Em Processamento', 'Enviado', 'Entregue', 'Cancelado') default 'Em Processamento',
    Descrição varchar(45),
    Frete float,
    constraint fk_pedidio_clientepf foreign key (idClient_PF_pedido) references cliente_pf(idClient_PF),
    constraint fk_pedido_cleintepj foreign key (idClient_PJ_pedido) references cliente_pj(idClient_PJ),
    constraint fk_pedido_entrega foreign key (idEntrega_pedido) references entrega(idEntrega)
    
    );

-- criar tabela produto

create table produto(
	idProduto int auto_increment primary key,
    Nome varchar(45) not null,
    Classificação_Infantil bool default false,
    Descrição varchar(45),
    Categoria varchar(20) not null,
    avaliação float default 0,
    dimensão varchar(10),
    valor varchar(45) not null
    
    );
    
    -- criar tabela estoque
    
    create table estoque(
	idEstoque int auto_increment primary key,
    Local_estoque varchar(45) not null,
    Quantidade int default 0
    
    );
    
    
    -- criar tabela fornecedor
    
	create table fornecedor(
	idFronecedor int auto_increment primary key,
    Razão_Social varchar(45) not null,
    CNPJ char(15) not null unique,
    Contato varchar(45),
    Nome_fantasia varchar(45) not null,
    Endereço varchar(45)
    
    );
    
    -- criar tabela vendedor terceiro

create table vendedor(
	idVendedorterceiro int auto_increment primary key,
    Razão_Social varchar(45) not null,
    CNPJ char(15) not null unique,
    Contato varchar(45),
    Nome_fantasia varchar(45) not null,
    Endereço varchar(45)
    
    );
    
    -- criar tabela produto_marketplace - vendendor terceiro
    
    create table produto_marketplace(
		idPSeller int,
        idProduto_mkt int,
        Quantidade int default 1,
        primary key (idPSeller, idProduto_mkt),
        constraint foreign key fk_product_seller(idPSeller) references vendedor(idVendedorterceiro),
        constraint foreign key fk_product_product(idProduto_mkt) references produto(idProduto)
        
        );
        
	-- criar tabela entrega
    
	create table entrega(
		idEntrega int auto_increment primary key,
        Status enum ('Em processo', 'postado', 'à caminho', 'entregue') default 'Em processo',
        Código_Rastreio varchar(45) not null
        );
        
        -- criar tabela produto_fornecedor
    
    create table produto_fornecedor(
		idFornecedor_prodfor int,
        idProduto_prodfor int,
        primary key (idFornecedor_prodfor, idProduto_prodfor),
        constraint foreign key fk_prodfor_fornecedor(idFornecedor_prodfor) references fornecedor(idFronecedor),
        constraint foreign key fk_prodfor_produto(idProduto_prodfor) references produto(idProduto)
        
        );
        
        -- criar tabela produto_pedido
    
    create table produto_pedido(
		idPedido_prodped int,
        idProduto_prodped int,
        primary key (idPedido_prodped, idProduto_prodped),
        constraint foreign key fk_prodped_pedido(idPedido_prodped) references pedido(idPedido),
        constraint foreign key fk_prodped_produto(idProduto_prodped) references produto(idProduto),
        Quantidade int default 1,
        Status_Pedido ENUM('Disponível', 'Sem Estoque') default 'Disponível'
        
        );
        
        -- criar tabela produto_estoque
        
        create table produto_estoque(
		idEstoque_prodest int,
        idProduto_prodest int,
        primary key (idEstoque_prodest, idProduto_prodest),
        constraint foreign key fk_prodest_estoque(idEstoque_prodest) references estoque(idEstoque),
        constraint foreign key fk_prodest_produto(idProduto_prodest) references produto(idProduto),
        Quantidade int default 1
        
        );
        
        insert into cliente_pf (idClient_PF, Nome,CPF,Endereço,Forma_de_Pagamento,Data_de_Nascimento) values 
			(1, 'João Augusto', '45689578541', 'Rua Azul', 'pix', '1987-10-01'),
            (2, 'Maria Antonia', '5689547558', 'Rua Vermelha', 'débito', '2000-11-03');
            
            
		insert into cliente_pj (idClient_PJ, Razão_Social,Endereço,Forma_de_Pagamento) values 
			(1, 'Havianas', 'Rua Rosa', 'crédito'),
            (2, 'Rider', 'Rua Verde', 'crédito');
            
            
		insert into pedido (idPedido, Status_do_Pedido, Descrição, Frete) values 
			(1, 'Em Processamento', 'Compra de produto x', 100.50),
            (2, 'Em Processamento', 'Compra de produto y', 50.25);
            
		insert into produto (idProduto, Nome, Classificação_Infantil, Descrição, Categoria, avaliação, dimensão, valor) values 
			(1, 'produto x',True,'brinquedo','utensilios infantis',4.5,null, 100),
            (2, 'produto y',False,'ferramenta','manutenção',3.5,null, 400);
            
            
		insert into estoque (idEstoque, Local_estoque, Quantidade) values 
			(1, 'Endereço A2', 12),
            (2, 'Endereço B4', 20);
            
            
		insert into fornecedor (idFronecedor, Razão_Social,CNPJ,Contato,Nome_fantasia,Endereço) values 
			(1, 'Produtos EXLS', '456985484585698','56987521','D fornecimento','Rua Laranja'),
            (2, 'HLS Ouros', '566325141511','87512523','Despachos SA','Rua Cinza');
            
            
		insert into vendedor (idVendedorterceiro, Razão_Social,CNPJ,Contato,Nome_fantasia,Endereço) values 
			(1, 'Brinquedos 123', '563145621452','12345678','Di Happy','Rua Azul'),
            (2, 'Arcos Azuis', '562185562','87654321','Work fruit','Rua Vermelha');
		
        insert into entrega (idEntrega, Status , Código_Rastreio) values 
			(1, 'Em processo', 12354555),
            (2, 'postado', 8569215);
            
		insert into produto_marketplace (idPSeller,
        idProduto_mkt, Quantidade) values 
			(1, 1, 12354555),
            (2, 2, 8569215);
            
            
		insert into produto_fornecedor (idFornecedor_prodfor, idProduto_prodfor) values 
			(1, 1),
            (2, 2);
            
		insert into produto_pedido (idPedido_prodped, idProduto_prodped, Quantidade, Status_Pedido) values 
			(1, 1, 30, 'Disponível'),
            (2, 2, 5, 'Disponível');
            
		insert into produto_estoque (idEstoque_prodest, idProduto_prodest, Quantidade) values 
			(1, 1, 12),
            (2, 2, 15);
            
		select * from vendedor;
        
        select * from cliente_pj;
            
		select t1.Nome, t1.CPF, t2.Razão_Social, t2.Endereço
        from cliente_pf AS t1
		join cliente_pj AS t2
		