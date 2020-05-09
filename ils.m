function [s_star,fo_star] = ils( problema , busca, meta, tempo_max)
%ILS Summary of this function goes here
%   Detailed explanation goes here


tic;

s = solucaoinicial(problema);

%7 níveis de perturbação
if (problema.n > 50)
    perturbacao = [0.2,0.10,0.40,0.50,0.70,0.80,1/problema.n];
else
    perturbacao = [0.2,0.10,0.40,0.50,0.70,0.80];
end

%%Busca local = 1BI 2FI 3Randômica
if (nargin < 2)
    busca = 1;
else
if (nargin < 3)
    meta = 1;
end
if (nargin < 4)
    tempo_max = inf;
end

s = buscalocal(problema, s, busca);

s_star = s;
fo_star = fo(problema,s_star);

iter = 1;

%%caso não haja meta são n iterações sem melhora
while ((iter < problema.n*100)&(fo_star<problema.fo_max*meta)&(toc < tempo_max))

    if (mod(iter,50)==0)
        disp(['Iteração ', num2str(iter), ',  Meta em ', num2str(fo_star/problema.fo_max)]);
    end
    
    %Faz uma das perturbações possíveis em s_star
    s = perturbar(problema, s_star, perturbacao(ceil(rand()*(size(perturbacao,2)))));
    
    %1 BI 2 FI 3 Randômico
    s = buscalocal(problema, s, busca);
    fo_s = fo(problema,s);
    
    %Critério de aceitação 
    if (fo_star<fo_s)
        s_star = s;
        fo_star = fo_s;
        %iter = 0;
    end

    iter = iter + 1;
    
end

if (fo_star/problema.fo_max == 1)
    disp('O ótimo foi encontrado!');
else
    disp('O ótimo NÃO foi encontrado!');
end
end

