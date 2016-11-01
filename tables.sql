-- -----------------------------------------------------
-- Table Fornecedor
-- -----------------------------------------------------
DROP TABLE IF EXISTS Fornecedor ;

CREATE TABLE IF NOT EXISTS Fornecedor (
  ID_fornecedor INT NOT NULL,
  nome VARCHAR(45) NULL,
  logradouro VARCHAR(45) NULL,
  numero INT NULL,
  cep INT NULL,
  email VARCHAR(45) NULL,
  representante VARCHAR(45) NULL,
  Funcionario_ID_func INT NOT NULL,
  PRIMARY KEY (ID_fornecedor),
  
);


-- -----------------------------------------------------
-- Table Cep_cidade
-- -----------------------------------------------------
DROP TABLE IF EXISTS Cep_cidade ;

CREATE TABLE IF NOT EXISTS Cep_cidade (
  cep INT NOT NULL,
  cidade VARCHAR(45) NULL,
  estado VARCHAR(45) NULL,
  Fornecedor_ID_fornecedor INT NOT NULL,
  Fornecedor_Cep_cidade_cep INT NOT NULL,
  PRIMARY KEY (cep),
    FOREIGN KEY (Fornecedor_ID_fornecedor)
    REFERENCES Fornecedor (ID_fornecedor)
);

-- -----------------------------------------------------
-- Table Funcionario
-- -----------------------------------------------------
DROP TABLE IF EXISTS Funcionario ;

CREATE TABLE IF NOT EXISTS Funcionario (
  ID_func INT NOT NULL,
  Nome VARCHAR(45) NOT NULL,
  logradouro VARCHAR(45) NULL,
  numero INT NULL,
  cep INT NULL,
  area VARCHAR(45) NULL,
  sexo VARCHAR(45) NULL,
  bairro VARCHAR(45) NULL,
  ID_almoxarife INT NOT NULL,
  Cep_cidade_cep INT NOT NULL,
  eh_almoxarife INT NULL,
  PRIMARY KEY (ID_func),
    FOREIGN KEY (ID_almoxarife)
    REFERENCES Funcionario (ID_func)
,
    FOREIGN KEY (Cep_cidade_cep)
    REFERENCES Cep_cidade (cep)
)
;

-- -----------------------------------------------------
-- Table Info_Material
-- -----------------------------------------------------
DROP TABLE IF EXISTS Info_Material ;

CREATE TABLE IF NOT EXISTS Info_Material (
  tipo INT NULL,
  origem VARCHAR(45) NULL,
  temp_conserv VARCHAR(45) NULL,
  formula VARCHAR(45) NULL,
  eh_quimico INT NULL,
  eh_biologico INT NULL,
  ID_material INT NOT NULL,
  PRIMARY KEY (ID_material))
;

-- -----------------------------------------------------
-- Table Material
-- -----------------------------------------------------
DROP TABLE IF EXISTS Material ;

CREATE TABLE IF NOT EXISTS Material (
  ID_material INT NOT NULL,
  nome VARCHAR(45) NULL,
  preco VARCHAR(45) NULL,
  validade VARCHAR(45) NULL,
  Info_Material_ID_material INT NOT NULL,
  PRIMARY KEY (ID_material, Info_Material_ID_material),
    FOREIGN KEY (Info_Material_ID_material)
    REFERENCES Info_Material (ID_material)
)
;

-- -----------------------------------------------------
-- Table Requisicao
-- -----------------------------------------------------
DROP TABLE IF EXISTS Requisicao ;

CREATE TABLE IF NOT EXISTS Requisicao (
  setor INT NULL,
  data DATE NULL,
  ID_req VARCHAR(45) NOT NULL,
  Funcionario_ID_func INT NOT NULL,
  PRIMARY KEY (ID_req),
    FOREIGN KEY (Funcionario_ID_func)
    REFERENCES Funcionario (ID_func)
)
;

-- -----------------------------------------------------
-- Table Item_lista_req
-- -----------------------------------------------------
DROP TABLE IF EXISTS Item_lista_req ;

CREATE TABLE IF NOT EXISTS Item_lista_req (
  seq_item INT NOT NULL,
  quantidade INT NULL,
  Requisicao_ID_req VARCHAR(45) NOT NULL,
  Material_ID_material INT NOT NULL,
  Material_Info_Material_ID_material INT NOT NULL,
  PRIMARY KEY (seq_item, Requisicao_ID_req),
    FOREIGN KEY (Requisicao_ID_req)
    REFERENCES Requisicao (ID_req)
,
    FOREIGN KEY (Material_ID_material , Material_Info_Material_ID_material)
    REFERENCES Material (ID_material , Info_Material_ID_material)
)
;

-- -----------------------------------------------------
-- Table Entrada
-- -----------------------------------------------------
DROP TABLE IF EXISTS Entrada ;

CREATE TABLE IF NOT EXISTS Entrada (
  total INT NULL,
  data DATE NULL,
  ID_entrada VARCHAR(45) NOT NULL,
  Fornecedor_ID_fornecedor INT NOT NULL,
  PRIMARY KEY (ID_entrada, Fornecedor_ID_fornecedor),
    FOREIGN KEY (Fornecedor_ID_fornecedor)
    REFERENCES Fornecedor (ID_fornecedor)
)
;
-- -----------------------------------------------------
-- Table Item_lista_ent
-- -----------------------------------------------------
DROP TABLE IF EXISTS Item_lista_ent ;

CREATE TABLE IF NOT EXISTS Item_lista_ent (
  seq_item INT NOT NULL,
  quantidade INT NULL,
  Entrada_ID_entrada VARCHAR(45) NOT NULL,
  Material_ID_material INT NOT NULL,
  Material_Info_Material_ID_material INT NOT NULL,
  PRIMARY KEY (seq_item, Entrada_ID_entrada),
    FOREIGN KEY (Entrada_ID_entrada)
    REFERENCES Entrada (ID_entrada)
,
    FOREIGN KEY (Material_ID_material , Material_Info_Material_ID_material)
    REFERENCES Material (ID_material , Info_Material_ID_material)
)
;
-- -----------------------------------------------------
-- Table Tel_func
-- -----------------------------------------------------
DROP TABLE IF EXISTS Tel_func ;

CREATE TABLE IF NOT EXISTS Tel_func (
  telefone INT NULL,
  Funcionario_ID_func INT NOT NULL,
    FOREIGN KEY (Funcionario_ID_func)
    REFERENCES Funcionario (ID_func)
)
;

-- -----------------------------------------------------
-- Table Tel_fornec
-- -----------------------------------------------------
DROP TABLE IF EXISTS Tel_fornec ;

CREATE TABLE IF NOT EXISTS Tel_fornec (
  telefone INT NOT NULL,
  Fornecedor_ID_fornecedor INT NOT NULL,
  PRIMARY KEY (telefone),
    FOREIGN KEY (Fornecedor_ID_fornecedor)
    REFERENCES Fornecedor (ID_fornecedor)
)
;

-- -----------------------------------------------------
-- Table Almoxarife
-- -----------------------------------------------------
DROP TABLE IF EXISTS Almoxarife ;

CREATE TABLE IF NOT EXISTS Almoxarife (
  total_horas INT NULL,
  Funcionario_ID_func INT NOT NULL,
  PRIMARY KEY (Funcionario_ID_func),
    FOREIGN KEY (Funcionario_ID_func)
    REFERENCES Funcionario (ID_func)
)
;

-- -----------------------------------------------------
-- Table Local_armazenamento
-- -----------------------------------------------------
DROP TABLE IF EXISTS Local_armazenamento ;

CREATE TABLE IF NOT EXISTS Local_armazenamento (
  setor INT NOT NULL,
  nome VARCHAR(45) NOT NULL,
  PRIMARY KEY (setor, nome))
;

-- -----------------------------------------------------
-- Table Trabalha
-- -----------------------------------------------------
DROP TABLE IF EXISTS Trabalha ;

CREATE TABLE IF NOT EXISTS Trabalha (
  Local_armazenamento_setor INT NOT NULL,
  Local_armazenamento_nome VARCHAR(45) NOT NULL,
  Almoxarife_Funcionario_ID_func INT NOT NULL,
  turno VARCHAR(45) NULL,
  PRIMARY KEY (Local_armazenamento_setor, Local_armazenamento_nome, Almoxarife_Funcionario_ID_func),
    FOREIGN KEY (Local_armazenamento_setor , Local_armazenamento_nome)
    REFERENCES Local_armazenamento (setor , nome)
,
    FOREIGN KEY (Almoxarife_Funcionario_ID_func)
    REFERENCES Almoxarife (Funcionario_ID_func)
)
;

-- -----------------------------------------------------
-- Table Armazena
-- -----------------------------------------------------
DROP TABLE IF EXISTS Armazena ;

CREATE TABLE IF NOT EXISTS Armazena (
  Local_armazenamento_setor INT NOT NULL,
  Local_armazenamento_nome VARCHAR(45) NOT NULL,
  Material_ID_material INT NOT NULL,
  quantidade INT NULL,
  PRIMARY KEY (Local_armazenamento_setor, Local_armazenamento_nome, Material_ID_material),
    FOREIGN KEY (Local_armazenamento_setor , Local_armazenamento_nome)
    REFERENCES Local_armazenamento (setor , nome)
,

    FOREIGN KEY (Material_ID_material)
    REFERENCES Material (ID_material)
)
;
ALTER TABLE Fornecedor (
	ADD FOREIGN KEY (Funcionario_ID_func)
  REFERENCES  Funcionario  (ID_func)
	)
;
