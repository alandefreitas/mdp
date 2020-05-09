function [ T, p ] = gore( tabela, sucesso )
%gore (tabela (tratamentos, blocos, replicacoes), sucesso)
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
    tabela = d4tod3(tabela);
    sucesso = d4tod3(sucesso==1);
end

v = size(tabela,1); %n� de tratamentos
b = size(tabela,2); %n� de blocos
n = zeros(v,b); %n� de replica��es de cada tratamento i no bloco j
for i=1:v
    for j=1:b
        n(i,j) = sum(sucesso(i,j,:));
    end
end
N = sum(sum(n)); %n�mero total de replica��es
p = n/N; %porcentagem do total de replica��es em cada bloco
q = 1./p; %quanto menor � p, maior � q
qi = sum(q,2); %somat�rio de q para cada tratamento
q_star = sum(1./qi); %somat�rio dos 1/qi. Maior quanto menor for qis

% Para os pares (i1,j) e (i2,j) podemos fazer n(i1,j)*n(i2,j) pares de
%   observa��o. 
% Supondo que u(i1,i2,j) � a propor��o destes pares tal que 
u = zeros(v,v,b);
for i1=1:v
    for i2=1:v
        for j=1:b
            u(i1,i2,j) = n(i1,j)*n(i2,j);
        end
    end
end

%u(i) recebe somatorio de u(i,i2,j) onde i2?i
ui = zeros(1,v);
for i1=1:v
    for i2=1:v
        for j=1:b
            if (i1~=i2)
                ui(i1) = ui(i1) + u(i1,i2,j);
            end
        end
    end
end 

%Para testar a hip�tese de que os efeitos dos tratamentos s�o iguais
S1 = 0;
for i=1:v
    S1 = S1 + (ui(i) - (v-1)*b/2)^2/qi(i);
end
S2 = 0;
for i=1:v
    S2 = S2 + (ui(i) - (v-1)*b/2)/qi(i);
end
T = ((12*N)/(v^2))*(S1-S2^2/q_star);

p = 1 - gammainc(T/2,(v-1)/2);

end

