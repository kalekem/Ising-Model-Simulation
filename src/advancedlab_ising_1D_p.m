nrows = input('Please enter the number of rows: ');
spinarr = randi(2,1,nrows)*2 - 3;
imagesc(spinarr)
J+=-1;
T=3;
r=rand;
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
    E=J*spinarr(randrow,randcol)*spinarr(randrow,coll)+J*spinarr(randrow,randcol)*spinarr(randrow,colr);
    if (E>=0)
        spinarr(randrow,randcol)=-spinarr(randrow,randcol);
    else
        p=exp(E/T);
        if (p>=r)
            spinarr(randrow,randcol)=-spinarr(randrow,randcol);
        else
            spinarr(randrow,randcol)=spinarr(randrow,randcol);
        end
    end
end
imagesc(spinarr)          
            
    
