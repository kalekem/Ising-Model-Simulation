%This program implements the 2-D magnetization Ising model.The simulation uses the
%metropolis algorithm. 

%Prompt the user to enter the number of rows
nrows=input('Please enter the number of rows: ');
J=1;%interaction energy of spins

trials=2000;%number of trials
Temp=zeros(1,71);
Magn=zeros(trials,71);%matrix of zeros to keep values from for loop
Energy=zeros(trials,71); %matrix of zeros for the sum of energies of each spin
runs=4000;%number of runs

%{
Chooses the initial micro state and carries out a flip trial.
It also chooses a random spin inside the lattice and locates the top,
bottom, right and left neighbors
%}
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
        
        %total change in energy, E, if a spin occurred
        deltaE=J*2*(spinarr(randrow,randcol)*(spinarr(randrow,coll)+spinarr(randrow,colr)+spinarr(rowu,randcol)+spinarr(rowd,randcol)));
         %if the total energy, E decreases then accept the flips
        if (deltaE<=0)
            spinarr(randrow,randcol)=-spinarr(randrow,randcol);
        %otherwise,if the energy increases then flip the probability of p = e-(beta delta E).
        else
            p=exp(-deltaE/T);%p, is the probabilty of the energy change, E
            if (p>=r)%accept the flips
                spinarr(randrow,randcol)=-spinarr(randrow,randcol);
            else %reject the flips
                spinarr(randrow,randcol)=spinarr(randrow,randcol);
            end
        end
        %Try more trials (both waiting for equilibrium and taking the data)
        if (i>runs)
           mag=sum(sum(spinarr)); %Sum of all the first column spins and the resulting row matrix
           absmag=abs(mag); %take the abolute value of the magnetization  
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
pEnergy=polyfit(Temp,energy,4);%calculates and plots a best fitting curve for each figure
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