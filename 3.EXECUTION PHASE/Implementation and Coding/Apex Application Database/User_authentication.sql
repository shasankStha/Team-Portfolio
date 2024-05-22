Function user_authentication(P_USERNAME in varchar2, P_PASSWORD in varchar2)
return boolean is
u_id number(6);
BEGIN
select user_id into u_id from "USER" where (upper(Username) = upper(P_USERNAME) or upper(Email) = upper(P_USERNAME)) and Password = password_encrypt(P_PASSWORD);

return TRUE;

exception
    when NO_DATA_FOUND THEN
    return false;
end;
/