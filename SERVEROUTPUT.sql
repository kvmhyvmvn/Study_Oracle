SET SERVEROUTPUT ON;
DECLARE
v_Str VARCHAR2(100); -- ��������
BEGIN
    v_Str := '���Ҵ�';
    IF 1 = 2 THEN
        DBMS_OUTPUT.PUT_LINE('������ TRUE'); -- SYSO
    ELSIF 2 = 2 THEN
        DBMS_OUTPUT.PUT_LINE(v_Str);
    ELSE
        DBMS_OUTPUT.PUT_LINE('������ FALSE');
    END IF;
END;