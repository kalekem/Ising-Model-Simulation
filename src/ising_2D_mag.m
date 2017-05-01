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
runs=10000
trials=100
%}
nrows=input('Please enter lattice size (nrows) '); %Prompt the user to enter the number of rows
spinarr=randi(2,nrows)*2-3; %creates a lattice of just 1s and -1s
runs=input('Please enter the number of runs: ');
%Prompt the user to enter the number of runs: more runs equals more specificity, more accurate data
trials=input('Please enter the number of trials: '); 
%Prompt the user to enter the number of trials: more trials equals more
%data points
tempf=input('Please enter the Final Temperature Range you wish to investigate: '); %Prompt the user to enter the final temperate 

%Assigned Values that are embeded in the code 
J=1; %The assigned interaction energy of spins 
Temp=zeros(1,tempf*10); %Initializes the Temp Matrix to Zeros 
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
for T=0.10:0.10:tempf
    for i=1:trials+runs
        randcol=randi(nrows,1); %generates a random number between one and the number of rows and assigns it to randrow
        randrow=randi(nrows,1); %generates a random number between one and the number of rows and assigns it to randrow
        r=rand; 
        
        %Circular Spin to spin arrangment, where if the first entry is 1, then the spin is interactin with the last spin on the opposite end of 
        %the matrix (other side of the matrix)
        
        %if the chosen spin is at the left edge, it's left neighbor is on the right edge
        if (randcol==1)
            coll=nrows;
        else
            coll=randcol-1;
        end
        %if the chosen spin is at the right edge, it's right neighbor is on the left edge
        if (randcol==nrows)
            colr=1;
        else
            colr=randcol+1;
        end
        
        %if the chosen spin is on the top edge, it's neighbor is on the bottom edge
        if (randrow==1)
            rowd=nrows;
        else
            rowd=randrow-1;
        end
        
       
       %if the chosen spin is on the bottom edge, it's neighbor is on the top edge 
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
           Etot=-J*(sum(sum(Arl))+sum(sum(Adu))); %Sum of all energiesCalculates the Energy of interactions from bottom-up-and right left direction
           Energy(indexn,indexm)=Etot;
           Etotsq = Etot^2;
           ExpEnergysq(indexn,indexm)=Etotsq;
           absmagsq=absmag^2; %M^2 
           MagnSq(indexn,indexm)=absmagsq; %Matrix of M^2 values with columns = diff temps and rows = trials
        end
    end
    Index=round(10*T+1);
    Temp(Index) = T;
    tempinv(Index)= 1/T; %row matrix of 1/Ti to keep track of temperature in each individual spin
end
Temp;
%The Calculations for Energy, Magnetization, Specific Heat and Magnetic
%Suspetibility are below 
energy=(1/trials)*sum(Energy); %This computes the sum of Energy interactions throughout the matrix 
expenergysq=(1/trials)*sum(ExpEnergysq); %row of matrix of <E^2>
energysq=energy.*energy; %This is used for the specific heat further down in the code 
magn=(1/trials)*sum(Magn); %Sums up the Mangenization values to compute the final magentization of the matrix
tempinvsquared=tempinv.*tempinv; %row matrix of 1/T^2
specificheat=tempinvsquared.*(expenergysq-energysq); %specific heat calculation: 1/T (<E^2> - <E>^2)

%PolyVal and Polyfit to create a plot for the general graph 
x=0.1:0.1:tempf;
pEnergy=polyfit(Temp,energy,4);%calculates and plots a best fitting curve for each figure
pMag=polyfit(Temp,magn,4);
pHeat=polyfit(Temp,specificheat,4);
yEnergy=polyval(pEnergy,x);
yMag=polyval(pMag,x);
yHeat=polyval(pHeat,x);

%The figures, and the plots for each thermodynamic variable is diplayed
%here 
figure;
S(1) = subplot(2,2,1); %Plots the Energy of the matrix 
S(2) = subplot(2,2,2); %Plots the Magnetization of the matrix
S(3) = subplot(2,2,3); %Plots the Specific Heat of the matrix 

%The 3 plots are displayed here 
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
