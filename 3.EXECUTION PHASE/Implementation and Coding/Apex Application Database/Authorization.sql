--Authorization schema for admin (PL/SQL Function returning Boolean)
if :GET_ROLE = 'A' then
return TRUE;
else
return FALSE;
end if;
/

--Authorization schema for trader
if :GET_ROLE = 'T' then
return TRUE;
else
return FALSE;
end if;