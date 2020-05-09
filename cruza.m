function z = cruza( problema, sol1 , sol2 )

n = size(sol1,2);
j=1;
z = zeros(1,n);
pos = 1;

%para cada elemento de sol1
for i=1:n
    %j vai até o elemento de sol2 maior que i
    while (sol2(j)<sol1(i))
        j = j + 1;
        if (j>n)
            break; 
        end
    end
 
    if (j<=n)
        if (j==i)
            z(pos) = sol1(i);
            pos = pos + 1;
        end
    else
        break;
    end
end

listarand = randperm(n);
i = 1;
pai = ceil(rand()*2);

while (pos<=n)
    %coloca o elemento
    if (pai == 1)
        z(pos) = sol1(listarand(i));
    else
        z(pos) = sol2(listarand(i));
    end
    %se ele já está na lista
    if (sum(z(pos) == z(1:(pos-1))) > 0)
        %troca de pai e tenta
        pai = mod(pai + 1,2);
        if (pai == 1)
            i = i + 1;
            z(pos) = sol1(listarand(i));
        else
            z(pos) = sol2(listarand(i));
        end
        %se ele ainda está na lista
        if (sum(z(pos) == z(1:(pos-1))) > 0)
            if (pai == 1)
                pai = mod(pai+1,2);
            else
                pai = mod(pai+1,2);
                i = i+1;
            end 
        end
    else
        pos = pos + 1;
    end
end

