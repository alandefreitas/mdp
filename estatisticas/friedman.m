function [ T, p ] = friedman( tabela )
%Realiza teste de FRIEDMAN na tabela (blocos X tratamentos)
%
% Em alguns casos algum fator que não é de interesse altera muito a
% variabilidade do experimento. Vários níveis deste fator (como diferentes instâncias) 
% são usados para blocagem.
%
% tabela(j,i) = média + efeito do tratamento + efeito do bloco + erro
% testa-se se o efeito do tratamento é igual

% organiza as tabela em 2D se necessário
if (size(size(tabela),2)==4)
    tabela = d4tod2(tabela);
end

v = size(tabela,2); % nº de tratamentos
b = size(tabela,1); % nº de blocos
N = v*b; % N = nº de unidades experimentais

% colocar observações em v linhas e b colunas
tabela = tabela';

%ordenar todas as observações em uma coluna (bloco)
%R(i,j) = rank da observação do iº tratamento no bloco j
R = zeros(size(tabela,1),size(tabela,2));
for j=1:size(tabela,2)
[~,R(:,j)] = sort(tabela(:,j));
end
%1<R(i,j)<v
% Soma de ranks de cada bloco = v*(v+1)/2
% rank médio de cada bloco = (v+1)/2
% variancia (v^2-1)/12
% soma de cada tratamento i = sum(R(i,:))
% média de cada tratamento i = mean(R(i,:))  % R_i

% Se o efeito dos tratamentos (agora linhas) são iguais, espera-se que R_i
% seja igual a b*(v+1)/2

%Teste final
S = 0;
for i=1:v
    S = S + (sum(R(i,:)) - (b*(v+1))/2)^2;
end
T = (12*S)/(b*v*(v+1));

p = 1 - gammainc(T/2,(v-1)/2);
    
end

