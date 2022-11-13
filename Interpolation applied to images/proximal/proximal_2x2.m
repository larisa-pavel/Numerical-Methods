function out = proximal_2x2(f, STEP)
    % ===================================================================================
    % Aplic Interpolare Proximala pe imaginea 2 x 2 f cu puncte intermediare echidistante.
    % f are valori cunoscute în punctele (1, 1), (1, 2), (2, 1) ?i (2, 2).
    % Parametrii:
    % - f = imaginea ce se va interpola;
    % - STEP = distanta dintre doua puncte succesive.
    % ===================================================================================
    
    % Definesc coordonatele x_int si y_int ale punctelor intermediare.
    x_int(1)=1;
    y_int(1)=1;
    i=1;
    while(x_int(i)<2-0.00001)
      x_int(i+1)=x_int(i)+STEP;
      y_int(i+1)=y_int(i)+STEP;
      i=i+1;
    end
    n = length(x_int);
    A=eye(n,n);
    % Se parcurge fiecare pixel din imaginea finala.
    for i = 1 : n
        for j = 1 : n
            % Aflu cel mai apropiat pixel din imaginea initiala.
            dif_x1=0;
            dif_x2=0;
            dif_y1=0;
            dif_y2=0;

            dif_x1=x_int(i)-1;
            dif_x2=2.00000-x_int(i);
            dif_y1=y_int(j)-1;
            dif_y2=2.00000-y_int(j);
            %in if-uri am mai adaugat un 0.000001 pentru cazul in care
            %diferenta era egala, deoarece imi lua ca e mai aproape de 
            %2 in loc de 1
            if(dif_x1+0.000001<dif_x2)
                dif_x1=1;
                dif_x2=0;
            else
                dif_x2=1;
                dif_x1=0;
            end
            if(dif_y1+0.000001<dif_y2)
                dif_y1=1;
                dif_y2=0;
            else
                dif_y2=1;
                dif_y1=0;
            end
            % Calculez pixelul din imaginea finala.
            if(dif_x1==1&&dif_y1==1)
                A(i,j)=f(1,1);
            end
            if(dif_x1==1&&dif_y2==1)
                A(i,j)=f(1,2);
            end
            if(dif_x2==1&&dif_y1==1)
                A(i,j)=f(2,1);
            end
            if(dif_x2==1&&dif_y2==1)
                A(i,j)=f(2,2);
            end
        end
    end
out=A;
end