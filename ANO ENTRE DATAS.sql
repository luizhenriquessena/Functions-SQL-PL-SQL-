create or replace function ANOSENTREDATAS(DATAI in date, DATAF in date)

return integer is

ANOS integer;

begin

if DATAI is null then
   return(0);
end if;

if DATAF is null then
   return(0);
end if;

SELECT TRUNC((trunc(MONTHS_BETWEEN(DATAF, DATAI))) / 12) INTO ANOS
  FROM DUAL;


RETURN ANOS;

end;


 
