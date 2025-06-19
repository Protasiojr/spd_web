-- Tabela de usuários
CREATE TABLE IF NOT EXISTS usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo ENUM('admin', 'usuario') DEFAULT 'usuario',
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de administração
CREATE TABLE IF NOT EXISTS administracao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    taxa_anuncio DECIMAL(10,2) DEFAULT 0.00,
    taxa_estabelecimento DECIMAL(10,2) DEFAULT 0.00,
    atualizado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabela de estabelecimentos
CREATE TABLE IF NOT EXISTS estabelecimento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(255),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

-- Tabela de anúncios
CREATE TABLE IF NOT EXISTS anuncio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    link_youtube VARCHAR(255) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

-- Tabela de pagamentos
CREATE TABLE IF NOT EXISTS pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    anuncio_id INT,
    estabelecimento_id INT,
    valor DECIMAL(10,2) NOT NULL,
    tipo ENUM('anuncio', 'estabelecimento', 'comissao') NOT NULL,
    data_pagamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (anuncio_id) REFERENCES anuncio(id),
    FOREIGN KEY (estabelecimento_id) REFERENCES estabelecimento(id)
);

-- Tabela de relatórios (visão consolidada)
CREATE TABLE IF NOT EXISTS relatorio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    estabelecimento_id INT,
    anuncio_id INT,
    pagamento_id INT,
    data_geracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id),
    FOREIGN KEY (estabelecimento_id) REFERENCES estabelecimento(id),
    FOREIGN KEY (anuncio_id) REFERENCES anuncio(id),
    FOREIGN KEY (pagamento_id) REFERENCES pagamento(id)
);
