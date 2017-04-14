nrows=input('Please enter the number of rows: ');
J=1;

trials=2000;
Temp=zeros(1,71);
Magn=zeros(trials,71);
Energy=zeros(trials,71);

runs=4000;
for T=0:0.10:7
    spinarr=randi(2,nrows)*2-3;
    for i=1:trials+runs
        randcol=randi(nrows,1);
        randrow=randi(nrows,1);
        r=rand;
        if (randcol==1)
            coll=nrows;
        else
            coll=randcol-1;
        end
        if (randcol==nrows)
            colr=1;
        else
            colr=randcol+1;
        end
        if (randrow==1)
            rowd=nrows;
        else
            rowd=randrow-1;
        end
        if (randrow==nrows)
            rowu=1;
        else
            rowu=randrow+1;
        end
        deltaE=J*2*(spinarr(randrow,randcol)*(spinarr(randrow,coll)+spinarr(randrow,colr)+spinarr(rowu,randcol)+spinarr(rowd,randcol)));
        if (deltaE<=0)
            spinarr(randrow,randcol)=-spinarr(randrow,randcol);
        else
            p=exp(-deltaE/T);
            if (p>=r)
                spinarr(randrow,randcol)=-spinarr(randrow,randcol);
            else
                spinarr(randrow,randcol)=spinarr(randrow,randcol);
            end
        end
        if (i>runs)
           mag=sum(sum(spinarr)); %M=u*Sum(s) so I sum all the spins first columns then the resulting row matrix
           absmag=abs(mag); %take the abolute value of the magnetization so 
           indexm = round(10*T+1); 
           indexn = round(i-runs);
           Magn(indexn,indexm) = absmag;
           Arl=spinarr.*circshift(spinarr,[0,-1]); % Calculates the interacton in the right-left direction --changed x, y stays constant 
           Adu= spinarr.*circshift(spinarr,[-1,0]); % Calcuates the interaction in the down-up direction --changed y, x sta \[AliasDelimiter]ys constant
           Etot=-J*(sum(sum(Arl))+sum(sum(Adu)));
           Energy(indexn,indexm)=Etot;
        end
    end
    Index=round(10*T+1);
    Temp(Index) = T;
end
Temp;
energy=(1/trials)*sum(Energy);
magn=(1/trials)*sum(Magn);
figure;
S(1) = subplot(2,1,1);
S(2) = subplot(2,1,2);
x=0:0.1:7;
pEnergy=polyfit(Temp,energy,4);
pMag=polyfit(Temp,magn,4);
yEnergy=polyval(pEnergy,x);
yMag=polyval(pMag,x);
plot(S(1),Temp,energy,'o',x,yEnergy)
title(S(1),'2D Energy vs. Temperature')
xlabel(S(1),'Temperature (J/k)')
ylabel(S(1),'Energy')
plot(S(2),Temp,magn,'o',x,yMag)
title(S(2),'2D Magnetization vs. Temperature')
xlabel(S(2),'Temperature (J/k)')
ylabel(S(2),'Magnetization')