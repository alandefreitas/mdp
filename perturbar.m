function sel = perturbar( problema, sel, perturbacao )
%PERTURBACAO Summary of this function goes here
%   Detailed explanation goes here

if (perturbacao ~= -1)
    num_trocas = ceil(problema.m*perturbacao);
else
    num_trocas = 1;
end

m_trocas = zeros(1,num_trocas);
n_trocas = zeros(1,num_trocas);


%Sorteia n�meros da solu��o
k = 1;
while (k <= num_trocas)
    %Sorteia n�mero que est� na solu��o
    m_trocas(k) = sel(ceil(double(rand())*problema.m));
    %Se o n�mero j� estiver na solu��o, k n�o avan�a
    if (sum(m_trocas(k) == m_trocas) < 2)
        k = k + 1;
    end        
end

%Sorteia n�meros fora da solu��o
k = 1;
while (k<=num_trocas)
    %Sorteia n�mero que est� na solu��o
    n_trocas(k) = ceil(double(problema.n)*rand());
    %Se o n�mero j� (estiver na solu��o) ou for do (conjunto dos selecionados), k n�o avan�a
    if ((sum(n_trocas(k) == n_trocas) < 2)&&(sum(n_trocas(k) == sel) == 0))
        k = k + 1;
    end     
end

clear k;

m_trocas = sort(m_trocas);
n_trocas = sort(n_trocas);

%%Remove os selecionados
pos = 1;
for i=1:num_trocas
    for j = pos:problema.m
        if (sel(j) == m_trocas(i))
            sel(j) = 0;
            pos = j + 1;
            break;
        end
    end
end

%%Insere os novos

pos = 1;
for i=1:num_trocas
    for j = pos:problema.m
        if (sel(j) == 0)
            sel(j) = n_trocas(i);
            pos = j + 1;
            break;
        end
    end
end

sel = sort(sel);