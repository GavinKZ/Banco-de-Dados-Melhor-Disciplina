-- 1.
DELIMITER // -- Define o caractere delimitador da Stored Procedure, ou seja, onde deve terminar.
CREATE PROCEDURE sp_ListarAutores() -- Cria a Procedure, seguida pelos parâmetros que, nesse caso, não há nenhum.
BEGIN -- Define o início.
    SELECT nome, sobrenome FROM Autor; -- Código contido dentro da Stored Procedure. Seleciona todos os nomes e sobrenomes da tabela "Autor".
END // -- Define o fim, note que está com o caractere delimitador já definido lá em cima. O caractere pradrão é o ";".
DELIMITER ; -- Retorna o caractere delimitador para o padrão.

CALL sp_ListarAutores(); -- "Invoca" a Stored Procedure.

-- 2.
DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN p_categoria VARCHAR(100))
BEGIN
    SELECT titulo FROM Livro 
    WHERE Categoria_ID = (SELECT Categoria_ID FROM Categoria 
    WHERE Nome = p_categoria);
END //
DELIMITER ;

CALL sp_LivrosPorCategoria("Romance");

-- 3.
DELIMITER //
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN p_categoria VARCHAR(100))
BEGIN
    SELECT Categoria_ID AS ID_DA_CATEGORIA , COUNT(*) AS QUANTIDADE_DE_LIVROS FROM Livro 
    WHERE Categoria_ID = (SELECT Categoria_ID FROM Categoria 
    WHERE Nome = p_categoria) GROUP BY Categoria_ID ORDER BY COUNT(Categoria_ID);
END //
DELIMITER ;

CALL sp_ContarLivrosPorCategoria("Autoajuda");

-- 4.
DELIMITER //
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoria_valor VARCHAR(100), OUT tf_livros VARCHAR(30))
BEGIN
    DECLARE verificar INT;
    WITH Selet_ID as (SELECT (select Categoria_ID from categoria where nome = Categoria_valor) as cate_valor)
    SELECT COUNT(*) INTO verificar FROM livro INNER JOIN Selet_ID on cate_valor = Categoria_ID;
    IF verificar > 0 THEN
        SET tf_livros = 'Possui Livros';
    ELSE
        SET tf_livros = 'Não Possui Livros';
    END IF;
END //
DELIMITER ;

CALL sp_VerificarLivrosCategoria('Ciência', @ver);
SELECT @ver as tem_ou_não;

-- 5.
DELIMITER //
CREATE PROCEDURE sp_LivrosAteAno(IN p_lpano INT)
BEGIN
    SELECT Titulo, Ano_Publicacao FROM Livro
    WHERE Ano_Publicacao <= p_lpano;
END //
DELIMITER ;

CALL sp_LivrosAteAno(2004);
