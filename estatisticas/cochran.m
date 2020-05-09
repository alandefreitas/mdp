function [Q,p] = cochran(sucesso)
% Entre com uma tabela (blocos X métodos) com 1 = sucesso e 0 = falha
% Se p é pequeno, há diferença entre os métodos

%Carregue a soluções antes de rodar o script

%Forma a tabela utilizada no teste
tabela_temp = sucesso==1;
tabela = zeros(50,16); posi=1;posj=1;
for i1=1:size(tabela_temp,1)
for i2=1:size(tabela_temp,2)
for i3=1:size(tabela_temp,3)
for i4=1:size(tabela_temp,4)
tabela(posi,posj) = tabela_temp(i1,i2,i3,i4);
posj = posj+1;
end
end
posj = 1;
posi = posi+1;
end
end

%remove linhas com apenas 1 ou apenas 0
n_linhas_tabela = 0;
for i=1:size(tabela,1)
    if (sum(tabela(i,:)==1)~=size(tabela,2))
        if (sum(tabela(i,:)==0)~=size(tabela,2))
        n_linhas_tabela = n_linhas_tabela + 1;
        end
    end
end
tabelab = tabela;
tabela = zeros(n_linhas_tabela,size(tabelab,2));
n_linhas_tabela = 1;
for i=1:size(tabelab,1)
    if (sum(tabelab(i,:)==1)~=size(tabelab,2))
        if (sum(tabelab(i,:)==0)~=size(tabelab,2))
            tabela(n_linhas_tabela, :) = tabelab(i,:);
            n_linhas_tabela = n_linhas_tabela + 1;
        end
    end
end

%Calcula o valor Q
N = sum(sum(tabela));
c = size(tabela,2);
r = size(tabela,1);
somatorio1 = 0;
for j=1:c
    somatorio1 = somatorio1 + sum(tabela(:,j))^2;
end
somatorio2 = 0;
for i=1:r
    somatorio2 = somatorio2 + sum(tabela(i,:))^2;
end
Q = (c*(c-1) * somatorio1 - (c-1) * N^2)/(c*N - somatorio2);
p = 1 - gammainc(Q/2,(c-1)/2);

end