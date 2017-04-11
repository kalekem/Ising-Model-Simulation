nrows = input('Please enter the number of rows: ');
spinarr = randi(2,nrows)*2 - 3;
J=-1;
T=0;
r=rand;
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
    E=J*spinarr(randrow,randcol)*spinarr(randrow,coll)+J*spinarr(randrow,randcol)*spinarr(randrow,colr)+J*spinarr(randrow,randcol)*spinarr(rowu,randcol)+J*spinarr(randrow,randcol)*spinarr(rowd,randcol);
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