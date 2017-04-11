<<<<<<< HEAD
%{
This function implements the 1-D magnetization Ising model.The simulation uses the
metropolis algorithm. 
%}

%Prompt the user to enter the number of rows
nrows = input('Please enter the number of rows: ');
trials=2000; %number of trials
runs=2000; %number of runs
=======
nrows = input('Please enter the number of rows: ');
trials=2000;
runs=2000;
>>>>>>> bf705ebf372ee67fe6b776c6b0cf3e73bae9df1c
tempf=7; %final temperature
J=1; %interaction energy of spins

temp=zeros(1,tempf*10);
Magn=zeros(trials,tempf*10); %matrix of zeros to keep values from for loop
Energy=zeros(trials,tempf*10); %matrix of zeros for the sum of energies of each spin
ExpEnergysq=zeros(trials,tempf*10); %matrix of zeros for expectation of Energy^2
for T=0:0.1:tempf
    spinarr = randi(2,1,nrows)*2 - 3;
    for i=1:trials+runs
        randcol=randi(nrows,1);
        randrow=randi(1,1);
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
        
        %total change in energy, E
        deltaE=2*J*spinarr(randrow,randcol)*(spinarr(randrow,coll)+spinarr(randrow,colr));
        
        %If total energy change is less than zero, accept the flips
        if (deltaE<=0)
            spinarr(randrow,randcol)=-spinarr(randrow,randcol);
        %otherwise, calculate the value of p. If p is greater than the value of r, then accept
        %the trials, otherwise, reject the flips
        else
            p=exp(-deltaE/T); %the probabilty of the energy change, E
            if (p>=r) %accept the flips
                spinarr(randrow,randcol)=-spinarr(randrow,randcol);
            else % reject the flips
                spinarr(randrow,randcol)=spinarr(randrow,randcol);
            end
        end
        
        if (i>runs)
            mag=sum(spinarr);%Sum of all the first column spins and the resulting row matrix
            absmag=abs(mag);%the abolute value of the magnetization 
            indexm = round(10*T+1); 
            indexn = round(i-runs);
            Magn(indexn,indexm) = absmag;
            Arl=spinarr.*circshift(spinarr,[0,-1]);%Calculates the interacton in the right-left direction --changed x, y stays constant 
            Etot=-J*(sum(sum(Arl)));
            Energy(indexn,indexm)=Etot;
            Etotsq=Etot^2;
            ExpEnergysq(indexn,indexm)=Etotsq;
        end
    end
    index=round(10*T+1);
    temp(index) = T;
end

energy=(1/trials)*sum(Energy);
expenergysq=(1/trials)*sum(ExpEnergysq); %row matrix of <E^2>
energysq=energy.*energy; %row matrix of <E>^2
magn=(1/trials)*sum(Magn);
specificheat=(expenergysq-energysq); %specific heat but need to multiply by 1/T^2*****
figure;
S(1) = subplot(3,1,1);
S(2) = subplot(3,1,2);
S(3) = subplot(3,1,3);
plot(S(1),temp,energy,'o')
title(S(1),'1D Energy vs. Temperature')
xlabel(S(1),'Temperature (J/k)')
ylabel(S(1),'Energy')
plot(S(2),temp,magn,'o')
title(S(2),'1D Magnetization vs. Temperature')
xlabel(S(2),'Temperature (J/k)')
ylabel(S(2),'Magnetization')
plot(S(3),temp,specificheat,'o')
title(S(3),'1D Specific Heat vs. Temperature')
xlabel(S(3),'Temperature (J/k)')
ylabel(S(3),'Specific Heat')