function [s_star,delta_star] = buscafi( problema, sel )

havendomelhora = true;
s_star = sel;
delta_star = 0;

sel = sort(sel);

%Faz a lista dos elementos não selecionados
nsel = [];
k = 1;
for i=sel;
    nsel = [nsel,k:i-1];
    k = i+1;
end
nsel = [nsel,k:problema.n];



while (havendomelhora)
    
    havendomelhora = false;
    
    break2 = false;
    
    %Para cada elemento selecionado
    for i=1:problema.m
        %Testar a troca com um elemento não selecionado
        for j=1:(problema.n - problema.m)
            delta = diferencafo(problema, sel, sel(i), nsel(j));
            if (delta > 0)
                elemm = i;
                elemn = j;
                break2 = true;
                break;
            end
        end
        if (break2) break; end
    end            
        
    if (delta > 0)
        havendomelhora = true;
        
        %atualiza lista dos selecionados e não selecionados
        aux = nsel(elemn);
        nsel(elemn) = sel(elemm);
        sel(elemm) = aux;
        
        %ordena listas
        nsel = sort(nsel);
        sel = sort(sel);
        
        %atualiza melhor solução
        s_star = sel;
        delta_star = delta;

    end
    
end



end

