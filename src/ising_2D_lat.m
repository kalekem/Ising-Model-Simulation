%{
This function is similar to the 1-D Ising model, with the same equation, 
but since we consider a two dimensional shape of the magnetic system, the spins will interact with 
the spins from the top-bottom, and right-left, in a square manner. Hence, 
there are two copies of the J term; one for horizontal, and one for vertical neighbors.
%}

%prompt the user to enter the number of rows
nrows = input('Please enter the number of rows: ');
spinarr = randi(2,nrows)*2 - 3; %creates a lattice of spins. Randomly created
J=-1; %interaction energy of spins
T=0; %the value of the temperature
r=rand; %random number between 0 and 1

%{
Chooses the initial micro state and carries out a flip trial.
It also chooses a random spin inside the lattice and locates the top,
bottom, right and left neighbors
%}
for i=1:30*nrows*nrows
    randcol=randi(nrows,1);
    randrow=randi(nrows,1);
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
    
    %calculates the total energy of the 2-D system if a flip occurred
    E=J*spinarr(randrow,randcol)*spinarr(randrow,coll)+J*spinarr(randrow,randcol)*spinarr(randrow,colr)+J*spinarr(randrow,randcol)*spinarr(rowu,randcol)+J*spinarr(randrow,randcol)*spinarr(rowd,randcol);
     %if the total energy, E decreases then accept the flips
    if (E<=0)
        spinarr(randrow,randcol)=-spinarr(randrow,randcol);
    %otherwise,if the energy increases then flip the probability of p = e-(beta delta E). 
    else
        p=exp(E/T); %p, is the probabilty of the energy change, E
        if (p>=r)%accept the flips
            spinarr(randrow,randcol)=-spinarr(randrow,randcol);
        else %reject the flips
            spinarr(randrow,randcol)=spinarr(randrow,randcol);
        end
    end
end
imagesc(spinarr)%displays the scaled colored image     