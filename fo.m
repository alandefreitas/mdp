function soma = fo( problema, m  )

soma = 0;
for i=m
    for j=m
        soma = soma + problema.matriz(i,j);
    end
end

end

