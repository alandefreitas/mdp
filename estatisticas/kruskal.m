function [ T, p ] = kruskal( tabela , sucesso )
%KRUSKAL rebece tabela(j replica��es X i tratamentos) e outra tabela "sucesso" que descreve em quais elementos utilizar o teste

%% organiza as tabela em 2D se necess�rio
if (size(size(tabela),2)==4)
    tabela = d4tod2(tabela);
    sucesso = d4tod2(sucesso==1);
end

%% rankeia todas as amostras v�lidas
v = size(tabela,2); % n�mero de tratamentos
r = sum(sucesso); %n de replica��es onde sucesso = 1 para cada tratamento
N = sum(r); %n�mero de amostras v�lidas
ranking = zeros(size(tabela,1),size(tabela,2)); %ranking de cada elemento
for i = 1:size(tabela,1)
    for j = 1:size(tabela,2)
        if (sucesso(i,j) == 1)
            ranking(i,j) = 1 + sum(sum(tabela(i,j)>tabela));
        end
    end
end

%% calcula ranking m�dio de cada tratamento nas replica��es v�lidas
somaranking = sum(ranking); % R_i
% se os efeitos de tratamento s�o iguais, a m�dia deve ser igual
mediaranking = somaranking./N; % \overline{R_i}
mediageral = mean(mediaranking); % \overline{R}

%% Retorna
somatorio = 0;
for i=1:v
    somatorio = somatorio + r(i) * (mediaranking(i)-mediageral)^2;
end
T = 12/(N*(N+1)) * somatorio;

p = 1 - gammainc(T/2,(v-1)/2);

end