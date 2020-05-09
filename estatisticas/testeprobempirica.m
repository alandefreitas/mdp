function testeprobempirica(tempo, sucesso, instancia)

if nargin<3
    instancia = randi(5); 
end
hold off;
str = '   ';
for mu=1:4
    if mu==1
        str(1) = 'b';
    elseif mu==2
        str(1) = 'm';
    elseif mu==3
        str(1) = 'r';
    elseif mu==4
        str(1) = 'k';
    end
    for lambda=1:4
        if lambda==1
            str(2:3) = 'o-';
        elseif lambda==2
            str(2:3) = 'x-';
        elseif lambda==3
            str(2:3) = '+-';
        elseif lambda==4
            str(2:3) = '*-';
        end
        figure(1);
        probempirica(tempo(sucesso(:,instancia,mu,lambda)==1,instancia, mu,lambda),sum(sucesso(:,instancia,mu,lambda)==1)/size(sucesso,1),str);
        hold on;
    end
end
hold off;

end