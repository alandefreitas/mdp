function delta = diferencafo( problema, sel, elemm, elemn )

delta = 0;

%Distâncias do elemento removido até os outros selecionados * 2
delta = delta - sum(problema.matriz(elemm,sel)) * 2;

%Distâncias do elemento incluso até os outros * 2
delta = delta + sum(problema.matriz(elemn,sel)) * 2;

%Distância do elemento incluso ao removido * 2
delta = delta - problema.matriz(elemm,elemn) * 2;

end

