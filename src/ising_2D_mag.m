
%USER INTERACTION: The parameters that the User can enter to specify the
%system 
%{
This program implements the 2-D magnetization Ising model.The simulation uses the
metropolis algorithm. 
For our paper we had the following parameters to investigate the critical
temperature 
J=1 
Size of Lattice (nrows) = 25
tempf=5
runs=90000
trials=30000
%}
nrows=input('Please enter lattice size (nrows) '); %Prompt the user to enter the number of rows
spinarr=randi(2,nrows)*2-3; %creates a lattice of just 1s and -1s
runs=input('Please enter the number of runs: '); %Prompt the user to enter the number of runs
trials=input('Please enter the number of trials: '); %Prompt the user to enter the number of trials 
tempf=input('Please enter the Final Temperature Range you wish to investigate: '); %Prompt the user to enter the final temperate 

%Assigned Values that are embeded in the code 
J=1; %The assigned interactino energy of spins 
Temp=zeros(1,tempf*10);
tempinv=zeros(1,tempf*10);
Magn=zeros(trials,tempf*10);
Energy=zeros(trials,tempf*10);
ExpEnergysq=zeros(trials,tempf*10); %Matrix of Zeros for expectation of Energy^2
Magnsq=zeros(trials,tempf*10); %Matrix of zeros for expetation of Magnetization^2
%{
Chooses the initial micro state and carries out a flip trial.
It also chooses a random spin inside the lattice and locates the top,
bottom, right and left neighbors
%}
for T=0:0.10:tempf
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
           Etotsq = Etot^2;
           ExpEnergysq(indexn,indexm)=Etotsq;
           absmagsq=absmag^2; %M^2 
           MagnSq(indexn,indexm)=absmagsq; %Matrix of M^2 values with columns = diff temps and rows = trials
        end
    end
    Index=round(10*T+1);
    Temp(Index) = T;
    tempinv(Index)= 1/T; %row matrix of 1/Ti 
end
Temp;
%The Calculations for Energy, Magnetization, Specific Heat and Magnetic
%Suspetibility are below 
energy=(1/trials)*sum(Energy);
energysq=(1/trials)*sum(ExpEnergysq); %row of matrix of <E^2>
energysq1=energy.*energy;
magn=(1/trials)*sum(Magn);
tempinvsquared=tempinv.*tempinv; %row matrix of 1/T^2
specificheat=tempinvsquared.*(energysq-energysq1); %specific heat
magnsq=magn.*magn; %row matrix of <M>^2
expmagnsq=(1/trials)*sum(magnsq); %Row Matrix of <M>^2
magnsusp=tempinv.*(magnsq-expmagnsq); %Magnetic Susceptibility = beta(<E^2>-<E>^2) and beta = 1/kT, where k=1 so 1/T(<E^2>-<E>^2)

%PolyVal and Polyfit to create a plot for the general graph 
x=0:0.1:tempf;
pEnergy=polyfit(Temp,energy,4);%calculates and plots a best fitting curve for each figure
pMag=polyfit(Temp,magn,4);
pHeat=polyfit(Temp,specificheat,4);
pMagnsusp=polyfit(Temp,magnsusp,4);
yEnergy=polyval(pEnergy,x);
yMag=polyval(pMag,x);
yHeat=polyval(pHeat,x);
yMagnsusp=polyval(pMagnsusp,x);
%The figures, and the plots for each thermodynamic variable is diplayed
%here 
figure;
S(1) = subplot(2,2,1);
S(2) = subplot(2,2,2);
S(3) = subplot(2,2,3);
S(4) = subplot(2,2,4);
%The 4 plots are displayed here 
plot(S(1),Temp,energy,'o',x,yEnergy) %yEnergy does the polyval and traces the graph 
title(S(1),'2D Energy vs. Temperature')
xlabel(S(1),'Temperature (J/k)')
ylabel(S(1),'Energy')
plot(S(2),Temp,magn,'o',x,yMag) %the additives are for the polyval values 
title(S(2),'2D Magnetization vs. Temperature')
xlabel(S(2),'Temperature (J/k)')
ylabel(S(2),'Magnetization')
plot(S(3),Temp,specificheat,'o',x,yHeat)
title(S(3), '2D Specific Heat vs. Temperature')
xlabel(S(3),'Temperature (J/k)')
ylabel(S(3),'Specific Heat')
plot(S(4),Temp,magnsusp,'o',x,yMagnsusp)
title(S(4), '2d Magnetic Susceptibility vs. Temperature')
xlabel(S(4),'Temperature (J/k)') 
ylabel(S(4),'Magnetic Susceptibility')