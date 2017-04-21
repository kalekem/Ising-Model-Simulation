%{
This function implements the 1-D Ising model. Ising Model is a mathematical
model of ferromagnetism in statistical mechanics. The simulation uses the
metropolis algorithm. This function specifically simulates the lattice
model
%}

%Prompt the user to enter the number of rows
nrows = input('Please enter the number of rows: ');
spinarr = randi(2,1,nrows)*2 - 3; %creates a lattice of spins. Randomly created
imagesc(spinarr); %Displays the image with scaled colors of the generated spins

J=-1; %interaction energy of spins
T=3; %the value of the temperature
r=rand; %random number between 0 and 1

%Chooses the initial micro state and carries out a flip trial.
%It also chooses a random spin inside the lattice and locates the top,
%bottom, right and left neighbors
for i=1:30*nrows
    randcol=randi(nrows,1);
    randrow=randi(1,1);
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
    
    %calculates the total energy of the I-D system if a flip occurred
    E=J*spinarr(randrow,randcol)*spinarr(randrow,coll)+J*spinarr(randrow,randcol)*spinarr(randrow,colr);
    
    %if the total energy, E decreases then accept the flips
    if (E<=0) 
        spinarr(randrow,randcol)=-spinarr(randrow,randcol);
    %otherwise,if the energy increases then flip the probability of p = e-(beta delta E). 
    else
        p=exp(E/T); %the probabilty of the energy change, E
        if (p>=r) %accept the flips
            spinarr(randrow,randcol)=-spinarr(randrow,randcol);
        else %reject the flips
            spinarr(randrow,randcol)=spinarr(randrow,randcol);
        end
    end
end
figure;
imagesc(spinarr); %displays the scaled colored image
title('Spin Arrangement for 1D Model Lattice');
xlabel('Number of Rows');