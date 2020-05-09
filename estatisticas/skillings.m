function [ T, p ] = skillings( tabela, sucesso )
%skillings (tabela (blocos, tratamentos), sucesso)
%   Teste para blocos incompletos parcialmente balanceados
%   Recebe uma tabela com (blocos X tratamentos)
%   Quando os blocos influenciam os valores, teste de Friedman � usado
%   Quando h� muitos blocos e n�o � poss�vel homogeneidade, usa-se durbin
%       durbin = friedman para blocos incompletos
%   A fun��o precisa de uma tabela sucesso com 0s e 1s
%       0 indica falha e 1 a amostra foi bem suscedida
%   Testa-se de os efeitos dos tratamentos s�o iguais
%   Para usar este teste, os blocos faltantes devem estar balanceados
%       Cada bloco tem o mesmo n�mero de amostras

if (size(size(tabela),2)==4)
    tabela = d4tod2(tabela);
    sucesso = d4tod2(sucesso==1);
end


v = size(tabela,2); % n� de tratamentos
b = size(tabela,1); % n� de blocos
if nargin<2
    sucesso = ones(b,v);
end
r = zeros(1,v);
for j=1:v
    r(j) = sum(sucesso(:,j)); %r = replica��es de cada tratamento
end
k = zeros(1,b);
for i=1:b
    k(i) = sum(sucesso(i,:)); %k = replica��es de cada bloco
end
tabela = tabela';
sucesso = sucesso';

%ordenar todas as observa��es em uma coluna (bloco)
%R(i,j) = rank da observa��o do i� tratamento no bloco j desconsiderando os
%pontos onde sucesso == 0
R = zeros(size(tabela,1),size(tabela,2));
for i=1:size(tabela,1)
    for j=1:size(tabela,2)
        if (sucesso(i,j) == 1)
           R(i,j) = 1 + sum(sum(tabela(i,j)>tabela(:,j)));
        else
           R(i,j) = (k(j)+1)/2;
        end
    end
end

%TABELA(TRATAMENTOS,BLOCOS)
% Baseado em R, calcular a soma de tratamento ajustada
A = zeros(1,v);
for i=1:v
    A(i) = sum((12./(k+1)).^(1/2) .* (R(i,:) - (k + 1)./2));
end


%alpha(i,j) = n� de blocos cont�m observa��es para tratamentos i e j
alpha = zeros(v,v);
%tratamento1
for i=1:v
    %tratamento2
    for j=1:v
        %se tratamento1 e tratamento2 tem valores
        alpha(i,j) = sum(sucesso(:,i).*sucesso(:,j));
    end
end

%sigma(i,j) = -alpha(i,j) se 1<i?j<=v ou
%           = sum(alpha(i,[1:(i-1),(i+1):v]))
sigma = zeros(v,v);
%tratamento1
for i=1:v
    %tratamento2
    for j=1:v
        if (i~=j)
            sigma(i,j) = -alpha(i,j);
        else
            sigma(i,j) = sum(alpha(i,[1:(i-1),(i+1):v]));
        end
    end
end



%Para testar a hip�tese de que os efeitos dos tratamentos s�o iguais
T = A*pinv(sigma)*A';

p = 1 - gammainc(T/2,(v-1)/2);

end

