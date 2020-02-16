create or replace function 
SCOTT.fn104 (n1 number, n2 number, n3 number, n4 number, n5 number)
return number
is
  mayor number := 0;
begin
  if (n1> mayor) then
    mayor := n1;
  end if;
  if (n2>mayor) then
    mayor := n2;
  end if;
  if (n3>mayor) then
    mayor := n3;
  end if;
  if (n4>mayor) then
    mayor := n4;
  end if;
  if (n5>mayor) then
    mayor := n5;
  end if;
  return mayor;
end;
/

select SCOTT.fn104(-12,-52,-58,-54,-68) from dual;



