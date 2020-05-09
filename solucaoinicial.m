function s = solucaoinicial( problema )
%elementos de maior diversidade em relação a cada elemento i.
%as diversidades são somadas
%Os elementos com maior diversidade acumulada compõe a solução

dist = zeros(1,problema.n);

for i=1:problema.n
    sorted = sort(problema.matriz(i,:));
    dist(i) = sum(sorted((problema.n-problema.m+1):problema.n));
end

[sorted,pos] = sort(dist);

s = pos((problema.n-problema.m+1):problema.n);

end

