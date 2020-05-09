function converteinstancias(filename,m)
%MAIN Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(filename);
temp = textscan(fid,'%u');
fclose(fid);
temp = temp{1};
n = temp(1);
problema.matriz = zeros(n,n);
for i=1:n
    for j=1:n
        problema.matriz(i,j) = temp((2 + (i-1)*(n) + j));
    end
end
problema.n = n;
problema.m = m;

save(['matrizn', num2str(problema.n), 'm', num2str(problema.m)], 'problema');

end

