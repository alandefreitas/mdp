function [ tabela ] = d4tod2( tabela_temp )
%4DTO2D Transformada tabela (replicacao, instancia, mu, lambda) em tabela (replicacao, tratamento)

%Forma a tabela utilizada no teste
%tabela_temp = sucesso==1;
tabela = zeros(size(tabela_temp,1)*size(tabela_temp,2),size(tabela_temp,3)*size(tabela_temp,4));
posi=1;
posj=1;
for i1=1:size(tabela_temp,1)
    for i2=1:size(tabela_temp,2)
        for i3=1:size(tabela_temp,3)
            for i4=1:size(tabela_temp,4)
                tabela(posi,posj) = tabela_temp(i1,i2,i3,i4);
                posj = posj+1;
            end
        end
        posj = 1;
        posi = posi+1;
    end
end

end

