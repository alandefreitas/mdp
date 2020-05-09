function [s_star,delta_star] = buscarandomica( problema, sel)

havendomelhora = 0;
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



while (havendomelhora < ceil(3*problema.n))
    
    break2 = false;
    
    %Sorteia elemento de i e de j
    i = ceil(rand() * double(problema.m));
    j = ceil(rand() * (double(problema.n) - double(problema.m)));
    delta = diferencafo(problema, sel, sel(i), nsel(j));
    if (delta > 0)
        elemm = i;
        elemn = j;
        
        havendomelhora = 0;
        
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
    
    havendomelhora = havendomelhora + 1;
    
end


end

