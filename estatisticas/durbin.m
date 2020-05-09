function [ T, p ] = durbin( tabela, sucesso )
%DURBIN(tabela (blocos, tratamentos)
%   Recebe uma tabela com (blocos X tratamentos)
%   Quando os blocos influenciam os valores, teste de Friedman é usado
%   Quando há muitos blocos e não é possível homogeneidade, usa-se durbin
%       durbin = friedman para blocos incompletos
%   A função precisa de uma tabela sucesso com 0s e 1s
%       0 indica falha e 1 a amostra foi bem suscedida
%   Testa-se de os efeitos dos tratamentos são iguais
%   Para usar este teste, os blocos faltantes devem estar balanceados
%       Cada bloco tem o mesmo número de amostras

if (size(size(tabela),2)==4)
    tabela = d4tod2(tabela);
    sucesso = d4tod2(sucesso==1);
end


v = size(tabela,2); % nº de tratamentos
b = size(tabela,1); % nº de blocos
if nargin<2
    sucesso = ones(b,v);
end
r = zeros(1,v);
for j=1:v
    r(j) = sum(sucesso(:,j)); %r = replicações de cada tratamento
end
r = mean(r);
k = zeros(1,b);
for i=1:b
    k(i) = sum(sucesso(i,:)); %k = replicações de cada bloco
end
k = mean(k);
tabela = tabela';
sucesso = sucesso';

%ordenar todas as observações em uma coluna (bloco)
%R(i,j) = rank da observação do iº tratamento no bloco j desconsiderando os
%pontos onde sucesso == 0
R = zeros(size(tabela,1),size(tabela,2));
for i=1:size(tabela,1)
    for j=1:size(tabela,2)
        if (sucesso == 1)
           R(i,j) = 1 + sum(sum(tabela(i,j)>tabela(:,j)));
        end
    end
end

%Para testar a hipótese de que os efeitos dos tratamentos são iguais
S = 0;
for i=1:v
    S = S + sum(R(i,:))^2;
end
T = ((12*(v-1))/(r*v*(k-1)*(k+1)))*S-(3*r*(v-1)*(k+1))/(k-1);
p = 1 - gammainc(T/2,(v-1)/2);

end

