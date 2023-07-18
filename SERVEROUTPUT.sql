SET SERVEROUTPUT ON;
DECLARE
v_Str VARCHAR2(100); -- 변수선언
BEGIN
    v_Str := '값할당';
    IF 1 = 2 THEN
        DBMS_OUTPUT.PUT_LINE('조건이 TRUE'); -- SYSO
    ELSIF 2 = 2 THEN
        DBMS_OUTPUT.PUT_LINE(v_Str);
    ELSE
        DBMS_OUTPUT.PUT_LINE('조건이 FALSE');
    END IF;
END;