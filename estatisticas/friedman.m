function [ T, p ] = friedman( tabela )
%Realiza teste de FRIEDMAN na tabela (blocos X tratamentos)
%
% Em alguns casos algum fator que n�o � de interesse altera muito a
% variabilidade do experimento. V�rios n�veis deste fator (como diferentes inst�ncias) 
% s�o usados para blocagem.
%
% tabela(j,i) = m�dia + efeito do tratamento + efeito do bloco + erro
% testa-se se o efeito do tratamento � igual

% organiza as tabela em 2D se necess�rio
if (size(size(tabela),2)==4)
    tabela = d4tod2(tabela);
end

v = size(tabela,2); % n� de tratamentos
b = size(tabela,1); % n� de blocos
N = v*b; % N = n� de unidades experimentais

% colocar observa��es em v linhas e b colunas
tabela = tabela';

%ordenar todas as observa��es em uma coluna (bloco)
%R(i,j) = rank da observa��o do i� tratamento no bloco j
R = zeros(size(tabela,1),size(tabela,2));
for j=1:size(tabela,2)
[~,R(:,j)] = sort(tabela(:,j));
end
%1<R(i,j)<v
% Soma de ranks de cada bloco = v*(v+1)/2
% rank m�dio de cada bloco = (v+1)/2
% variancia (v^2-1)/12
% soma de cada tratamento i = sum(R(i,:))
% m�dia de cada tratamento i = mean(R(i,:))  % R_i

% Se o efeito dos tratamentos (agora linhas) s�o iguais, espera-se que R_i
% seja igual a b*(v+1)/2

%Teste final
S = 0;
for i=1:v
    S = S + (sum(R(i,:)) - (b*(v+1))/2)^2;
end
T = (12*S)/(b*v*(v+1));

p = 1 - gammainc(T/2,(v-1)/2);
    
end

