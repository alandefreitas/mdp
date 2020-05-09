function s_star = buscalocal( problema, s, tipo )
%BUSCALOCAL Summary of this function goes here
%   Detailed explanation goes here

if (tipo == 1)
    s_star = buscabi(problema, s);
elseif (tipo == 2)
    s_star = buscafi(problema,s);
elseif (tipo == 3)
    s_star = buscarandomica(problema,s);
elseif (tipo == 4)
    if (rand() > 0.3)
        s_star = buscafi(problema, s);
    else
        s_star = buscarandomica(problema,s);
    end
else
    s_star = s;
end

end

