INSERT INTO TI.CALENDARIO

SELECT
 CAL.DATA

,TO_CHAR(CAL.DATA,'YYYY/MM') AS ANO_MES

,TO_CHAR(CAL.DATA,'MM/YYYY') AS MES_ANO

,TO_NUMBER(TO_CHAR(CAL.DATA,'DD')) AS Dia

,TO_NUMBER(TO_CHAR(CAL.DATA,'MM')) AS Mes

,TO_NUMBER(TO_CHAR(CAL.DATA,'YYYY')) AS "AnoYYYY"

,UPPER(TO_CHAR(CAL.DATA,'day')) AS "Descr_Dia"

,UPPER(TO_CHAR(CAL.DATA,'Month')) AS "Descr_Mes"

,'01/'||TO_CHAR(CAL.DATA,'MM/YYYY') AS "MES_P"

,LAST_DAY(CAL.DATA) AS "MES_U"

FROM (
SELECT
  (
    TO_DATE(SEQ.MM || SEQ.YYYY, 'MM/YYYY')-1
    -- Subtrai 1 por SEQ.NUM n�o come�ar em zero
  ) + SEQ.NUM AS "DATA" 
    FROM
    (
        SELECT RESULT NUM, 
        TO_CHAR(( -- Data M�nima
            TO_DATE('01/01/1800', 'DD/MM/YYYY')
            ) , 'MM') AS "MM",
        TO_CHAR(( -- Data M�nima
            TO_DATE('01/01/1800', 'DD/MM/YYYY')
            ) , 'YYYY') AS "YYYY"
        FROM
          (
          SELECT ROWNUM RESULT FROM DUAL CONNECT BY LEVEL <= (
                (
                -- Data M�xima
                LAST_DAY(TO_DATE('31/12/2100', 'DD/MM/YYYY'))
                -
                -- Data M�nima
                TRUNC(TO_DATE('01/01/1800', 'DD/MM/YYYY')) -- Sempre primeiro dia do m�s
                ) + 1 -- �ltimo dia do �ltimo ano
            )
          ) -- Quantas sequ�ncias para gerar pelo MAX

    ) SEQ
) CAL
order by 1
