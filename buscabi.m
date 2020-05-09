function s_star = buscabi( problema, sel )

havendomelhora = true;
s_star = sel;

sel = sort(sel);

%Faz a lista dos elementos n�o selecionados
nsel = [];
k = 1;
for i=sel;
    nsel = [nsel,k:i-1];
    k = i+1;
end
nsel = [nsel,k:problema.n];



while (havendomelhora)
    havendomelhora = false;
    
    delta_max = 0;
    
    %Para cada elemento selecionado
    for i=1:problema.m
        %Testar a troca com um elemento n�o selecionado
        for j=1:(problema.n - problema.m)
            delta = diferencafo(problema, sel, sel(i), nsel(j));
            if (delta > delta_max)
                delta_max = delta;
                elemm = i;
                elemn = j;
            end
        end
    end            
        
    if (delta_max > 0)
        havendomelhora = true;
        
        %atualiza lista dos selecionados e n�o selecionados
        aux = nsel(elemn);
        nsel(elemn) = sel(elemm);
        sel(elemm) = aux;
        
        %ordena listas
        nsel = sort(nsel);
        sel = sort(sel);
        
        %atualiza melhor solu��o
        s_star = sel;

    end
    
end



end

