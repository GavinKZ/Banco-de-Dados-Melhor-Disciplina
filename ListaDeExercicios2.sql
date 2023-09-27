-- 1.
DELIMITER // -- Define o caractere delimitador da Stored Procedure, ou seja, onde deve terminar.
CREATE PROCEDURE sp_ListarAutores() -- Cria a Procedure, seguida pelos parâmetros que, nesse caso, não há nenhum.
BEGIN -- Define o início.
    SELECT nome, sobrenome FROM Autor; -- Código contido dentro da Stored Procedure. Seleciona todos os nomes e sobrenomes da tabela "Autor".
END // -- Define o fim, note que está com o caractere delimitador já definido lá em cima. O caractere pradrão é o ";".
DELIMITER ; -- Retorna o caractere delimitador para o padrão.

CALL sp_ListarAutores(); -- "Invoca" a Stored Procedure.
