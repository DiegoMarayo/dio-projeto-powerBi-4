-- ==========================================
--  SCHEMA: UNIVERSIDADE_DIMENSIONAL
--  FOCO: PROFESSOR
--  MODELO: STAR SCHEMA
-- ==========================================

CREATE DATABASE universidade_dimensional;
USE universidade_dimensional;

-- ===========================
-- DIMENSÕES
-- ===========================

CREATE TABLE dim_professor (
    idProfessor INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    titulacao VARCHAR(45),
    tempoCasa INT,
    regimeTrabalho VARCHAR(45),
    email VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE dim_departamento (
    idDepartamento INT AUTO_INCREMENT PRIMARY KEY,
    nomeDepartamento VARCHAR(100) NOT NULL,
    campus VARCHAR(45),
    coordenador VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE dim_curso (
    idCurso INT AUTO_INCREMENT PRIMARY KEY,
    nomeCurso VARCHAR(100) NOT NULL,
    nivel VARCHAR(45),
    modalidade VARCHAR(45),
    duracao INT
) ENGINE=InnoDB;

CREATE TABLE dim_disciplina (
    idDisciplina INT AUTO_INCREMENT PRIMARY KEY,
    nomeDisciplina VARCHAR(100) NOT NULL,
    cargaHorariaPadrao DECIMAL(5,2),
    tipoDisciplina VARCHAR(45),
    nivelDificuldade VARCHAR(45)
) ENGINE=InnoDB;

CREATE TABLE dim_tempo (
    idTempo INT AUTO_INCREMENT PRIMARY KEY,
    data DATE,
    ano INT,
    semestre INT,
    mes INT,
    trimestre INT,
    nomeMes VARCHAR(20),
    nomeTrimestre VARCHAR(20)
) ENGINE=InnoDB;

-- ===========================
-- TABELA FATO
-- ===========================

CREATE TABLE fato_professor (
    idFatoProfessor INT AUTO_INCREMENT PRIMARY KEY,
    idProfessor INT NOT NULL,
    idCurso INT NOT NULL,
    idDepartamento INT NOT NULL,
    idDisciplina INT NOT NULL,
    idTempo INT NOT NULL,
    qtdAlunos INT,
    cargaHoraria DECIMAL(5,2),
    avaliacaoMedia DECIMAL(3,2),

    CONSTRAINT fk_fato_professor_dim_professor
        FOREIGN KEY (idProfessor) REFERENCES dim_professor(idProfessor)
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_fato_professor_dim_curso
        FOREIGN KEY (idCurso) REFERENCES dim_curso(idCurso)
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_fato_professor_dim_departamento
        FOREIGN KEY (idDepartamento) REFERENCES dim_departamento(idDepartamento)
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_fato_professor_dim_disciplina
        FOREIGN KEY (idDisciplina) REFERENCES dim_disciplina(idDisciplina)
        ON DELETE CASCADE ON UPDATE CASCADE,

    CONSTRAINT fk_fato_professor_dim_tempo
        FOREIGN KEY (idTempo) REFERENCES dim_tempo(idTempo)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

show tables;
show create table fato_professor;

SELECT
  CONSTRAINT_NAME,
  TABLE_NAME,
  COLUMN_NAME,
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'universidade_dimensional'
  AND TABLE_NAME = 'fato_professor'
  AND REFERENCED_TABLE_NAME IS NOT NULL;